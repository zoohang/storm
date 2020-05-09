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

    protected $autoWriteTimestamp = true;

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
}