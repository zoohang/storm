<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2018 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 小夏 < 449134904@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\validate;

use think\Validate;

class CourseValidate extends Validate
{
    protected $rule = [
        'ctitle' => 'require',
        'tid' => 'require',
        'pid' => 'require',
        'pname' => 'require',
        'description' => 'require',
        'course_type' => 'require',
        'image' => 'require',
        'course_type|专业类型' => 'require|number|gt:0',
    ];

    protected $message = [
        'ctitle.require' => '课程名称不能为空',
        'tid.require' => '讲师不能为空',
        'pid.require' => '课程分类id不能为空',
        'pname.require' => '课程分类名称不能为空',
        'description.require'  => '描述不能为空',
        'course_type.require' => '课程类型不能为空',
        'image.require' => '图片不能为空',
    ];

}