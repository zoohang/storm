<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

use api\v1\model\DakaHomeworkModel;
use api\v1\model\DakaModel;
use api\v1\model\ExamUserlogModel;
use api\v1\model\ExamWronglistModel;
use api\v1\model\CategoryModel;
use api\v1\model\OrderModel;
use api\v1\model\UserModel;
use app\admin\model\GoodsModel;
use cmf\controller\RestUserBaseController;
use think\Db;
use think\Exception;
use think\Validate;

class OrderController extends RestUserBaseController
{
    public function buy() {
        $goods_id = $this->request->param('goods_id', 0, 'intval,abs');
        $res = OrderModel::instance()->buy($goods_id);
        if ($res === true) {
            $this->success('购买成功!');
        } else {
            $this->error($res['message']);
        }
    }
}
