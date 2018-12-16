<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

use api\v1\model\CourseModel;
use api\v1\model\PortalPostModel;
use api\v1\model\SlideItemModel;
use cmf\controller\RestUserBaseController;

class IndexController extends RestUserBaseController
{
    // 首页信息
    public function index()
    {
        //轮播图
        $slide = SlideItemModel::instance()->getOne(1);
        //头条信息
        $news = PortalPostModel::instance()->getRecommendArticle();
        //打卡信息 todo
        //在线课堂 todo 6个人已经加入ssd
        $course = CourseModel::instance()->getRecommendCourse();
        //线下课堂
        //刷题 maybe todo
        $data = [
            'slide'=>$slide,
            'news'=>$news,
            'course'=>$course,
        ];
        $this->success('ok', $data);
    }

}
