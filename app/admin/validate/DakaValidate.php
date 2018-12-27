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

class DakaValidate extends Validate
{
    protected $rule = [
        'category_id' => 'require',
        'post_title' => 'require'
    ];

    protected $message = [
        'category_id.require' => '分类必须选择',
        'post_title.require' => '标题不能为空'
    ];

}