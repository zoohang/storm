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

use app\admin\model\ExamItemModel;
use app\admin\model\ExamModel;
use app\admin\model\GoodsModel;
use app\admin\model\SchoolModel;
use cmf\controller\AdminBaseController;
use app\admin\model\CategoryModel;
use think\Cookie;
use think\Db;

class ExamController extends AdminBaseController
{
    public $type=1; //category 表中type=1的分类
    public $status = [-1=>'删除', 0=>'未发布', 1=>'已发布'];
    public $item_type = [1=>'选择题', 2=>'填空题', 3=>'论述题'];

    public function _initialize()
    {
        parent::_initialize();
        $this->assign('type', $this->type);
        $this->assign('status' ,$this->status);
        $this->assign('item_type' ,$this->item_type);
    }

    public function index()
    {
        $where = [];
        /**搜索条件**/
        $keyword = $this->request->param('keyword');
        $property = $this->request->param('property', '', 'intval');
        $category_id = $this->request->param('category_id', 0, 'intval');
        $where = ['status'=> ['EGT', 0]];
        if ($keyword) {
            $where['title'] = ['like', "%{$keyword}%"];
        }
        if ($property) {
            $where['property'] = $property;
        }
        if ($category_id) {
            $where['cid'] = $category_id;
        }
        //获取所有的专业分类
        $category = DB::name('Exam a')
            ->distinct('a.cid')
            ->join('__CATEGORY__ b', 'a.cid=b.id')
            ->field(['b.id','b.name'])
            ->where(['b.type'=>$this->type, 'a.status'=> ['EGT', 0]])
            ->select();

        $exams = DB::name('Exam')
            ->where($where)
            ->order("list_order ASC,id DESC")
            ->paginate();
        // 分页注入搜索条件
        $exams->appends(['keyword' => $keyword, 'property' => $property, 'category_id'=>$category_id]);
        // 获取分页显示
        $page = $exams->render();
        $this->assign(['keyword' => $keyword, 'property' => $property, 'category_id'=>$category_id]);
        $this->assign("page", $page);
        $this->assign("list", $exams);
        $this->assign("category", $category);
        return $this->fetch();
    }

    /**
     * 试卷添加
     */
    public function add()
    {
        $CategoryModel = new CategoryModel();
        $categoryTree = $CategoryModel->categoryTree(0, '', $this->type);
        $this->assign('category_tree', $categoryTree);
        //学校类型 11
        $college = $CategoryModel->field(['id','name'])->where(['type'=>11, 'status'=>1])->select()->toArray();
        $this->assign('college', $college);
        return $this->fetch();
    }

    /**
     * 试卷添加 post
     */
    public function addPost()
    {
        $ExamModel = new ExamModel();
        $data = $this->request->param();
        $data['cid'] = $data['parent_id'];
        unset($data['parent_id']);
        $result = $this->validate($data, 'Exam');
        if ($result !== true) {
            $this->error($result);
        }
        $category_info = Db::name('Category')->where(['id'=>$data['cid']])->find();
        $data['cname'] = $category_info['name'];
        $data['create_uid'] = session('ADMIN_ID');
        $data['create_name'] = session('name');

        Db::startTrans();
        try{
            //商品售价
            $goods = $data['goods'];
            $other = [
                'category_id'=> $data['cid'],
                'goods_name'=> $data['title'],
                'image'=> $data['image'],
                'goods_status' => $data['status'],
            ];
            $data['goods_id'] = GoodsModel::instance()->editGoods($goods, $other, $this->type);
            //商品售价
            $ExamModel->allowField(true)->isUpdate(false)->save($data);
            $data['exam_id'] = $ExamModel->id;
            $school_ids = explode(',', $data['school_id']);
            $school_data = array_map(function($id) use ($data){
                return ['school_id'=>$id, 'exam_id'=>$data['exam_id'], 'category_id'=>$data['cid']];
            }, $school_ids);
            Db::name('exam_school_relation')->insertAll($school_data);
            // 提交事务
            Db::commit();
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            $this->error('添加失败!');
        }
        $this->success('添加成功!', url('Exam/index'));
    }

    /**
     * 试卷编辑
     * @return mixed
     */
    public function edit()
    {
        $id    = $this->request->param('id', 0, 'intval');
        $info = DB::name('exam')->where(["id" => $id])->find();
        $CategoryModel = new CategoryModel();
        $categoryTree = $CategoryModel->categoryTree($info['cid'], '', $this->type);
        $this->assign('category_tree', $categoryTree);
        $school_info = Db::name('exam_school_relation a')
            ->join('__SCHOOL__ b', 'a.school_id=b.id')
            ->field(['b.id','b.name'])
            ->where(['exam_id'=>$id])
            ->select()->toArray();
        $this->assign('school_id', array_column($school_info, 'id'));
        $this->assign('school_name', array_column($school_info, 'name'));
        $this->assign($info);
        $goods = GoodsModel::instance()->getGoods($info['goods_id']);
        $this->assign('goods', $goods);
        return $this->fetch();
    }

    /**
     * 试卷保存
     */
    public function editPost()
    {
        if ($this->request->isPost()) {
            $ExamModel = new ExamModel();
            $data = $this->request->param();
            $data['cid'] = $data['parent_id'];
            $category_info = Db::name('Category')->where(['id'=>$data['cid']])->find();
            $data['cname'] = $category_info['name'];
            unset($data['parent_id']);
            $result = $this->validate($data, 'Exam');

            if ($result !== true) {
                $this->error($result);
            }
            $goods = $data['goods'];
            $other = [
                'category_id'=> $data['cid'],
                'goods_name'=> $data['title'],
                'image'=> $data['image'],
                'goods_status' => $data['status']
            ];
            Db::startTrans();
            try{
                $data['goods_id'] = GoodsModel::instance()->editGoods($goods, $other, $this->type);
                $result = $ExamModel->allowField(true)->isUpdate(true)->save($data);
                $exam_id = $data['id'];
                Db::name('exam_school_relation')->where(['exam_id'=>$data['id']])->delete();
                $ins_data = array_map(function($id) use ($data){
                    return ['school_id'=>$id, 'exam_id'=>$data['id'], 'category_id'=>$data['cid']];
                }, explode(',', $data['school_id']));
                Db::name('exam_school_relation')->insertAll($ins_data);
                Db::commit();
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                $this->error('添加失败!');
            }
            $this->success('编辑成功!', url('Exam/index'));

        }
    }

    public function section_list() {
        $exam_id = $this->request->param('exam_id', 0, 'intval');
        if (!$exam_id) $this->error('请选择一套试卷');
        $list = DB::name('exam_section')->where(['status'=>1, 'exam_id'=>$exam_id])->order(['list_order'=>'asc'])->select()->toArray();
        if ($this->request->action() != strtolower(__FUNCTION__)) {
            return $list;
        } else {
            $this->assign('list', $list);
            return $this->fetch();
        }

    }

    public function section_edit() {
        $exam_id = $this->request->param('exam_id', 0, 'intval');
        if (!$exam_id) $this->error('请选择一套试卷');
        $section_id = $this->request->param('section_id', 0, 'intval');
        $info = [];
        if ($section_id) {
            $info = DB::name('exam_section')->where(['status'=>1, 'section_id'=>$section_id])->find();
        }
        $this->assign('info', $info);
        return $this->fetch();
    }

    public function section_save() {
        $exam_id = $this->request->param('exam_id', 0, 'intval');
        if (!$exam_id) $this->error('请选择一套试卷');
        $section_id = $this->request->param('section_id', 0, 'intval');
        $data = $this->request->param();
        if ($section_id) {
            $data['update_time'] = NOW_TIME;
            $res = DB::name('exam_section')->where(['section_id'=>$section_id])->update($data);
        } else {
            $data['create_time'] = $data['update_time'] = NOW_TIME;
            $res = DB::name('exam_section')->insertGetId($data);
            $section_id = $res;
        }
        if ($res !== false) {
            $this->success('编辑成功', url('exam/section_edit',['exam_id'=>$exam_id, 'section_id'=>$section_id]));
        } else {
            $this->error('编辑失败!');
        }
    }

    public function section_delete() {
        $section_id = $this->request->param('section_id', 0, 'intval');
        if (!$section_id) $this->error('请选择一个章节');
        $ExamItemModel = new ExamItemModel();
        $count = $ExamItemModel->where(['section_id'=>$section_id, 'status'=>1])->count();
        if ($count) {
            $this->error('该分类下有题目, 请先清空题目在进行删除');
        }
        $res = DB::name('exam_section')->where(['section_id'=>$section_id])->update(['status'=>0, 'update_time'=>NOW_TIME]);
        if ($res !== false) {
            $this->success('删除成功!');
        } else {
            $this->error('删除失败!');
        }
    }

    /**
     * 详细题目列表
     */
    public function detail() {
        $id = $this->request->param('id', 0, 'intval');
        $section_id = $this->request->param('section_id', 0, 'intval');
        if (!$id) $this->error('请选择一套试卷');
        $where = ['a.exam_id'=>$id, 'a.status'=>1];
        if ($section_id) $where['a.section_id'] = $section_id;
        $exams_items = DB::name('Exam_item a')
            ->join('__EXAM_SECTION__ b', 'a.section_id=b.section_id', 'LEFT')
            ->where($where)
            ->field('b.*,a.*')
            ->order("a.list_order ASC,a.id ASC")
            ->select();
        $this->assign('list' , $exams_items);
        //获取试卷信息
        $info = DB::name('exam')->where(['id'=>$id])->find();
        //学校信息
        $school = DB::name('exam_school_relation a')
            ->join('__SCHOOL__ b','a.school_id=b.id')
            ->where(['a.exam_id'=>$id])->select()->toArray();
        //章节信息
        $section = DB::name('exam_section')->where(['exam_id'=>$id,'status'=>1])->select()->toArray();

        $this->assign('section', $section ?: []);
        $this->assign('school', $school ?: []);
        $this->assign('info', $info);
        return $this->fetch();
    }

    /**
     * 编辑题目
     */
    public function editItem() {
        $type = $this->request->param('item_type', 0, 'intval');
        $exam_id = $this->request->param('exam_id', 0, 'intval');
        $item_id = $this->request->param('item_id', 0, 'intval');
        if (!$exam_id) $this->error('试卷id不能为空');
        switch ($type) {
            case 1 :
                $template_name = 'edit_item_xuanze';
                break;
            case 2 :
                $template_name = 'edit_item_tiankong';
                break;
            case 3 :
                $template_name = 'edit_item_lunshu';
                break;
            default :
                $cookie_type_name = $this->request->cookie('item_template_name');
                if ($cookie_type_name) {
                    $template_name = $cookie_type_name;
                } else {
                    $template_name = 'edit_item_xuanze';
                }
        }
        Cookie::set('item_template_name', $template_name, 86400);
        //题目信息
        $info = [];
        if ($item_id) {
            $info = DB::name('exam_item')->where(['id'=>$item_id])->find();
            if ($info['option']) $info['option'] = json_decode($info['option'], true);
        }
        $this->assign('info', $info);
        //章节信息
        $section = DB::name('exam_section')->where(['exam_id'=>$exam_id])->select()->toArray();
        $this->assign('section', $section);
        return $this->fetch($template_name);
    }

    /**
     * 保存题目
     */
    public function saveItem() {
        $id = $this->request->param('item_id');
        $data = $this->request->param()['post'];
        $result = $this->validate($data, 'ExamItem');
        if ($result !== true) {
            $this->error($result);
        }
        $ExamItemModel = new ExamItemModel();
        if (isset($data['option']) && $data['option']) $data['option'] = json_encode($data['option'], 64|256);
        if ($id) {
            //save
            $data['id'] = $id;
            $result = $ExamItemModel->allowField(true)->isUpdate(true)->save($data);
            if ($result === false) {
                $this->error('编辑失败!');
            }
            $this->success('编辑成功!', url('exam/editItem', ['item_id'=>$id, 'item_type'=>$data['type'], 'exam_id'=>$data['exam_id']]));
        } else {
            //add
            unset($data['id']);
            $result = $ExamItemModel->allowField(true)->save($data);
            if ($result === false) {
                $this->error('添加失败!');
            }
            $this->success('添加成功!', url('exam/editItem', ['item_id'=>$ExamItemModel->id, 'item_type'=>$data['type'], 'exam_id'=>$data['exam_id']]));
        }
    }

    public function publish()
    {
        $param           = $this->request->param();
        $ExamModel = new ExamModel();

        if (isset($param['ids']) && isset($param["yes"])) {
            $ids = $this->request->param('ids/a');

            $ExamModel->where(['id' => ['in', $ids]])->update(['status' => 1, 'published_time' => time()]);

            $this->success("发布成功！", '');
        }

        if (isset($param['ids']) && isset($param["no"])) {
            $ids = $this->request->param('ids/a');

            $ExamModel->where(['id' => ['in', $ids]])->update(['status' => 0]);

            $this->success("取消发布成功！", '');
        }

    }
    
    public function top()
    {
        $param           = $this->request->param();
        $ExamModel = new ExamModel();

        if (isset($param['ids']) && isset($param["yes"])) {
            $ids = $this->request->param('ids/a');

            $ExamModel->where(['id' => ['in', $ids]])->update(['is_top' => 1]);

            $this->success("置顶成功！", '');

        }

        if (isset($_POST['ids']) && isset($param["no"])) {
            $ids = $this->request->param('ids/a');

            $ExamModel->where(['id' => ['in', $ids]])->update(['is_top' => 0]);

            $this->success("取消置顶成功！", '');
        }
    }

    public function recommend()
    {
        $param           = $this->request->param();
        $ExamModel = new ExamModel();

        if (isset($param['ids']) && isset($param["yes"])) {
            $ids = $this->request->param('ids/a');

            $ExamModel->where(['id' => ['in', $ids]])->update(['recommended' => 1]);

            $this->success("推荐成功！", '');

        }
        if (isset($param['ids']) && isset($param["no"])) {
            $ids = $this->request->param('ids/a');

            $ExamModel->where(['id' => ['in', $ids]])->update(['recommended' => 0]);

            $this->success("取消推荐成功！", '');

        }
    }

    public function listOrderExam()
    {
        parent::listOrders(Db::name('exam'));
        $this->success("排序更新成功！", '');
    }

    public function listOrder()
    {
        parent::listOrders(Db::name('exam_item'));
        $this->success("排序更新成功！", '');
    }

    public function listOrderSection()
    {
        parent::listOrders(Db::name('exam_section'));
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
        $param           = $this->request->param();
        $ExamModel = new ExamModel();
        if (isset($param['id'])) {
            if (Db::name('exam')->where(['id'=> $param['id']])->update(['status' => -1, 'delete_time'=>time()]) !== false) {
                $this->success("删除成功！");
            } else {
                $this->error("删除失败！");
            }
        }
        if (isset($param['ids'])) {
            if (Db::name('exam')->where(['id'=> ['in', $param['ids']]])->update(['status' => -1, 'delete_time'=>time()]) !== false) {
                $this->success("删除成功！");
            } else {
                $this->error("删除失败！");
            }
        }
    }

    public function delete_item()
    {
        $id = $this->request->param('id', 0, 'intval');
        if (Db::name('exam_item')->where(['id'=> $id])->update(['status' => -1]) !== false) {
            $this->success("删除成功！");
        } else {
            $this->error("删除失败！");
        }
    }

    public function select()
    {
        $ids                 = $this->request->param('ids');
        $selectedIds         = explode(',', $ids);

        $list = SchoolModel::instance()->field(['id','name'])->where(['status'=>1])->order(['list_order'=>'asc'])->select()->toArray();
        foreach ($list as &$item) {
            $item['check'] = '';
            if (in_array($item['id'], $selectedIds)) {
                $item['check'] = 'checked';
            }
        }
        unset($item);
        $this->assign('list', $list);
        return $this->fetch('category/select');
    }
}