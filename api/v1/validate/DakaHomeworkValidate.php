<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 小夏 < 449134904@qq.com>
// +----------------------------------------------------------------------
namespace api\v1\validate;

use think\Validate;

class DakaHomeworkValidate extends Validate
{
    protected $rule = [
        'daka_id'        =>  'require',
	    'images'      =>  'require',
	    'message'        =>  'require'
    ];
    protected $message = [
        'daka_id.require'    =>  '打卡课程id不能为空',
	    'images.require'  =>  '图片不能为空',
	    'message.require'    =>  '作业描述不能为空'
    ];

}