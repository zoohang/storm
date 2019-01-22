<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

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

class CourseController extends RestUserBaseController
{
    protected $ctype = 3;
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
        $info = Db::name('course a')
            ->join('__GOODS__ b','a.goods_id=b.goods_id')
            ->field('a.*,b.price,b.stock')
            ->where(['a.cid'=>$id])
            ->find();
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
                    $tp['children'][] = $item;
                }
            }
        }
        unset($tp);
        //老师信息
        // todo 接口待调试
        Db::name('course_teacher_relation a')->join('__COURSE_TEACHERS__ b', 'a.tid=b.tid')->field(['b.tid', 'b.tname', 'b.summary', 'b.description', 'b.avatar'])->where(['a.cid'=>$id, 'a.status'=>1, 'b.status'=>1])->select();
        //判断是否收藏成功
        $findFavoriteCount = Db::name("user_favorite")->where([
            'object_id'  => $id,
            'table_name' => 'daka',
            'user_id'    => $this->userId
        ])->count();
        $info['is_collect'] = $findFavoriteCount ? 1 : 0;
        //判断是否购买
        $buy = OrderModel::instance()->where(['goods_id'=>$info['goods_id'], 'user_id'=>$this->userId, 'pay_status'=>2])->count();
        $info['is_buy'] = $buy ? 1 : 0;
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
        }
        $this->success('ok', ['info'=>$info]);
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
        Db::startTrans();
        try{
            $info = Db::name('Daka')->where(['id'=>$daka_id])->find();
            $data['daka_parent_id'] = $info['parent_id'];
            $res = DakaHomeworkModel::instance()->allowField(true)->isUpdate(false)->save($data);
            DakaModel::instance()->where(['id'=>$info['parent_id']])->inc('daka_num');
            Db::commit();
        } catch (\Exception $e) {
            Db::rollback();
            $this->error('点赞失败！');
        }
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

    public function deleteCollect() {
        $id = $this->request->param('id', 0, 'intval,abs');
        $data = [
            'id' => $id,
            'table' => 'daka',
        ];
        $this->delCollect($data);
    }

    // 我的画图打卡[列表]
    public function alreadyBuyDaka() {
        $where = ['a.user_id'=>$this->userId, 'a.pay_status'=>2];
        $field = ['c.id','c.post_title', 'c.thumbnail', 'c.join_num', 'c.published_time start_time', 'c.end_time'];
        $list = Db::name('order a')
            ->join('__DAKA__ c', 'a.goods_id=c.goods_id')
            ->where($where)
            ->field($field)
            ->order('a.order_id desc')
            ->paginate()
            ->toArray();
        $daka_ids = array_column($list['data'], 'id');
        $item_nums = Db::name('daka')->where(['parent_id'=>['in', $daka_ids]])->field('parent_id,count(*) count')->group('parent_id')->select();
        $homework_nums = Db::name('daka_homework')->where(['daka_parent_id'=>['in', $daka_ids]])->field('daka_parent_id,count(*) count')->group('daka_parent_id')->select();
        foreach ($list['data'] as &$item) {
            $item['thumbnail'] = get_image_url($item['thumbnail']);
            $item['item_num'] = 0;
            foreach ($item_nums as $it) {
                if ($item['id'] == $it['parent_id']) {
                    $item['item_num'] = $it['count'];
                    continue;
                }
            }
            $item['hk_num'] = 0;
            foreach ($homework_nums as $hk) {
                if ($item['id'] == $hk['daka_parent_id']) {
                    $item['hk_num'] = $hk['count'];
                    continue;
                }
            }
        }
        unset($item);
        $this->success('success', $list);
    }

    //我的画图打卡内容详细item列表
    public function alreadyBuyDakaItem() {
        // select a.id, a.post_title,b.id hk_id,b.status from st_daka a
        //left join st_daka_homework b on a.id=b.daka_id and b.dtype=1 and b.user_id=2
        // where a.parent_id=1
        $daka_id = $this->request->param('daka_id', 0, 'intval,abs');
        if (!$daka_id) $this->error('打卡id必填');
        $info = DakaModel::instance()->where(['id'=>$daka_id])->find();
        $list = Db::name('daka a')
            ->join('__DAKA_HOMEWORK__ b', "a.id=b.daka_id and b.dtype=1 and b.user_id={$this->userId}", 'left')
            ->field('a.id, a.post_title,b.id hk_id,b.status')
            ->where(['a.parent_id'=>$daka_id, 'a.post_status'=>1])
            ->order('a.list_order asc, a.id asc')
            ->select()->toArray();
        foreach ($list as &$item) {
            $item['start_time'] = $info['published_time'];
            $item['end_time'] = $info['end_time'];
            if ($item['hk_id'] && $item['status']==1) {
                $item['status_str'] = 1;
            } elseif($item['hk_id'] && $item['status']==2){
                $item['status_str'] = 2;
            } elseif(is_null($item['hk_id'])) {
                $item['status_str'] = 0;
            }
            unset($item['hk_id'], $item['status']);
        }
        unset($item);
        $this->success('success', $list);
    }
}
