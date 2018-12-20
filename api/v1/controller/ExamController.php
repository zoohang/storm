<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

use api\v1\model\ExamUserlogModel;
use api\v1\model\ExamWronglistModel;
use api\v1\model\CategoryModel;
use api\v1\model\ExamItemModel;
use api\v1\model\ExamModel;
use cmf\controller\RestUserBaseController;
use think\Db;
use think\Validate;

class ExamController extends RestUserBaseController
{
    protected $ctype = 1;
    // 首页信息
    public function index()
    {
        $field = ['id', 'parent_id', 'name'];
        $cate = CategoryModel::instance($this->ctype)->field($field)->select()->toArray();

        //参考书籍 todo

        //获取题目

    }

    public function getCategoryExam() {
        $id = $this->request->param('id', 0, 'intval,abs');
        $limit = $this->request->param('limit', 10, 'intval,abs');
        $where = [];
        if ($id) $where['cid'] = $id;
        $list = ExamModel::instance()->where($where)->paginate($limit)->toArray();
        $this->success('ok', $list);
    }

    /**
     * 获取试卷的题目列表
     */
    public function getExamItemList() {
        $id = $this->request->param('id', 0, 'intval,abs');
        if (!$id) $this->error('试卷的id必填');
        $exam_info = ExamModel::instance()->where(['id'=>$id])->find()->toArray();
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
