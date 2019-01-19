<?php
namespace api\v1\model;

use think\Db;
use think\Model;

class DakaHomeworkModel extends Model
{
    protected $insert = ['user_id','dtype'=>1];
    protected $autoWriteTimestamp = true;

    private static $instance = null;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    public function getImagesAttr($value)
    {
        $imgs =  htmlspecialchars_decode($value);
        $imgs = json_decode($imgs, true);
        foreach ($imgs as &$img) {
            $img = oss_img_pre($img);
        }
        unset($img);
        return json_encode($imgs);
    }

    protected function setUserIdAttr()
    {
        return request()->post('user_id');
    }

    protected function setDakaParentIdAttr()
    {
        $daka_id = request()->param('daka_id');
        $data = Db::name('Daka')->where(['id'=>$daka_id])->find();
        return $data['parent_id'];
    }
}

