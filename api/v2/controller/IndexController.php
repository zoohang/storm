<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v2\controller;

use api\v1\model\FeedbackModel;
use api\v2\model\CourseModel;
use api\v1\model\DakaModel;
use api\v1\model\ExamModel;
use api\v1\model\PortalPostModel;
use api\v1\model\SlideItemModel;
use api\v2\model\MallModel;
use cmf\controller\RestUserBaseController;
use think\Db;

class IndexController extends \api\v1\controller\IndexController
{
    protected $expire = 600;
    // 首页信息
    public function index()
    {
        //0.轮播图
        $slide = SlideItemModel::instance()->getOne(1);
        $slide_shuati = SlideItemModel::instance()->getOne(8);
        //1.课程单 8个
        $curriculum = $this->getRecommendCurriculum(8);
        //2.视频 5个
        $videos = $this->getRecommendVideo(5);
        //3.商品 5个
        $malls = $this->getRecommendMalls(5);
        //4.刷题 5个
        $exams= $this->getRecommendExam(5);
        //5.全局公共的底部slide
        $common_images = SlideItemModel::instance()->getOne(6);
        $data = [
            'slide'=>$slide,
            'slide_shuati'=>$slide_shuati,
            'curriculum'=>$curriculum,
            'videos'=>$videos,
            'malls'=>$malls,
            'exams' => $exams,
            'common_images' => $common_images,
        ];
        $this->success('ok', $data);
    }

    /**
     * 获取推荐的课程单 文章模型
     */
    protected function getRecommendCurriculum($num=8, $cid='') {
        $cid = $cid ?: 16; //指定默认的栏目
        $list = PortalPostModel::instance()
            ->field(['a.id','a.thumbnail'])
            ->alias('a')
            ->join("portal_category_post b", 'a.id=b.post_id')
            ->where(['b.category_id'=>$cid])
            ->order(['a.recommended' => 'desc', 'a.list_order' => 'asc'])
            ->limit($num)
            ->cache(true, $this->expire)
            ->select()
            ->toArray();
        foreach ($list as &$item) {
            $item['thumbnail200'] = $item['thumbnail'] . "?x-oss-process=style/200";
            unset($item['thumbnail']);
        }
        unset($item);
        return $list;
    }

    protected function getRecommendVideo($num) {
        $list = CourseModel::instance()
            ->field(['cid id', 'image thumbnail'])
            ->where(['type'=>1])
            ->order(['recommended'=>'desc', 'list_order'=>'asc'])
            ->limit($num)
            ->cache(true, $this->expire)
            ->select()
            ->toArray();
        foreach ($list as $key=>&$item) {
            $item['thumbnail200'] = get_image_url($item['thumbnail'], 200);
            $item['thumbnail480'] = get_image_url($item['thumbnail'], 480);
            unset($item['thumbnail']);
        }
        unset($item);
        return $list;
    }

    protected function getRecommendMalls($num) {
        $list = MallModel::instance()
            ->field(['id', 'thumbnail'])
            ->order(['recommended'=>'desc', 'list_order'=>'asc'])
            ->limit($num)
            ->cache(true, $this->expire)
            ->select()
            ->toArray();
        foreach ($list as $key=>&$item) {
            $item['thumbnail200'] = get_image_url($item['thumbnail'], 200);
            $item['thumbnail480'] = get_image_url($item['thumbnail'], 480);
            unset($item['thumbnail']);
        }
        unset($item);
        return $list;
    }

    protected function getRecommendExam($num) {
        $list = ExamModel::instance()
            ->field(['id', 'image thumbnail'])
            ->order(['recommended'=>'desc', 'list_order'=>'asc'])
            ->limit($num)
            ->cache(true, $this->expire)
            ->select()
            ->toArray();
        foreach ($list as $key=>&$item) {
            $item['thumbnail200'] = get_image_url($item['thumbnail'], 200);
            $item['thumbnail480'] = get_image_url($item['thumbnail'], 480);
            unset($item['thumbnail']);
        }
        unset($item);
        return $list;
    }

    public function submitFeedback($type,$content) {

        var_dump($type,$content);die();
        unset($params['user']);
        $params['create_time'] = $params['update_time'] = NOW_TIME;
        $params['type'] = FeedbackModel::instance()->setTypeAttr($params['type']);
        if (Db::name('feedback')->insert($params) !== false) {
            $this->success('提交成功！');
        } else {
            $this->error('提交失败！');
        }
    }
}
