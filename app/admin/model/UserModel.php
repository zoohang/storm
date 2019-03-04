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

class UserModel extends Model
{

    protected $type = [
        'more' => 'array',
    ];

    public function getDakaTeacherList() {
        return $this->alias('a')
            ->join('__ROLE_USER__ b', 'a.id=b.user_id')
            ->field('a.id, a.user_login, a.avatar,a.user_email,a.user_nickname')
            ->where(['b.role_id'=>3, 'a.user_type'=>1, 'a.user_status'=>1])
            ->order(['a.id'=>'desc'])
            ->select()
            ->toArray();
    }
}