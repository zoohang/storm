<?php
/**
 * Title:
 * User: YUAN
 * Date: 2018/12/12
 * Time: 23:30
 */

namespace api\v1\controller;


use app\base\model\VodModel;
use cmf\controller\RestBaseController;

class TestController
{
    public function index() {
        $res = VodModel::getInstance()->create_upload_image();
        dump($res);
        //return json([111]);
    }
}