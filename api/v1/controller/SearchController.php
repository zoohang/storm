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
use cmf\controller\RestUserBaseController;
use think\Db;
use think\Validate;

class SearchController extends RestUserBaseController
{
    //获取热门搜索词
    public function hot() {

    }

    //获取搜索结果 1-刷题 2-打卡 3在线课堂 4-线下课堂 todo
    public function getSearchData() {
        $type = $this->request->param('type', 0, 'intval,abs');
        $keywords = $this->request->param('keywords', '', 'trim,htmlspecialchars');
        if (!$keywords) $this->error('请输入搜索关键字');
        $list = [];
        switch ($type) {
            case 1:
                $list = $this->searchExam($keywords);
                break;
            case 2:
                $list = $this->searchDaka($keywords);
                break;
            case 3:
                $list = $this->searchCourse($keywords);
                break;
            case 4:
                $list = $this->searchOfflineCourse($keywords);
                break;
            default:
                $list = $this->searchCourse($keywords);
        }
        $this->success('ok', $list);
    }

    protected function searchExam($keywords='') {
        $keywords = $keywords ?: $this->request->param('keywords', '', 'trim,htmlspecialchars');
        $where = ['status'=>1, 'ctitle'=> ['like', "%{$keywords}%"]];
        $list = DB::name('exam')->where($where)->paginate();
    }
}
