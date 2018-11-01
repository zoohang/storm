<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

use cmf\controller\RestBaseController;
use wxapp\aes\WXBizDataCrypt;

class UserController extends RestBaseController
{
    // 获取用户信息
    public function getUserInfo()
    {
        return json(['name'=>111], 200, ['power_by'=>111]);
    }

}
