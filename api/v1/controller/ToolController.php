<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

use cmf\controller\RestUserBaseController;

class ToolController extends RestUserBaseController
{
    public function getStsToken() {
        $sts = new \Stshandle();
        $token = $sts->getToken();
        $this->success('ok', $token);
    }

}
