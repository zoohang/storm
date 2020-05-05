<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v2\controller;

use api\v1\model\CourseModel;
use api\v1\model\DakaHomeworkModel;
use api\v1\model\DakaModel;
use api\v1\model\ExamUserlogModel;
use api\v1\model\ExamWronglistModel;
use api\v1\model\CategoryModel;
use api\v1\model\OrderModel;
use api\v1\model\UserModel;
use app\admin\model\GoodsModel;
use cmf\controller\RestUserBaseController;
use think\Db;
use think\Exception;
use think\Validate;
use tree\Tree;

class CourseController extends \api\v1\controller\CourseController
{
    protected $ctype = 3;
    // 首页信息
    public function index()
    {
        //初始化内容 获取分类
        $category = $this->getCourseCategory();
        //获取全部的内容 列表
        $list = $this->getCategoryList();
        $this->success('ok', ['category'=>$category, 'list'=>$list]);
    }

    // 获取分类
    public function getCourseCategory()
    {
        //分类信息
        $field = ['id', 'parent_id', 'name'];
        $data = CategoryModel::instance($this->ctype)->getCategoryTreeArray();
        if ($this->request->action() != strtolower(__FUNCTION__)) {
            return $data;
        } else {
            $this->success('ok', $data);
        }
    }

    // 获取分类下的视频列表
    // todo 加入人数(购买课程的人数) 打卡次数(作业提交次数) 费用
    public function getCategoryList() {
        $category_id = $this->request->param('category_id', 0, 'intval,abs');
        $where = [];
        $data = CategoryModel::instance($this->ctype)->getCategoryTreeArray($category_id);
        $ids = CategoryModel::instance($this->ctype)->getCategoryIds($data);
        $ids[] = $category_id;
        $list = [];
        if ($ids) {
            $where['a.pid'] = ['in', $ids];
            $list = CourseModel::instance()
                ->alias('a')
                ->join('__GOODS__ b', 'a.goods_id=b.goods_id')
                ->field('a.*,b.price,b.stock')
                ->where($where)->order(['a.list_order'=>'asc','a.cid'=>'desc'])->paginate()->toArray();
        }
        if ($this->request->action() != strtolower(__FUNCTION__)) {
            return $list;
        } else {
            $this->success('ok', $list);
        }
    }

    // 详情
    public function detail() {
        $id = $this->request->param('id', 0, 'intval,abs');
        if (!$id) $this->error('id必填');
        $info = CourseModel::instance()->alias('a')
            ->join('__GOODS__ b','a.goods_id=b.goods_id')
            ->field('a.*,b.price,b.stock,b.cost_price')
            ->where(['a.cid'=>$id])
            ->find();
        if(!$info) $this->error('该课程不存在');
        $field = ['item_id','item_title','parent_id', 'video_long'];
        $items = Db::name('course_item')->field($field)->where(['cid'=>$id])->select()->toArray();
        $child = [];
        foreach ($items as $item) {
            if ($item['parent_id'] == 0) {
                $child[] = $item;
            }
        }
        foreach ($child as &$tp) {
            foreach ($items as $item) {
                if ($item['parent_id'] == $tp['item_id']) {
                    $item['video_long'] = $info['type']==1 ? sec2time($item['video_long']) : '';
                    $item['jump_type'] = $info['type']==1 ? 'link' : 'rich';
                    $tp['children'][] = $item;
                }
            }
        }
        unset($tp);
        //老师信息
        $info['teachers'] = CourseModel::instance()->getRelationTeachers($id);
        //判断是否收藏成功
        $info['is_collect'] = UserModel::instance()->checkCollect($id, $this->ctype);
        //判断是否购买
        $info['is_buy'] = UserModel::instance()->checkBuy($info['goods_id']);
        $this->success('ok', ['info'=>$info, 'child'=>$child]);
    }

    // 详情-小节
    public function item() {
        $item_id = $this->request->param('item_id', 0, 'intval,abs');
        if (!$item_id) $this->error('id必填');
        $info = Db::name('course_item')->where(['item_id'=>$item_id])->find();
        if (!$info) $this->error('该课程已经下架或不存在');
        if ($info['type'] == 1) {
            $vod = Db::name('video_vod')->where(['video_id'=>$info['video_id']])->find();
            $info = array_merge($info,$vod);
        } elseif($info['type'] == 2) {
            //图文
            if ($info['description']) {
                $info['description'] = cmf_replace_content_file_url(htmlspecialchars_decode($info['description']));
            }
        }
        $this->success('ok', ['info'=>$info]);
    }

    //已经购买的课程
    public function getBuyCourse() {
        $list = CourseModel::instance()->getBugCourse();
        $this->success('ok', ['list'=>$list]);
    }

    //我收藏的课程
    public function collectionCourse() {
        $list = CourseModel::instance()->getCollectionCourse();
        $this->success('ok', ['list'=>$list]);
    }
}
