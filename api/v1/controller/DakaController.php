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
use api\v1\model\OrderModel;
use api\v1\model\UserModel;
use app\admin\model\GoodsModel;
use cmf\controller\RestUserBaseController;
use think\Db;
use think\Exception;
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
        if ($this->request->action() != strtolower(__FUNCTION__)) {
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
        $ids[] = $category_id;
        $list = [];
        if ($ids) {
            $where['a.category_id'] = ['in', $ids];
            $list = DakaModel::instance()
                ->alias('a')
                ->join('__GOODS__ b', 'a.goods_id=b.goods_id')
                ->field('a.*,b.price,b.stock')
                ->where($where)->order(['a.list_order'=>'asc','a.id'=>'desc'])->paginate($limit)->toArray();
        }
        if ($this->request->action() != strtolower(__FUNCTION__)) {
            return $list;
        } else {
            $this->success('ok', $list);
        }
    }

    // 打卡详情
    public function detail() {
        $id = $this->request->param('id', 0, 'intval,abs');
        if (!$id) $this->error('id必填');
        $info = DakaModel::instance()->alias('a')
            ->join('__GOODS__ b','a.goods_id=b.goods_id')
            ->field('a.*,b.price,b.stock,b.cost_price')
            ->where(['id'=>$id])->find()->toArray();
        $field = ['id','post_title'];
        $child = Db::name('daka')->field($field)->where(['parent_id'=>$id])->select();
        //判断是否收藏成功
        $info['is_collect'] = UserModel::instance()->checkCollect($id, $this->ctype);
        //判断是否购买
        $info['is_buy'] = UserModel::instance()->checkBuy($info['goods_id']);

        $this->success('ok', ['info'=>$info, 'child'=>$child]);
    }

    // 打卡详情-小节
    public function item() {
        $id = $this->request->param('id', 0, 'intval,abs');
        if (!$id) $this->error('id必填');
        $info = DakaModel::instance()->where(['id'=>$id])->find();
        if (!$info) $this->error('该课程已经下架或不存在');
        $user_data = DakaHomeworkModel::instance()->where(['user_id'=>$this->userId, 'daka_id'=>$id])->select()->toArray();
        $is_upload = $user_data ? 1: 0;
        $this->success('ok', ['info'=>$info->toArray(), 'user_data'=>$user_data, 'is_upload'=>$is_upload]);
    }

    //提交打卡作业
    // 打卡 小节id 上传文件地址  追加的文字描述
    // ['daka_id'=>1, 'images'=>[1,2,3],'message'=>'111']
    public function submitHomeWork() {
        $data = $this->request->param();
        $result = $this->validate($data, 'DakaHomework');
        if ($result !== true) {
            $this->error($result);
        }
        Db::startTrans();
        try{
            $info = Db::name('Daka')->where(['id'=>$data['daka_id']])->find();
            $data['daka_parent_id'] = $info['parent_id'];
            $res = DakaHomeworkModel::instance()->allowField(true)->isUpdate(false)->save($data);
            DakaModel::instance()->where(['id'=>$info['parent_id']])->setInc('daka_num');
            Db::commit();
        } catch (\Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        if ($res !== false) {
            $this->success('ok');
        } else {
            $this->error('上传失败, 请重试');
        }
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
