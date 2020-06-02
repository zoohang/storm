<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v2\controller;

use api\v1\model\UserModel;
use api\v2\model\MallModel;
use api\v2\model\OrderModel;
use cmf\controller\RestUserBaseController;
use api\v1\model\SlideItemModel;
use api\v2\model\CategoryModel;
use mindplay\annotations\standard\VarAnnotation;

class MallController extends RestUserBaseController
{
    // 首页信息
    public function index()
    {
        //轮播图
        $slide = SlideItemModel::instance()->getOne(4);//id=4
        //分类列表
        $field = ['id', 'parent_id', 'name'];
        $categorys = CategoryModel::instance(MallModel::$ctype)->getFirstLevelCategory();
        //初始化的商品列表
        $list = $this->getList(0,0,15);
        $data = [
            'slide'=>$slide,
            'categorys'=>$categorys,
            'mall_types'=> MallModel::instance()->getMallTypeList(),
            'list'=>$list,
        ];
        $this->success('ok', $data);
    }

    // 筛选商品列表
    public function getList($cid=0, $mall_type=0, $limit=10) {
        $cid = $cid ?: $this->request->param('cid', 0, 'intval,abs,trim');
        $mall_type = $mall_type ?: $this->request->param('mall_type', 0, 'intval,abs,trim');
        $cid = trim($cid,',');
        $mall_type = trim($mall_type,',');
        $model = new MallModel;
        $where = [];
        if ($cid != 0) {
            $where['cid'] = ['IN', explode(',', trim($cid, ','))];
        }
        if ($mall_type != 0) {
            $where['mall_type'] = ['IN', explode(',', trim($mall_type, ','))];
        }
        $list = $model
            ->field(MallModel::$list_field)
            ->where($where)
            ->order(['list_order'=>'asc', 'published_time'=>'desc'])
            ->cache(true, 60)
            ->paginate($limit)->toArray();
        foreach ($list['data'] as &$item) {
            $item['thumbnail_200'] = get_image_url($item['thumbnail'], 200);
            $item['thumbnail_480'] = get_image_url($item['thumbnail'], 480);
            unset($item['thumbnail']);
        }
        if ($this->request->action() != strtolower(__FUNCTION__)) {
            return $list['data'];
        } else {
            $this->success('ok', $list);
        }
    }

    // 获取商品详情
    public function detail() {
        $id = $this->request->param('id', 0, 'intval,abs');
        if (!$id) $this->error('id必填');
        $info = MallModel::instance()->alias('a')
            ->field(array_merge(MallModel::$detail_field, ['b.price', 'b.stock', 'b.cost_price']))
            ->join('__GOODS__ b','a.goods_id=b.goods_id')
            ->where(['a.id'=>$id])
            ->find();
        if(!$info) $this->error('该资源不存在');
        //获取相关的内容 规则相同栏目下的资源
        $relation = MallModel::instance()->getRelationList($info['cid'], $id);
        //判断是否收藏成功
        $info['is_collect'] = UserModel::instance()->checkCollect($id, MallModel::$ctype);
        //判断是否购买
        $info['is_buy'] = UserModel::instance()->checkBuy($info['goods_id']);
        //if (!$info['is_buy']) $info->download_addr = ''; //考虑安全 没有购买就不显示下载地址
        if ($info['is_buy']) {
            $info->download = baiduLinkFormat($info->download_addr);
        } else {
            $info->download_addr = '';
            $info->download = [];
        }
        $this->success('ok', ['info' => $info, 'relation' => $relation]);
    }

    //获取用户已经购买的商品
    public function mallBuyLog($limit=10) {
        $data = OrderModel::instance()->alias('a')
            ->field(['b.id','b.post_title'=>'title','b.post_subtitle'=>'subtitle','a.pay_time'=>'pay_time_format'])
            ->join('__MALL__ b', 'a.goods_id=b.goods_id')
            ->where(['a.order_status'=>1, 'a.pay_status'=>2, 'a.user_id'=>$this->userId])
            ->order('a.pay_time', 'desc')
            ->paginate($limit);
        $this->success('ok', $data);
    }

}
