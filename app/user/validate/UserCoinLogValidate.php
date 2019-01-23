<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2018 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: Powerless < wzxaini9@gmail.com>
// +----------------------------------------------------------------------
namespace app\user\validate;

use think\Validate;

class UserCoinLogValidate extends Validate
{
    protected $rule = [
        'user_id'    => 'require',
        'change' => 'require',
        'description'   => 'require',
        'remark'   => 'require',
    ];
    protected $message = [
        'user_id.require'    => '用户id不能为空!',
        'change.require' => '更改余额不能为空!',
        'description.require' => '描述不能为空!',
        'remark.require'   => '备注不能为空!',
    ];

}