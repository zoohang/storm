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

class CourseTeacherValidate extends Validate
{
    protected $rule = [
        'tname' => 'require',
        'summary' => 'require',
        'avatar' => 'require',
        'status' => 'require',
    ];

    protected $message = [
        'tname.require' => '讲师名字不能为空',
        'summary.require'  => '简述不能为空',
        'avatar.require' => '图片不能为空',
        'status.require' => '状态不能为空',
    ];

}