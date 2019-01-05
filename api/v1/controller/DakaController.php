<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

use api\v1\model\DakaHomeworkModel;
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
        //初始化内容 获取分类
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
        $field = ['id','post_title'];
        $child = DakaModel::instance()->field($field)->where(['parent_id'=>$id])->select()->toArray();
        $this->success('ok', ['info'=>$info, 'child'=>$child]);
    }

    // 打卡详情-小节
    public function item() {
        $id = $this->request->param('id', 0, 'intval,abs');
        if (!$id) $this->error('id必填');
        $info = DakaModel::instance()->where(['id'=>$id])->find();
        if (!$info) $this->error('该课程已经下架或不存在');
        $user_data = DakaHomeworkModel::instance()->where(['user_id'=>$this->userId, 'daka_id'=>$id])->select();
        $this->success('ok', ['info'=>$info->toArray(), 'user_data'=>$user_data]);
    }

    //提交打卡作业
    // 打卡 小节id 上传文件地址  追加的文字描述
    // ['daka_id'=>1, 'images'=>[1,2,3],'message'=>'111']
    public function submitHomeWork() {
        $data = $this->request->post();
        $result = $this->validate($data, 'DakaHomework');
        if ($result !== true) {
            $this->error($result);
        }
        $res = DakaHomeworkModel::instance()->allowField(true)->isUpdate(false)->save($data);
        if ($res !== false) {
            $this->success('ok');
        } else {
            $this->error('上传失败, 请重试');
        }
    }

    //添加收藏 打卡
    public function addCollect() {
        //拼接好数据 调用公共收藏方法
        $id = $this->request->param('id', 0, 'intval,abs');
        $info = DakaModel::get($id);
        $url = cmf_url_encode('v1/daka/detail', ['id'=>$id]);
        $data = [
            'id' => $id,
            'title' => $info['post_title'],
            'table' => 'daka',
            'url'   => $url,
            'type'  => 2
        ];
        $result = $this->validate($data, 'Favorite');
        if ($result !== true) {
            $this->error($result);
        }
        $this->collect($data);
    }


    public function bugDaka() {
        //todo 购买打卡课程
    }
}
