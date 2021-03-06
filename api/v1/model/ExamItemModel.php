<?php
namespace api\v1\model;

use think\Model;

class ExamItemModel extends Model
{
    private static $instance = null;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    /**
     * [base 全局查询范围status=1显示状态]
     * @Author:   wuwu<15093565100@163.com>
     * @DateTime: 2017-05-25T21:54:03+0800
     * @since:    1.0
     */
    /*protected function base($query)
    {
        $query->where('status', 1);
    }*/

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

    public function getImageAttr($value)
    {
        return get_image_url($value);
    }

    public function getDaImageAttr($value)
    {
        return get_image_url($value);
    }
}

