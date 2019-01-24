<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

use api\v1\model\CategoryModel;
use api\v1\model\CourseModel;
use api\v1\model\DakaModel;
use api\v1\model\ExamModel;
use cmf\controller\RestUserBaseController;
use think\Db;
use think\Validate;

class SearchController extends RestUserBaseController
{
    //获取热门搜索词
    public function hot() {
        $list = Db::name('recommend')->where(['status'=>1])->order(['list_order'=>'asc', 'update_time'=>'desc'])->limit(8)->field('name')->select();
        $this->success('ok', $list);
    }

    //获取搜索结果 1-刷题 2-打卡 3在线课堂 4-线下课堂 todo
    public function getSearchData() {
        $type = $this->request->param('type', 0, 'intval,abs');
        $keywords = $this->request->param('keywords', '', 'trim,htmlspecialchars');
        if (!$keywords) $this->error('请输入搜索关键字');
        $list = [];
        switch ($type) {
            case 1:
                $list = ExamModel::instance()->searchExam($keywords);
                break;
            case 2:
                $list = DakaModel::instance()->searchDaka($keywords);
                break;
            case 3:
                $list = CourseModel::instance()->searchCourse($keywords);
                break;
            case 4:
                //todo
                //$list = $this->searchOfflineCourse($keywords);
                break;
            default:
                $list = $this->searchCourse($keywords);
        }
        $this->success('ok', $list);
    }
}
