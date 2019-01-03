<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

use api\v1\model\DakaModel;
use api\v1\model\ExamUserlogModel;
use api\v1\model\ExamWronglistModel;
use api\v1\model\CategoryModel;
use cmf\controller\RestUserBaseController;
use think\Db;
use think\Validate;

class DakaController extends RestUserBaseController
{
    protected $ctype = 2;
    // 首页信息
    public function index()
    {
        //获取题目
        $category = $this->getDakaCategory();
        //获取全部的内容 列表
        $list = $this->getCategoryList();
        $this->success('ok', ['category'=>$category, 'list'=>$list]);
    }

    // 获取分类
    public function getDakaCategory()
    {
        //分类信息
        $field = ['id', 'parent_id', 'name'];
        $data = CategoryModel::instance($this->ctype)->getCategoryTreeArray();
        if ($this->request->action() !== __FUNCTION__) {
            return $data;
        } else {
            $this->success('ok', $data);
        }
    }

    // 获取分类下的视频列表
    public function getCategoryList() {
        $category_id = $this->request->param('category_id', 0, 'intval,abs');
        $limit = $this->request->param('limit', 10, 'intval,abs');
        $where = [];
        $data = CategoryModel::instance($this->ctype)->getCategoryTreeArray($category_id);
        $ids = CategoryModel::instance($this->ctype)->getCategoryIds($data);
        $list = [];
        if ($ids) {
            $where['category_id'] = ['in', $ids];
            $list = DakaModel::instance()->where($where)->order(['list_order'=>'asc','id'=>'desc'])->paginate($limit)->toArray();
        }
        if ($this->request->action() !== __FUNCTION__) {
            return $list;
        } else {
            $this->success('ok', $list);
        }
    }

    // 打卡详情
    public function detail() {
        $id = $this->request->param('id', 0, 'intval,abs');
        if (!$id) $this->error('id必填');
        $info = DakaModel::instance()->where(['id'=>$id])->find()->toArray();
        $field = [];
        $child = DakaModel::instance()->field($field)->where(['parent_id'=>$id])->select()->toArray();
        $this->success('ok', ['info'=>$info, 'child'=>$child]);
    }

    /**
     * 获取试卷的题目列表
     */
    public function getExamItemList() {
        $id = $this->request->param('id', 0, 'intval,abs');
        if (!$id) $this->error('试卷的id必填');
        $exam_info = ExamModel::instance()->where(['id'=>$id])->find();
        if (!$exam_info) {
            $this->error('该试卷不存在, 或已经下架了');
        }
        $exam_info = $exam_info->toArray();
        $data = ExamItemModel::instance()->where(['exam_id'=>$id])->order(['list_order'=>'asc'])->select()->toArray();
        $result = [];
        $result['info'] = $exam_info;
        $result['count'] = 0;
        $result['chooseQusList'] = $result['blankQusList'] = $result['discusseQusList'] = [];
        if ($data) {
            $result['count'] = count($data);
            foreach ($data as $item) {
                if ($item['type'] == 1) {
                    $result['chooseQusList'][] = $item;
                } elseif($item['type'] == 2) {
                    $result['blankQusList'][] = $item;
                } elseif($item['type'] == 3) {
                    $result['discusseQusList'][] = $item;
                }
            }
        }
        //记录到我的刷题记录
        $exists = ExamUserlogModel::instance()->get(['user_id'=>$this->userId,'exam_id'=>$id]);
        if ($exists) {
            $exists->update_time    = NOW_TIME;
            $exists->save();
        } else {
            $add = [
                'user_id' => $this->userId,
                'exam_id' => $id,
                'title' => $exam_info['title'],
                'subtitle' => $exam_info['subtitle'],
                'property' => $exam_info['property'],
                'create_time' => NOW_TIME,
                'update_time' => NOW_TIME
            ];
            ExamUserlogModel::instance()->allowField(true)->isUpdate(false)->save($add);
        }
        //记录到我的刷题记录
        $this->success('ok', $result);
    }

    /**
     * 我的刷题记录
     */
    public function myExamLog() {
        $page = $this->request->param('page', 1, 'intval,abs');
        $limit = $this->request->param('limit', config('paginate.list_rows'), 'intval,abs');
        $where = ['user_id'=> $this->userId];
        $order = ['update_time' => 'desc'];
        $list = ExamUserlogModel::instance()->where($where)->order($order)->paginate($limit)->toArray();
        $this->success('ok', $list);
    }

    /**
     * 加入错题列表
     */
    public function addWrongList() {
        $id = $this->request->param('id', 0, 'intval,abs');
        if (!$id) $this->error('题目的id必填');
        //查询该题目所在的试卷
        $exam = ExamModel::instance()->getExamInfoByItemId($id);
        $info = [
            'user_id' => $this->userId,
            'exam_id' => $exam['id'],
            'exam_name' => $exam['title'],
            'item_id' => $exam['item_id'],
            'item_id' => $exam['item_title'],
            'type' => $exam['type'],
            'create_time' => NOW_TIME
        ];
        $res = Db::name('exam_wronglist')->insert($info);
        if ($res !== false) {
            $this->success('成功!');
        } else {
            $this->error('加入失败, 请重试!');
        }
    }

    /**
     * 查看我的错题本[列表]
     */
    public function checkMyWrongListByType() {
        $type = $this->request->param('type', 0, 'intval,abs');
        $limit = $this->request->param('type', config('paginate.list_rows'), 'intval,abs');
        $validate = new Validate([
            'type'   => 'number|between:1,3',
        ], [
            'type.number'=>'type必须是数字',
            'type.between'=>'type只能在1-3之间',
        ]);
        if (!$validate->check(['type'=>$type])) {
            $this->error($validate->getError());
        }
        $list = ExamWronglistModel::instance()
            ->where(['user_id'=>$this->userId, 'type'=>$type])
            ->order(['id'=>'desc'])
            ->paginate($limit)
            ->toArray();
        $this->success('ok', $list);
    }
}
