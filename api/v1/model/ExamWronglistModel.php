<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: wuwu <15093565100@163.com>
// +----------------------------------------------------------------------
namespace api\v1\model;

use think\Model;

class ExamWronglistModel extends Model
{
    private static $instance = null;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    public function getWrongCountGroupType($user_id)
    {
        return $this->field("type,count(`type`) ct")->where(['user_id'=>$user_id])->group('type')->select();
    }

    public function getOptionAttr($value)
    {
        if ($value) {
            $value = json_decode($value, true);
            $value = array_map(function($item){
                return ['answer'=>$item, 'is_active'=>0];
            }, array_values($value));
        } else {
            $value = [];
        }
        return $value;
    }
}