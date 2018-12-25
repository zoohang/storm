<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

use api\v1\model\PortalPostModel;
use app\portal\model\PortalCategoryModel;
use api\v1\model\SlideItemModel;
use app\portal\service\PostService;
use cmf\controller\RestBaseController;
use think\Request;

/**
 * @title 头条新闻接口
 * @description 接口说明
 * @group 接口分组
 * @header name:key require:1 default: desc:秘钥(区别设置)
 * @param name:public type:int require:1 default:1 other: desc:公共参数(区别设置)
 */
class NewsController extends RestBaseController
{

    public function index() {
        //新闻首页
        //banner
        $slide = SlideItemModel::instance()->getOne(2);
        //新闻分类
        $categoryId = $this->request->param('category', 0, 'abs,intval');
        $portalCategoryModel = new PortalCategoryModel();
        $category       = $portalCategoryModel->adminCategorySampleArray($categoryId);
        //默认全部的列表
        $this->success('ok', [
            'banner' => $slide,
            'category' => $category,
            'newsList' => $this->CaregoryNewsList(0),
        ]);
    }

    public function CaregoryNewsList($cid = null) {
        $categoryId = $cid !==null ? $cid : $this->request->param('category', 0, 'abs,intval');
        $portalCategoryModel = new PortalCategoryModel();
        $category       = $portalCategoryModel->adminCategorySampleArray($categoryId);
        $ids = $portalCategoryModel->getArrayId($category);
        $param = [
            'category' => ['IN', $ids]
        ];
        $postService = new PostService();
        $data        = $postService->getPostList($param)->toArray();
        if ($cid !==null) {
            return $data;
        } else {
            $this->success('ok', $data);
        }
    }

    // 获取一条新闻信息
    public function read()
    {
        $id = $this->request->param('id', 0, 'abs,intval');
        if (!$id) $this->error('文章的ID必填');
        $info = $post =  PortalPostModel::instance()->where('id', $id)->find()->toArray();
        $this->success('ok', $info);
    }
}
