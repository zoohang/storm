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

class ExamItemValidate extends Validate
{
    protected $rule = [
        'exam_id' => 'require',
        'item_title' => 'require',
        'type' => 'require',
        'answer' => 'require',
    ];

    protected $message = [
        'exam_id.require' => '试卷id不能为空',
        'item_title.require'  => '题目名称不能为空',
        'type.require' => '题目类型不能为空',
        'answer.require' => '题目答案不能为空',
    ];

}