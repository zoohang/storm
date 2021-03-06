<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v2\controller;

use api\v2\model\CourseModel;
use api\v2\model\CategoryModel;
use api\v1\model\OrderModel;
use api\v1\model\SlideItemModel;
use api\v1\model\UserModel;
use app\admin\model\GoodsModel;
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

    // 详情-小节
    public function item() {
        $item_id = $this->request->param('item_id', 0, 'intval,abs');
        if (!$item_id) $this->error('id必填');
        $info = Db::name('course_item')->field(CourseModel::$item_field)->where(['item_id'=>$item_id])->find();
        if (!$info) $this->error('该课程已经下架或不存在');
        if ($info['type'] == 1) {
            $vod = Db::name('video_vod')->field('video_url')->where(['video_id'=>$info['video_id']])->find();
            $info = array_merge($info,$vod);
            $info['video_long'] = sec2time($info['video_long']);
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
        $list = CourseModel::instance()->getBugVideoCourse($this->userId);
        $this->success('ok', ['list'=>$list]);
    }

    //我收藏的课程
    public function collectionCourse() {
        $list = CourseModel::instance()->getCollectionVideoCourse($this->userId);
        $this->success('ok', ['list'=>$list]);
    }

    //视频主页
    public function videoMain() {
        //轮播图
        $slide = SlideItemModel::instance()->getOne(5);//id=5
        //初始化内容 获取分类
        $category = CategoryModel::instance($this->ctype)->getFirstLevelCategory();
        //获取全部的内容 列表
        $course_types = CourseModel::instance()->getCourseTypeList();
        $level = CourseModel::$levels;
        $list = $this->videoList(0,0,0,15);
        $this->success('ok', compact('slide', 'category', 'course_types', 'level', 'list'));
    }

    //视频列表
    public function videoList($cid=0, $course_type=0, $level='',$limit=10) {
        $cid = $cid ?: $this->request->param('cid', 0, 'intval,abs,trim');
        $course_type = $course_type ?: $this->request->param('course_type', 0, 'intval,abs,trim');
        $cid = trim($cid,',');
        $course_type = trim($course_type,',');
        $level = $level ?: $this->request->param('level');
        $list = [];
        $where = ['type'=>1];
        if ($cid) {
            $where['pid'] = ['in', explode(',', $cid)];
        }
        if ($course_type) {
            $where['course_type'] = ['in', explode(',', $course_type)];
        }
        if (!in_array($level, [null, '', 0])) $where['level'] = $level;
        $list = CourseModel::instance()
            ->field(CourseModel::$list_field)
            ->where($where)
            ->order(['list_order'=>'asc','cid'=>'desc'])
            ->cache(true, 60)
            ->paginate($limit)->toArray();
        foreach ($list['data'] as &$item) {
            $item['thumbnail_200'] = get_image_url($item['thumbnail'], 200);
            $item['thumbnail_480'] = get_image_url($item['thumbnail'], 480);
            unset($item['thumbnail']);
        }
        unset($item);
        if ($this->request->action() != strtolower(__FUNCTION__)) {
            return $list['data'];
        } else {
            $this->success('ok', $list);
        }
    }

    //视频详情页
    public function videoDetail() {
        $id = $this->request->param('id', 0, 'intval,abs');
        if (!$id) $this->error('id必填');
        $info = CourseModel::instance()->alias('a')
            ->join('__GOODS__ b','a.goods_id=b.goods_id')
            ->field(array_merge(CourseModel::$deteil_field, ['b.price','b.stock','b.cost_price']))
            ->where(['a.cid'=>$id])
            ->find();
        if(!$info) $this->error('该课程不存在');
        //章节信息
        $items = $this->getCourseItems($id);
        //老师信息
        $info['teachers'] = CourseModel::instance()->getRelationTeachers($id);
        //判断是否收藏成功
        $info['is_collect'] = UserModel::instance()->checkCollect($id, $this->ctype);
        //判断是否购买
        $info['is_buy'] = UserModel::instance()->checkBuy($info['goods_id']);
        //相关信息
        $relation = CourseModel::instance()->getRelationList($info['cid'], $id, 6);
        $this->success('ok', ['info'=>$info, 'child'=>$items, 'relation'=>$relation]);
    }

    public function videoItem($item_id) {
        $item_id = $this->request->param('item_id', 0, 'intval,abs');
        if (!$item_id) $this->error('id必填');
        $info = Db::name('course_item')->alias('a')
            ->join('__COURSE__ b', 'a.cid=b.cid')
            ->field(array_merge(CourseModel::$item_field, ['b.ctitle'=>'title']))
            ->where(['item_id'=>$item_id, 'a.status'=>1])
            ->find();
        if (!$info) $this->error('该课程已经下架或不存在');

        $vod = Db::name('video_vod')->field('video_url, source_url')->where(['video_id'=>$info['video_id']])->find();
        $vod['video_url'] = $vod['video_url'] ?: $vod['source_url'];
        unset($vod['source_url']);
        $info = array_merge($info,$vod);
        $info['video_long'] = sec2time($info['video_long']);
        //章节信息
        $child = $this->getCourseItems($info['id']);
        $this->success('ok', compact('info', 'child'));
    }

    protected function getCourseItems($id) {
        $field = ['item_id','item_title'];
        return Db::name('course_item')
            ->field($field)
            ->where(['cid'=>$id, 'status'=>1, 'type'=>['GT', 0]])
            ->order(['list_order'=>'desc','item_id'=>'asc'])
            ->select()->toArray();
    }
}
