<?php
namespace api\v1\model;

use think\Db;
use think\Model;

class OrderModel extends Model
{
    private static $instance = null;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

}

