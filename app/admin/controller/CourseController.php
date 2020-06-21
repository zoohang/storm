<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2018 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 小夏 < 449134904@qq.com>
// +----------------------------------------------------------------------
namespace app\admin\controller;

use app\admin\model\CourseItemModel;
use app\admin\model\CourseModel;
use app\admin\model\GoodsModel;
use cmf\controller\AdminBaseController;
use app\admin\model\CategoryModel;
use think\Cookie;
use think\Db;
use app\base\model\VodModel;

class CourseController extends AdminBaseController
{
    public $type=3; //category 表中type=1的分类
    public $status = [-1=>'删除', 0=>'未发布', 1=>'已发布'];
    public $levels = ['无等级','初级','中级','高级'];

    public function _initialize()
    {
        parent::_initialize();
        $this->assign('type', $this->type);
        $this->assign('status' ,$this->status);
        $this->assign('levels' ,$this->levels);
        $this->assign("course_type_list", CourseModel::instance()->courseTypeList);
    }

    public function index()
    {
        $where = ['status'=>['egt', 0]];
        /**搜索条件**/
        $keyword = $this->request->param('keyword');
        $category = $this->request->param('category', '', 'intval');
        $level = $this->request->param('level');
        $type = $this->request->param('type');#类型 1-视频 2-图文
        $course_type = $this->request->param('course_type');
        if ($type)  $where['type'] = $type;
        if ($course_type)  $where['course_type'] = $course_type;
        $_GET['type'] = intval($type);
        if ($keyword) {
            $where['ctitle'] = ['like', "%{$keyword}%"];
        }
        if ($category) {
            //兼容下级栏目
            $data = \api\v1\model\CategoryModel::instance($this->type)->getCategoryTreeArray($category);
            $ids = \api\v1\model\CategoryModel::instance($this->type)->getCategoryIds($data);
            array_unshift($ids, $category);
            $where['pid'] = ['IN', $ids];
            $selectId = $category;
        } else $selectId=0;
        if (isset($level) && $level !== '') {
            $where['level'] = $level;
        }
        //在线课程/所属分类
        $categoryModel = new CategoryModel();
        $course_category = $categoryModel->categoryTree($selectId, '', $this->type);
        $this->assign("course_category", $course_category);
        $list = DB::name('Course')
            ->where($where)
            ->order(["list_order" => "ASC"])
            ->paginate();
        // 分页注入搜索条件
        // 获取关联的讲师 tid
        $cids = array_column($list->items(), 'cid');
        if ($cids) {
            $teachers = DB::name('course_teacher_relation a')
                ->join('__COURSE_TEACHER__ b', 'a.tid=b.tid')
                ->where(['a.cid'=>['IN', $cids]])
                ->field(['a.cid','b.tid', 'b.tname'])
                ->select()
                ->toArray();
            $handle_teacher = [];
            foreach($teachers as $key=>$item) {
                $handle_teacher[$item['cid']][] = $item['tname'];
            }
            $list = $list->each(function ($item, $key) use ($handle_teacher) {
                if (isset($handle_teacher[$item['cid']]) && $handle_teacher[$item['cid']]) {
                    $item['tnames'] = join(',', $handle_teacher[$item['cid']]);
                } else {
                    $item['tnames'] = '';
                }
                return $item;
            });
        }
        $list->appends(['keyword' => $keyword, 'category' => $category, 'level'=>$level, 'type'=>$type]);
        // 获取分页显示
        $page = $list->render();
        $this->assign(['keyword' => $keyword, 'category' => $category, 'level'=>$level, 'type'=>$type]);
        $this->assign("page", $page);
        $this->assign("list", $list);
        return $this->fetch('index');
    }

    public function videoindex() {
        request()->get(['type'=>1]);
        return $this->index();
    }

    /**
     * 编辑
     * @return mixed
     */
    public function edit()
    {
        $id    = $this->request->param('cid', 0, 'intval');
        $info = $tids = [];
        if ($id) {
            $info = CourseModel::get($id);
            $tids = DB::name('course_teacher_relation')->where(['cid'=>$id, 'status'=>1])->column('tid');
            $goods = GoodsModel::instance()->getGoods($info->goods_id);
            $this->assign('goods', $goods);
        }
        $CategoryModel = new CategoryModel();
        $categoryTree = $CategoryModel->categoryTree(isset($info->pid) ? $info->pid : 0, '', $this->type);
        $this->assign('category_tree', $categoryTree);

        //讲师
        $teachers = DB::name('course_teacher')->where(['status'=>1])->select();
        $this->assign('teachers', $teachers);
        $this->assign('info', $info);
        $this->assign('select_tids', $tids ? json_encode($tids): '');
        $this->assign('tids_str', implode(',', $tids));
        return $this->fetch();
    }

    /**
     * 保存
     */
    public function editPost()
    {
        $id = $this->request->param('cid');
        $data = $this->request->param();
        $result = $this->validate($data, 'Course');
        if ($result !== true) {
            $this->error($result);
        }
        $CourseModel = new CourseModel();
        $tid = explode(',', $data['tid']);
        $goods = $data['goods'];
        $other = [
            'category_id'=> $data['pid'],
            'goods_name'=> $data['ctitle'],
            'image'=> $data['image'],
            //'goods_status' => $data['status']
        ];
        if (!empty($data['photo_names']) && !empty($data['photo_urls'])) {
            $data['more']['photos'] = [];
            foreach ($data['photo_urls'] as $key => $url) {
                array_push($data['more']['photos'], ["url" => $url, "name" => $data['photo_names'][$key]]);
            }
        }
        if ($id) {
            //save
            Db::startTrans();
            try{
                $data['goods_id'] = GoodsModel::instance()->editGoods($goods, $other, $this->type);
                $CourseModel->isUpdate(true)->allowField(true)->save($data);
                DB::table('st_course_teacher_relation')->where(['cid'=>$id])->delete();
                $relation_list = array_map(function($item) use ($id) {
                    return [
                        'cid'=>$id,
                        'tid'=>$item,
                        'status'=>1
                    ];
                }, $tid);
                Db::table('st_course_teacher_relation')->insertAll($relation_list);
                // 提交事务
                Db::commit();
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                $this->error($e->getMessage());
            }
            $this->success('编辑成功!', url('course/index', ['type'=>$data['type']]));
        } else {
            //add
            Db::startTrans();
            try{
                $data['goods_id'] = GoodsModel::instance()->editGoods($goods, $other, $this->type);
                $CourseModel->isUpdate(false)->allowField(true)->save($data);
                $cid = $CourseModel->cid;
                $relation_list = array_map(function($item) use ($cid) {
                    return [
                        'cid'=>$cid,
                        'tid'=>$item,
                        'status'=>1
                    ];
                }, $tid);
                Db::table('st_course_teacher_relation')->insertAll($relation_list);
                // 提交事务
                Db::commit();
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                $this->error($e->getMessage());
            }
            $this->success('添加成功!', url('course/index', ['type'=>$data['type']]));
        }
    }

    /**
     * 课程-章节详情-列表-管理
     */
    public function detail() {
        $cid = $this->request->param('cid', 0, 'intval');
        if (!$cid) $this->error('请选择一个课程');
        $where = ['cid'=>$cid, 'status'=>1];
        //model
        $CourseItemModel = new CourseItemModel();
        $list = $CourseItemModel->CategoryTableTree($cid);
        $this->assign('list' , $list);
        //获取课程信息
        $info = DB::name('course')->where(['cid'=>$cid])->find();
        $this->assign('info', $info);
        return $this->fetch();
    }

    /**
     * 新增章节
     */
    public function editSection() {
        $cid = $this->request->param('cid', 0, 'intval');
        if (!$cid) $this->error('请选择一个课程');
        $item_id = $this->request->param('item_id', 0, 'intval');
        $info = [];
        if ($item_id) {
            //编辑
            $info = DB::name('course_item')->where(['item_id'=>$item_id])->find();
        }
        $this->assign('info', $info);
        return $this->fetch();
    }

    /**
     * 保存章节
     */
    public function saveSection() {
        $cid = $this->request->param('cid', 0, 'intval');
        if (!$cid) $this->error('请选择一个课程');
        $item_id = $this->request->param('item_id', 0, 'intval');
        $item_title = $this->request->param('item_title', '');
        $summary = $this->request->param('summary', '');
        if (!$item_title) $this->error('请认真填写章节标题');
        $course_info = DB::name('course')->where(['cid'=>$cid])->find();
        $data = [
            'cid' => $cid,
            'ctitle' => $course_info['ctitle'],
            'item_title' => $item_title,
            'summary' => $summary,
            'type' => 0,
            'status' => 1
        ];
        if ($item_id) {
            //更新
            $data['item_id'] = $item_id;
            $data['update_time'] = $this->request->time();
            //$res = DB::name('course_item')->update($data);
            $res = CourseItemModel::update($data);
        } else {
            //新增
            $data['create_time'] = $this->request->time();
            //$res = DB::name('course_item')->insertGetId($data);
            $res = CourseItemModel::create($data);
        }
        if ($res !== false) {
            $this->success('成功!', url('course/detail', ['cid'=>$cid]));
        } else {
            $this->error('失败, 请重试');
        }
    }

    /**
     * 编辑题目 todo 课程的添加/编辑
     */
    public function editItem() {
        $cid = $this->request->param('cid', 0, 'intval');
        $item_id = $this->request->param('item_id', 0, 'intval');
        if (!$cid) $this->error('课程id不能为空');
        //查询该课程的模型是视频还是图文
        $course_info = DB::name('course')->where(['cid'=>$cid])->find();
        if ($course_info['type'] == 1) {
            $template_name = 'video';
        } elseif($course_info['type'] == 2) {
            $template_name = 'article';
        } else {
            //todo 其他模型
        }
        Cookie::set('course_template', $template_name, 86400);
        //题目信息
        $info = [];
        $CourseItemModel = new CourseItemModel();
        if ($item_id) {
            $info = $CourseItemModel->get($item_id);
            $info_type = $info->getData('type');
            if ($info_type == 1) {
                //视频模型
                $vod = Db::name('video_vod')->where(['video_id'=>$info->video_id])->find();
                $vod['player_url'] = $vod['video_url'] ?: $vod['source_url'];
                $this->assign('vod', $vod);
            } elseif($info_type == 2) {
                //图文模型

            }
            //if ($info['option']) $info['option'] = json_decode($info['option'], true);
        }
        //获取小节类目
        $xiaojie = $CourseItemModel->where(['cid'=>$cid, 'type'=>0])->field(['item_id', 'item_title'])->select();
        $this->assign('xiaojie', $xiaojie);
        $this->assign('info', $info);
        $this->assign('course_info', $course_info);
        return $this->fetch($template_name);
    }

    /**
     * 保存题目
     */
    public function saveItem() {
        $id = $this->request->param('item_id');
        $data = $this->request->param();
        $cid = $this->request->param('cid'); //课程ID
        if (!$cid) $this->error('课程id不能为空');
        //dump($data);die;
        $CourseItemModel = new CourseItemModel();
        $isUpdate = false;
        $data['create_time'] = NOW_TIME;
        if ($id) {
            $isUpdate = true;
            $data['update_time'] = NOW_TIME;
            unset($data['create_time']);
        }
        if ($data['type'] == 1) {
            //视频模块
            if (!$data['video_id']) $this->error('请上传视频!');
            $exists = Db::name('video_vod')->where(['video_id'=>$data['video_id']])->find();
            if (!$exists) {
                Db::name('video_vod')->insert([
                    'video_id' => $data['video_id'],
                    'source_url' => $data['source_url'],
                    'create_time' => NOW_TIME
                ]);
            }
        } elseif($data['type'] == 2) {

        }
        $result = $CourseItemModel->allowField(true)->isUpdate($isUpdate)->save($data);
        Db::name('course')->where(['cid'=>$cid])->setInc('num');
        if ($result === false) {
            $this->error('编辑失败!');
        } else {
            $this->success('编辑成功!', url('course/detail', ['cid'=>$cid]));
        }
    }

    public function listOrder()
    {
        $table_name = $this->request->param('table', 'course');
        parent::listOrders(Db::name($table_name));
        $this->success("排序更新成功！", '');
    }


    public function toggle()
    {
        $data                = $this->request->param();
        $examItemModel = new ExamItemModel();

        if (isset($data['ids']) && !empty($data["display"])) {
            $ids = $this->request->param('ids/a');
            $examItemModel->where(['id' => ['in', $ids]])->update(['status' => 1]);
            $this->success("更新成功！");
        }

        if (isset($data['ids']) && !empty($data["hide"])) {
            $ids = $this->request->param('ids/a');
            $examItemModel->where(['id' => ['in', $ids]])->update(['status' => 0]);
            $this->success("更新成功！");
        }

    }

    public function delete()
    {
        $param       = $this->request->param();
        $CourseModel = new CourseModel();
        if (isset($param['id'])) {
            if ($CourseModel->where(['cid'=> $param['id']])->update(['status' => -1]) !== false) {
                $this->success("删除成功！");
            } else {
                $this->error("删除失败！");
            }
        }
        if (isset($param['ids'])) {
            if ($CourseModel->where(['cid'=> ['in', $param['ids']]])->update(['status' => -1]) !== false) {
                $this->success("删除成功！");
            } else {
                $this->error("删除失败！");
            }
        }

    }

    public function publish()
    {
        $param           = $this->request->param();
        $CourseModel = new CourseModel();

        if (isset($param['ids']) && isset($param["yes"])) {
            $ids = $this->request->param('ids/a');

            $CourseModel->where(['cid' => ['in', $ids]])->update(['status' => 1, 'published_time' => time()]);

            $this->success("发布成功！", '');
        }

        if (isset($param['ids']) && isset($param["no"])) {
            $ids = $this->request->param('ids/a');

            $CourseModel->where(['cid' => ['in', $ids]])->update(['status' => 2]);

            $this->success("取消发布成功！", '');
        }

    }

    public function top()
    {
        $param           = $this->request->param();
        $CourseModel = new CourseModel();

        if (isset($param['ids']) && isset($param["yes"])) {
            $ids = $this->request->param('ids/a');

            $CourseModel->where(['cid' => ['in', $ids]])->update(['is_top' => 1]);

            $this->success("置顶成功！", '');

        }

        if (isset($_POST['ids']) && isset($param["no"])) {
            $ids = $this->request->param('ids/a');

            $CourseModel->where(['cid' => ['in', $ids]])->update(['is_top' => 0]);

            $this->success("取消置顶成功！", '');
        }
    }

    public function recommend()
    {
        $param           = $this->request->param();
        $CourseModel = new CourseModel();

        if (isset($param['ids']) && isset($param["yes"])) {
            $ids = $this->request->param('ids/a');

            $CourseModel->where(['cid' => ['in', $ids]])->update(['recommended' => 1]);

            $this->success("推荐成功！", '');

        }
        if (isset($param['ids']) && isset($param["no"])) {
            $ids = $this->request->param('ids/a');

            $CourseModel->where(['cid' => ['in', $ids]])->update(['recommended' => 0]);

            $this->success("取消推荐成功！", '');

        }
    }

    public function delete_item()
    {
        $item_id = $this->request->param('item_id', 0, 'intval');
        $cid = $this->request->param('cid', 0, 'intval');
        if (!$item_id || !$cid) $this->error('缺少参数');
        if (Db::name('course_item')->where(['item_id'=> $item_id])->update(['status' => -1]) !== false) {
            Db::name('course')->where(['cid'=> $cid])->setDec('num');
            $this->success("删除成功！");
        } else {
            $this->error("删除失败！");
        }
    }

    public function teacher() {
        $where = [];
        /**搜索条件**/
        $keyword = $this->request->param('keyword');
        $where['status'] = ['EGT', 0];
        if ($keyword) {
            $where['tname'] = ['like', "%{$keyword}%"];
        }

        $list = DB::name('course_teacher')
            ->where($where)
            ->order("tid DESC")
            ->paginate();
        // 分页注入搜索条件
        $list->appends(['keyword' => $keyword]);
        // 获取分页显示
        $page = $list->render();
        $this->assign(['keyword' => $keyword]);
        $this->assign("page", $page);
        $this->assign("list", $list);
        return $this->fetch();
    }

    public function teacherEdit() {
        $tid = $this->request->param('tid', 0, 'intval');
        //题目信息
        $info = ['status'=>1];
        if ($tid) {
            $info = DB::name('course_teacher')->where(['tid'=>$tid])->find();
        }
        $this->assign($info);
        return $this->fetch();
    }

    public function teacherSave() {
        $tid = $this->request->param('tid');
        $data = $this->request->param();
        $result = $this->validate($data, 'CourseTeacher');
        if ($result !== true) {
            $this->error($result);
        }
        if ($tid) {
            //save
            $data['tid'] = $tid;
            $result = DB::name('course_teacher')->where(['tid'=>$tid])->update($data);

            if ($result === false) {
                $this->error('编辑失败!');
            } else {
                $this->success('编辑成功!', url('course/teacherEdit', ['tid'=>$tid]));
            }
        } else {
            //add
            unset($data['id']);
            $result = Db::name('course_teacher')->insert($data);
            if ($result === false) {
                $this->error('添加失败!');
            }
            $this->success('添加成功!', url('course/teacher'));
        }
    }

    public function teacherDelete() {
        $tid = $this->request->param('tid');
        if (!$tid) $this->error('没有讲师id!');
        if (Db::name('course_teacher')->where(['tid'=> $tid])->update(['status' => 0]) !== false) {
            $this->success("删除成功！");
        } else {
            $this->error("删除失败！");
        }
    }

    /**
     * 获取上传凭证
     * 前端上传获取视频的基本信息 标题title 视频路径file_name
     * 之后搬迁到admin模块
     */
    public function client_get_upload_ticket() {
        $info = [
            'title' => $this->request->param('title'),
            'file_name' => $this->request->param('file_name'),
        ];
        if (strlen($info['title']) > 127) {
            $info['title'] = msubstr($info['title'], 0, 40, 'utf-8', false);
        }
        if (!$info['title'] || !$info['file_name']) $this->error('标题和视频地址必填');
        $res = VodModel::getInstance()->create_upload_video($info);
        return json($res);
    }

    public function get_vod_origin() {
        $video_id = $this->request->param('video_id');
        if (!$video_id) $this->error('video_id必填');
        $res = VodModel::getInstance()->get_mezzanine_info($video_id);
        return json($res);
    }

    //todo
    public function get_player_info() {
        $video_id = I('get.video_id');
        if (!$video_id) exit(json_encode(['status'=>false, 'message'=>'video_id必填', 'data'=>'']));
        $res = VodModel::getInstance()->get_play_info($video_id);
        exit(json_encode($res));
    }

    //todo
    public function get_player_info_by_vid($id=null) {
        $vid = isset($id) ? $id : I('get.vid', 0, 'intval');
        if (!$vid) {
            return false;
        }
        $video_id = M('video_vod')->where(['vid'=>$vid])->getField('video_id');
        if (!$video_id) {
            return false;
        } else {
            $auth = $this->get_player_auth($video_id)->PlayAuth;
            header('Content-Type:application/json; charset=utf-8');
            $data = ['video_id'=>$video_id, 'play_auth'=>$auth];
            exit(json_encode(['status'=>true, 'message'=>'获取成功', 'data'=>$data]));
        }
    }
}