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

class ExamValidate extends Validate
{
    protected $rule = [
        'cid' => 'require',
        'property' => 'require',
        'title' => 'require',
    ];

    protected $message = [
        'cid.require' => '分类不能为空',
        'property.require'  => '试卷性质不能为空',
        'title.require' => '试卷名称不能为空',
    ];

}