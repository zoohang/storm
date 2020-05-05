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
use cmf\controller\RestUserBaseController;
use api\v1\model\SlideItemModel;
use api\v2\model\CategoryModel;

class MallController extends RestUserBaseController
{
    // 首页信息
    public function index()
    {
        //轮播图
        $slide = SlideItemModel::instance()->getOne(1);//id=4
        //分类列表
        $field = ['id', 'parent_id', 'name'];
        $categorys = CategoryModel::instance(MallModel::$ctype)->getSimpleCategoryTreeArray();
        //初始化的商品列表
        $list = $this->getList();
        $data = [
            'slide'=>$slide,
            'categorys'=>$categorys,
            'list'=>$list,
        ];
        $this->success('ok', $data);
    }

    // 筛选商品列表
    public function getList($cid=0, $p=1) {
        $model = new MallModel;
        $where = [];
        if ($cid > 0) {
            $data = CategoryModel::instance(MallModel::$ctype)->getCategoryTreeArray($cid);
            $ids = CategoryModel::instance(MallModel::$ctype)->getCategoryIds($data);
            array_unshift($ids, $cid);
            $where['cid'] = ['IN', $ids];
        }
        $list = $model
            ->field(MallModel::$list_field)
            ->where($where)
            ->order(['list_order'=>'asc', 'published_time'=>'desc'])
            ->page($p)
            ->cache(true, 60)
            ->select();
        foreach ($list as &$item) {
            $item['thumbnail_200'] = get_image_url($item['thumbnail'],200);
            $item['thumbnail_480'] = get_image_url($item['thumbnail'],480);
        }
        unset($item);
        if ($this->request->action() != strtolower(__FUNCTION__)) {
            return $list;
        } else {
            $this->success('ok', $list);
        }
    }

    // 获取商品详情
    public function detail() {
        $id = $this->request->param('id', 0, 'intval,abs');
        if (!$id) $this->error('id必填');
        //todo 字段需要rewrite
        $info = MallModel::instance()->alias('a')
            ->join('__GOODS__ b','a.goods_id=b.goods_id')
            ->field('a.*,b.price,b.stock,b.cost_price')
            ->where(['a.id'=>$id])
            ->find();
        if(!$info) $this->error('该资源不存在');

        //判断是否收藏成功
        $info['is_collect'] = UserModel::instance()->checkCollect($id, MallModel::$ctype);
        //判断是否购买
        $info['is_buy'] = UserModel::instance()->checkBuy($info['goods_id']);
        $this->success('ok', $info);
    }

}
