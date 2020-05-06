<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v2\controller;

use think\Db;

class OrderController extends \api\v1\controller\OrderController
{
    public function goodsInfo() {
        $goods_id = $this->request->param('goods_id', 0, 'intval,abs');
        $field = ['goods_id, goods_name, image, cost_price', 'price', 'stock', 'goods_type'];
        $res = Db::name('goods')->field($field)->where(['goods_id'=>$goods_id, 'goods_status'=>1])->cache(true, 10)->find();
        $res['image'] = get_image_url($res['image'],480);
        $res['goods_type_name'] = \app\admin\model\CategoryModel::$category_type[$res['goods_type']];
        if ($res) {
            $this->success('ok', $res);
        } else {
            $this->error('商品信息不存在或者已下架');
        }
    }
}
