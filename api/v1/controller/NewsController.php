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
use think\Request;

class NewsController extends RestBaseController
{
    // 获取一条新闻信息
    public function read(Request $request)
    {
        return json(['message'=>'新闻详情页', 'path'=>'news/read', 'id'=>$request->param('id')]);
    }

    public function index() {
        return json(['message'=>'新闻首页', 'path'=>'news/index']);
    }

    public function edit(Request $request)
    {
        return json(['message'=>'新闻编辑页', 'path'=>'news/edit', 'id'=>$request->param('id')]);
    }

    public function delete(Request $request) {
        return json(['message'=>'删除新闻', 'path'=>'news/delete', 'id'=>$request->param('id')]);
    }
}
