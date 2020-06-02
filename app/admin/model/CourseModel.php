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

class CourseModel extends Model
{
    private static $instance = null;
    public $courseTypeList = [
        '请选择课程类型',
        '考研理论',
        '考研快题',
        '快题思维',
        '快题表达',
        '手绘表达',
        '软件技能',
        '竞赛',
        '留学',
        '免费课程',
    ];
    protected $autoWriteTimestamp = true;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }
    public function getTypeNameAttr($value,$data)
    {
        $type = [0=>'全部',1=>'视频',2=>'图文'];
        return $type[$data['type']];
    }

    public function setPnameAttr($value)
    {
        $search = [' ',' ','│', '├─', '└─','─'];
        return str_replace($search, '', $value);
    }

    public function getMoreAttr($value)
    {
        return json_decode($value, true);
    }

    public function setMoreAttr($value)
    {
        return json_encode($value, JSON_UNESCAPED_SLASHES|JSON_UNESCAPED_UNICODE);
    }

    protected function getCourseTypeNameAttr($value, $data) {
        return $this->courseTypeList[$data['course_type']];
    }
}