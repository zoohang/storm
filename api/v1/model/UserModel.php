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
}
