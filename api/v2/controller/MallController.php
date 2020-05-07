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
        $list = $this->getList(0,1,15);
        $data = [
            'slide'=>$slide,
            'categorys'=>$categorys,
            'list'=>$list,
        ];
        $this->success('ok', $data);
    }

    // 筛选商品列表
    public function getList($cid=0, $p=1, $limit=10) {
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
            ->paginate($limit);
        if ($this->request->action() != strtolower(__FUNCTION__)) {
            return $list->items();
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

}
