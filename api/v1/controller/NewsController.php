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
        $categoryId = $this->request->param('category', 1, 'abs,intval');
        $portalCategoryModel = new PortalCategoryModel();
        $category       = $portalCategoryModel->adminCategorySampleArray($categoryId);
        sort($category);
        //默认全部的列表
        $this->success('ok', [
            'banner' => $slide,
            'category' => $category,
            'newsList' => $this->CaregoryNewsList($categoryId),
        ]);
    }

    public function CaregoryNewsList($cid = null) {
        $categoryId = $cid !==null ? $cid : $this->request->param('category', 0, 'abs,intval');
        $portalCategoryModel = new PortalCategoryModel();
        $category       = $portalCategoryModel->adminCategorySampleArray($categoryId);
        $ids = $portalCategoryModel->getArrayId($category);
        array_unshift($ids, $categoryId);
        $param = [
            'category' => ['IN', $ids]
        ];
        $postService = new PostService();
        $data        = $postService->getPostList($param)->toArray();
        if ($this->request->action() != strtolower(__FUNCTION__)) {
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
        $info = PortalPostModel::instance()->where('id', $id)->find() ?: [];
        if ($info){
            $info = $info->toArray();
            //更新点击post_hits
            PortalPostModel::instance()->where(['id'=>$id])->setInc('post_hits');
        }
        $this->success('ok', $info);
    }

    //线下课堂
    public function classRoom() {
        $categoryId = $this->request->param('category', 2, 'abs,intval');
        $portalCategoryModel = new PortalCategoryModel();
        $category       = $portalCategoryModel->adminCategorySampleArray($categoryId);
        sort($category);
        //默认全部的列表
        $this->success('ok', [
            'category' => $category
        ]);
    }
}
