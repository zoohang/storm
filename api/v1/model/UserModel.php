<?php
// +----------------------------------------------------------------------
// | 文件说明：用户表关联model 
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: wuwu <15093565100@163.com>
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Date: 2017-7-26
// +----------------------------------------------------------------------
namespace api\v1\model;

use think\Db;
use think\Model;

class UserModel extends Model
{
    private static $instance = null;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    protected $type = [
        'more' => 'array',
    ];


    /**
     * avatar 自动转化
     * @param $value
     * @return string
     */
    public function getAvatarAttr($value)
    {
        return cmf_get_user_avatar_url($value);
    }

    public function getSexAttr($value)
    {
        switch ($value) {
            case 1:
                $value = '男';
                break;
            case 2:
                $value = '女';
                break;
            default:
                $value = '保密';
        }
        return $value;
    }

    //判断是否收藏
    public function checkCollect($id, $type) {
        $findFavoriteCount = Db::name("user_favorite")->where([
            'object_id'  => $id,
            'type' => $type,
            'user_id'    => request()->post('user_id')
        ])->count();
        return $findFavoriteCount ? 1 : 0;
    }

    //判断是否购买
    public function checkBuy($goods_id) {
        $buy = OrderModel::instance()->where(['goods_id'=>$goods_id, 'user_id'=>request()->post('user_id'), 'pay_status'=>2])->count();
        return  $buy ? 1 : 0;
    }
}
