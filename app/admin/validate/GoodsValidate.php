<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2018 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 小夏 < 449134904@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\validate;

use think\Validate;

class GoodsValidate extends Validate
{
    protected $rule = [
        'cost_price' => 'require',
        'price' => 'require',
        'stock' => 'require',
        'goods_type' => 'require',
        'goods_status' => 'require',
    ];

    protected $message = [
        'cost_price.require' => '原价 不能为空',
        'price.require' => '销售价 不能为空',
        'stock.require' => '库存 不能为空',
        'goods_type.require' => '商品类型 不能为空',
        'goods_status.require' => '状态 不能为空',
    ];

}