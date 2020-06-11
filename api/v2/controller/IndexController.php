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
use api\v1\model\OrderModel;
use api\v2\model\CategoryModel;
use api\v2\model\CourseModel;
use api\v1\model\DakaModel;
use api\v1\model\ExamModel;
use api\v1\model\PortalPostModel;
use api\v1\model\SlideItemModel;
use api\v2\model\MallModel;
use app\admin\model\GoodsModel;
use cmf\controller\RestBaseController;
use think\Db;

class IndexController extends RestBaseController
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

    public function courseVideoMain() {
        $slide = SlideItemModel::instance()->getOne(5);//id=5
        //初始化内容 获取分类
        $category = CategoryModel::instance(3)->getFirstLevelCategory();
        //获取全部的内容 列表
        $course_types = CourseModel::instance()->getCourseTypeList();
        $level = CourseModel::$levels;
        $list = $this->videoList(0,0,0,15);
        $this->success('ok', compact('slide', 'category', 'course_types', 'level', 'list'));
    }

    //视频列表
    public function videoList($cid=0, $course_type=0, $level='',$limit=10) {
        $cid = $cid ?: $this->request->param('cid', 0, 'intval,abs,trim');
        $course_type = $course_type ?: $this->request->param('course_type', 0, 'intval,abs,trim');
        $cid = trim($cid,',');
        $course_type = trim($course_type,',');
        $level = $level ?: $this->request->param('level');
        $list = [];
        $where = ['type'=>1];
        if ($cid) {
            $where['pid'] = ['in', explode(',', $cid)];
        }
        if ($course_type) {
            $where['course_type'] = ['in', explode(',', $course_type)];
        }
        if (!in_array($level, [null, '', 0])) $where['level'] = $level;
        $list = CourseModel::instance()
            ->field(CourseModel::$list_field)
            ->where($where)
            ->order(['list_order'=>'asc','cid'=>'desc'])
            ->cache(true, 60)
            ->paginate($limit)->toArray();
        foreach ($list['data'] as &$item) {
            $item['thumbnail_200'] = get_image_url($item['thumbnail'], 200);
            $item['thumbnail_480'] = get_image_url($item['thumbnail'], 480);
            unset($item['thumbnail']);
        }
        unset($item);
        if ($this->request->action() != strtolower(__FUNCTION__)) {
            return $list['data'];
        } else {
            $this->success('ok', $list);
        }
    }

    public function mallIndex() {
        //轮播图
        $slide = SlideItemModel::instance()->getOne(4);//id=4
        //分类列表
        $field = ['id', 'parent_id', 'name'];
        $categorys = CategoryModel::instance(MallModel::$ctype)->getFirstLevelCategory();
        //初始化的商品列表
        $list = $this->getList(0,0,15);
        $data = [
            'slide'=>$slide,
            'categorys'=>$categorys,
            'mall_types'=> MallModel::instance()->getMallTypeList(),
            'list'=>$list,
        ];
        $this->success('ok', $data);
    }

    // 筛选商品列表
    public function getList($cid=0, $mall_type=0, $limit=10) {
        $cid = $cid ?: $this->request->param('cid', 0, 'intval,abs,trim');
        $mall_type = $mall_type ?: $this->request->param('mall_type', 0, 'intval,abs,trim');
        $cid = trim($cid,',');
        $mall_type = trim($mall_type,',');
        $model = new MallModel;
        $where = [];
        if ($cid != 0) {
            $where['cid'] = ['IN', explode(',', trim($cid, ','))];
        }
        if ($mall_type != 0) {
            $where['mall_type'] = ['IN', explode(',', trim($mall_type, ','))];
        }
        $list = $model
            ->field(MallModel::$list_field)
            ->where($where)
            ->order(['list_order'=>'asc', 'published_time'=>'desc'])
            ->cache(true, 60)
            ->paginate($limit)->toArray();
        foreach ($list['data'] as &$item) {
            $item['thumbnail_200'] = get_image_url($item['thumbnail'], 200);
            $item['thumbnail_480'] = get_image_url($item['thumbnail'], 480);
            unset($item['thumbnail']);
        }
        if ($this->request->action() != strtolower(__FUNCTION__)) {
            return $list['data'];
        } else {
            $this->success('ok', $list);
        }
    }

    public function examGetCategoryExam() {
        $where = ['a.status'=>1, 'a.type'=>1];
        $list = DB::name('category a')
            ->join('__EXAM_SCHOOL_RELATION__ b', 'a.id=b.category_id')
            ->field('a.*')
            ->where($where)
            ->group('b.category_id')
            ->select()
            ->toArray();
        $this->success('ok', $list);
    }

    public function examGetSchool() {
        $category_id = $this->request->param('category_id', 0, 'intval,abs');
        $where = ['b.status'=>1];
        if ($category_id) $where['a.category_id'] = $category_id;
        $list = DB::name('exam_school_relation a')
            ->join('__SCHOOL__ b', 'a.school_id=b.id')
            ->join('__EXAM__ c', 'a.exam_id=c.id and c.`status`=1')
            ->distinct('b.id')
            ->field('b.*')
            ->where($where)
            ->order(['b.list_order'=>'asc','b.id'=>'asc'])
            ->select()
            ->toArray();
        $this->success('ok', $list);
    }

    public function getExamList() {
        $category_id = $this->request->param('category_id', 0, 'intval,abs');
        $school_id = $this->request->param('school_id', 0, 'intval,abs');
        $limit = 10;
        $where = ['b.status'=>1, 'a.school_id'=>$school_id];
        if ($category_id) $where['a.category_id'] = $category_id;
        $order = ['list_order'=>'asc', 'id'=>'desc'];
        $list = DB::name('exam_school_relation a')->join('__EXAM__ b', 'a.exam_id=b.id')
            ->field('b.*')
            ->where($where)
            ->order($order)
            ->paginate($limit)
            ->toArray();
        //价格
        $goods_ids = array_column($list['data'], 'goods_id');
        $where = ['goods_id'=>['in', $goods_ids]];
        $goods = GoodsModel::instance()->where($where)->field('goods_id,price,cost_price,stock')->select();

        //是否已经购买
        if ($this->userId) {
            $order = OrderModel::instance()->where($where)->where(['user_id'=>$this->userId, 'pay_status'=>2])->field('goods_id,order_id')->select();
        } else {
            $order = [];
        }
        foreach ($list['data'] as &$item) {
            foreach ($goods as $g) {
                if ($item['goods_id'] == $g['goods_id']) {
                    $item['price'] = $g['price'];
                    $item['cost_price'] = $g['cost_price'];
                    $item['stock'] = $g['stock'];
                    continue;
                }
            }
            $item['is_buy'] = 0;
            foreach ($order as $o) {
                if ($item['goods_id'] == $o['goods_id']) {
                    $item['is_buy'] = 1;
                    continue;
                }
            }
        }
        unset($item);
        $this->success('ok', $list);
    }
}
