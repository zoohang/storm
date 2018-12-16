<?php

namespace api\v1\model;

use think\Model;

class FeedbackModel extends Model
{
    private static $instance = null;
    protected $autoWriteTimestamp = true;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    /**
     * 1-功能建议 2-课程建议 3-程序错误
     * @param $value
     * @return string
     */
    public function getTypeAttr($value)
    {
        switch ($value) {
            case 1:
                $value = '功能建议';
                break;
            case 2:
                $value = '课程建议';
                break;
            case 3:
                $value = '程序错误';
                break;
            default:
                $value = '其他';
        }
        return $value;
    }

    /**
     * 1-功能建议 2-课程建议 3-程序错误
     * @param $value
     * @return string
     */
    public function setTypeAttr($value)
    {
        switch ($value) {
            case '功能建议':
                $value = 1;
                break;
            case '课程建议':
                $value = 2;
                break;
            case '程序错误':
                $value = 3;
                break;
            default:
                $value = 0;
        }
        return $value;
    }

}

