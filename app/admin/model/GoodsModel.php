<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2018 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 老猫 <thinkcmf@126.com>
// +----------------------------------------------------------------------
namespace app\admin\model;

use think\Model;

class GoodsModel extends Model
{

    protected $autoWriteTimestamp = true;

    private static $instance = null;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    public function editGoods($goods, $data, $type) {
        $data = array_merge($goods, $data, ['goods_type'=>$type]);
        $isUpdate = $goods['goods_id'] ? true : false;
        $this->isUpdate($isUpdate)->allowField(true)->save($data);
        return $this->goods_id;
    }

    public function getGoods() {

    }
}