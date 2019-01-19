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
    // todo 加入人数(购买课程的人数) 打卡次数(作业提交次数) 费用
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
        $info = DakaModel::instance()->where(['id'=>$id])->find()->toArray();
        $field = ['id','post_title'];
        $child = DakaModel::instance()->field($field)->where(['parent_id'=>$id])->select()->toArray();
        //判断是否收藏成功
        $findFavoriteCount = Db::name("user_favorite")->where([
            'object_id'  => $id,
            'table_name' => 'daka',
            'user_id'    => $this->userId
        ])->count();
        $info['is_collect'] = $findFavoriteCount ? 1 : 0;
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


    public function bugDaka() {
        //todo 购买打卡课程
        $goods_id = $this->request->param('goods_id', 0, 'intval,abs');
        $daka_id = $this->request->param('goods_id', 0, 'intval,abs');
        if (!$goods_id) $this->error('这个商品已经下架');
        if (!$daka_id) $this->error('打卡课程id必填');
        $goods_info = GoodsModel::instance()->where(['goods_id'=>$goods_id])->find();
        $data = [
            'order_sn' => build_order_no(),
            'user_id' => $this->userId,
            'user_name' => $this->user['user_nickname'],
            'goods_id' => $goods_id,
            'goods_amount' => $goods_info['price'],
            'pay_fee' => $goods_info['price'],
            'pay_time' => NOW_TIME,
            'order_status' => 1,
            'pay_status' => 2,
        ];
        Db::startTrans();
        try {
            $user_info = UserModel::instance()->where(['id'=>$this->userId])->find();
            if ($user_info['coin'] < $goods_info['price']) throw new \Exception("你剩余的图币不够{$goods_info['price']}");
            $res = OrderModel::instance()->data($data)->isUpdate(false)->allowField(true)->save();
            UserModel::instance()->where(['id'=>$this->userId])->dec('coin', $goods_info['price']);
            DakaModel::instance()->where(['id'=>$daka_id])->inc('join_num');
            Db::commit();
        } catch (\Exception $e) {
            Db::rollback();
            $this->error($e->getMessage());
        }
        $this->success('购买成功!');
    }
}
