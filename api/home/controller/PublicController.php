<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\home\controller;

use think\Db;
use think\Validate;
use cmf\controller\BaseController;

class PublicController extends BaseController
{
    protected $rule = [
        'name|姓名' => 'require|chsAlphaNum|length:1,10',
        'menu|菜单' => 'require',
        'sign|签名' => 'require',
        'money|金额' => 'require',
        'note|备注' => 'require|max:256',
        'update|修改要求' => 'require',
        'finish|是否完成' => 'require|in:0,1',
        'times|修改剩余次数' => 'require',
    ];

    /**
     * ffw sign page
     * @return \think\response\Jsonp
     */
    public function signWrite() {
        $data = $this->request->param();
        //var_dump($data);
        $validate = new Validate($this->rule);
        if (!$validate->check($data)) {
            return jsonp(['data'=>[],'code'=>401,'message'=>$validate->getError()]);
        }

        //$res = Db::name('')->insert($data);
        return jsonp(['data'=>$data,'code'=>200,'message'=>'操作完成']);
    }

    public function signRead() {
        $map = [];
        $res = Db::name('')->where($map)->order()->page()->select();
        //return jsonp()
    }
}
