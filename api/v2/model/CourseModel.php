<?php
namespace api\v2\model;

use think\Db;
use think\Model;

class CourseModel extends \api\v1\model\CourseModel
{
    private static $instance = null;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    public static $levels = [
        ['id'=>0, 'name'=>'无等级'],
        ['id'=>1, 'name'=>'初级'],
        ['id'=>2, 'name'=>'中级'],
        ['id'=>3, 'name'=>'高级'],
    ];

    public static $list_field = [
        'cid' => 'id',
        'ctitle' => 'title',
        'pid' => 'cid',
        'pname'=> 'cname',
        'level',
        'image'=>'thumbnail',
    ];

    /*public function getThumbnailAttr($value,$data)
    {
        return get_image_url($data['thumbnail']);
    }*/
}

