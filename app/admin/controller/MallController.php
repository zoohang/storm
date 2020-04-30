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

class MallController extends AdminBaseController
{
    public $type=1; //category 表中type=1的分类
    public $status = [-1=>'删除', 0=>'未发布', 1=>'已发布'];
    public $item_type = [1=>'选择题', 2=>'填空题', 3=>'论述题'];
    public $levels = ['无等级','初级','中级','高级'];

    public function _initialize()
    {
        parent::_initialize();
        $this->assign('type', $this->type);
        $this->assign('status' ,$this->status);
        $this->assign('item_type' ,$this->item_type);
        $this->assign('levels' ,$this->levels);
    }

    public function index()
    {
        $where = [];
        /**搜索条件**/
        $keyword = $this->request->param('keyword');
        $property = $this->request->param('property', '', 'intval');
        $category_id = $this->request->param('category_id', 0, 'intval');
        $level = $this->request->param('level', '');
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
        if ($level !== '') {
            $where['level'] = $level;
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
        $exams->appends(['keyword' => $keyword, 'property' => $property, 'category_id'=>$category_id, 'level'=>$level]);
        // 获取分页显示
        $page = $exams->render();
        $this->assign(['keyword' => $keyword, 'property' => $property, 'category_id'=>$category_id, 'level'=>$level]);
        $this->assign("page", $page);
        $this->assign("list", $exams);
        $this->assign("category", $category);
        return $this->fetch();
    }

    /**
     * 添加
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
     * 添加 post
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
     * 编辑
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
     * 保存
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