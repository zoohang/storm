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

use app\admin\model\ExamModel;
use cmf\controller\AdminBaseController;
use app\admin\model\CategoryModel;
use think\Db;

class ExamController extends AdminBaseController
{
    public $type=1; //category 表中type=1的分类

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
            ->paginate(1);
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
     * 管理员添加
     * @adminMenu(
     *     'name'   => '管理员添加',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10000,
     *     'icon'   => '',
     *     'remark' => '管理员添加',
     *     'param'  => ''
     * )
     */
    public function add()
    {
        $CategoryModel = new CategoryModel();
        $categoryTree = $CategoryModel->categoryTree(0, '', $this->type);
        $this->assign('category_tree', $categoryTree);
        $college = $CategoryModel->field(['id','name'])->where(['type'=>11, 'status'=>1])->select()->toArray();
        $this->assign('college', $college);
        return $this->fetch();
    }

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
     * 管理员个人信息修改
     * @adminMenu(
     *     'name'   => '个人信息',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10000,
     *     'icon'   => '',
     *     'remark' => '管理员个人信息修改',
     *     'param'  => ''
     * )
     */
    public function userInfo()
    {
        $id   = cmf_get_current_admin_id();
        $user = Db::name('user')->where(["id" => $id])->find();
        $this->assign($user);
        return $this->fetch();
    }

    /**
     * 管理员个人信息修改提交
     * @adminMenu(
     *     'name'   => '管理员个人信息修改提交',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10000,
     *     'icon'   => '',
     *     'remark' => '管理员个人信息修改提交',
     *     'param'  => ''
     * )
     */
    public function userInfoPost()
    {
        if ($this->request->isPost()) {

            $data             = $this->request->post();
            $data['birthday'] = strtotime($data['birthday']);
            $data['id']       = cmf_get_current_admin_id();
            $create_result    = Db::name('user')->update($data);;
            if ($create_result !== false) {
                $this->success("保存成功！");
            } else {
                $this->error("保存失败！");
            }
        }
    }

    /**
     * 管理员删除
     * @adminMenu(
     *     'name'   => '管理员删除',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10000,
     *     'icon'   => '',
     *     'remark' => '管理员删除',
     *     'param'  => ''
     * )
     */
    public function delete()
    {
        $id = $this->request->param('id', 0, 'intval');
        if ($id == 1) {
            $this->error("最高管理员不能删除！");
        }

        if (Db::name('user')->delete($id) !== false) {
            Db::name("RoleUser")->where(["user_id" => $id])->delete();
            $this->success("删除成功！");
        } else {
            $this->error("删除失败！");
        }
    }

    /**
     * 停用管理员
     * @adminMenu(
     *     'name'   => '停用管理员',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10000,
     *     'icon'   => '',
     *     'remark' => '停用管理员',
     *     'param'  => ''
     * )
     */
    public function ban()
    {
        $id = $this->request->param('id', 0, 'intval');
        if (!empty($id)) {
            $result = Db::name('user')->where(["id" => $id, "user_type" => 1])->setField('user_status', '0');
            if ($result !== false) {
                $this->success("管理员停用成功！", url("user/index"));
            } else {
                $this->error('管理员停用失败！');
            }
        } else {
            $this->error('数据传入失败！');
        }
    }

    /**
     * 启用管理员
     * @adminMenu(
     *     'name'   => '启用管理员',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10000,
     *     'icon'   => '',
     *     'remark' => '启用管理员',
     *     'param'  => ''
     * )
     */
    public function cancelBan()
    {
        $id = $this->request->param('id', 0, 'intval');
        if (!empty($id)) {
            $result = Db::name('user')->where(["id" => $id, "user_type" => 1])->setField('user_status', '1');
            if ($result !== false) {
                $this->success("管理员启用成功！", url("user/index"));
            } else {
                $this->error('管理员启用失败！');
            }
        } else {
            $this->error('数据传入失败！');
        }
    }
}