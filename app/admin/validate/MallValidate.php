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

class MallValidate extends Validate
{
    protected $rule = [
        'post_title|标题' => 'require|max:30',
        'post_content|内容' => 'require',
        'type|类型' => 'require|number|in:1,2',
        'thumbnail|缩略图' => 'require',
        'post_image|图片' => 'require',
    ];

}