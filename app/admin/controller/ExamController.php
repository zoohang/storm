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
        if ($keyword) {
            $where[] = ['title', 'like', "%{$keyword}%"];
        }
        if ($property) {
            $where['property'] = $property;
        }

        $exams = DB::name('Exam')
            ->where($where)
            ->order("id DESC")
            ->paginate();
        // 分页注入搜索条件
        $exams->appends(['keyword' => $keyword, 'property' => $property]);
        // 获取分页显示
        $page = $exams->render();
        $this->assign(['keyword' => $keyword, 'property' => $property]);
        $this->assign("page", $page);
        $this->assign("list", $exams);
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
        $result = $ExamModel->allowField(true)->save($data);
        if ($result === false) {
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
        $college = $CategoryModel->field(['id','name'])->where(['type'=>11, 'status'=>1])->select()->toArray();
        $this->assign('college', $college);
        $this->assign($info);
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
            $result = $ExamModel->allowField(true)->isUpdate(true)->save($data);
            if ($result === false) {
                $this->error('编辑失败!');
            }
            $this->success('编辑成功!', url('Exam/index'));

        }
    }

    /**
     * 详细题目列表
     */
    public function detail() {
        $id = $this->request->param('id', 0, 'intval');
        if (!$id) $this->error('请选择一套试卷');
        $where = ['exam_id'=>$id, 'status'=>1];
        $exams_items = DB::name('Exam_item')
            ->where($where)
            ->order("list_order ASC,id ASC")
            ->select();
        $this->assign('list' , $exams_items);
        //获取试卷信息
        $info = DB::name('exam')->where(['id'=>$id])->find();
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
            } else {
                $this->success('编辑成功!', url('exam/editItem', ['item_id'=>$id, 'item_type'=>$data['type'], 'exam_id'=>$data['exam_id']]));
            }
        } else {
            //add
            unset($data['id']);
            $result = $ExamItemModel->allowField(true)->save($data);
            if ($result === false) {
                $this->error('添加失败!');
            }
            $this->success('添加成功!', url('exam/editItem', ['item_id'=>$result, 'item_type'=>$data['type'], 'exam_id'=>$data['exam_id']]));
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

    public function listOrder()
    {
        parent::listOrders(Db::name('exam_item'));
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
        //todo
        $ids                 = $this->request->param('ids');
        $selectedIds         = explode(',', $ids);

        $tpl = <<<tpl
<tr class='data-item-tr'>
    <td>
        <input type='checkbox' class='js-check' data-yid='js-check-y' data-xid='js-check-x' name='ids[]'
               value='\$id' data-name='\$name' \$checked>
    </td>
    <td>\$id</td>
    <td>\$spacer \$name</td>
</tr>
tpl;

        $categoryTree = CategoryModel::instance()->categoryTableTree($selectedIds, $tpl, 11);

        $where      = ['delete_time' => 0, 'type'=>11];
        $categories = CategoryModel::instance()->where($where)->select();

        $this->assign('categories', $categories);
        $this->assign('selectedIds', $selectedIds);
        $this->assign('categories_tree', $categoryTree);
        return $this->fetch('category/select');
    }
}