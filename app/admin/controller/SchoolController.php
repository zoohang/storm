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

use app\admin\model\SchoolModel;
use cmf\controller\AdminBaseController;
use think\Db;

class SchoolController extends AdminBaseController
{
    
    public function index()
    {
        $schoolModel = new SchoolModel();
        $schools         = $schoolModel->where(['status' => 1])->select();
        $this->assign('schools', $schools);
        return $this->fetch();
    }

    public function add()
    {
        return $this->fetch();
    }

    public function addPost()
    {
        $data           = $this->request->param();
        $schoolModel = new SchoolModel();
        $result         = $schoolModel->validate(true)->save($data);
        if ($result === false) {
            $this->error($schoolModel->getError());
        }
        $this->success("添加成功！", url("school/index"));
    }

    public function edit()
    {
        $id             = $this->request->param('id');
        $schoolModel = new SchoolModel();
        $result         = $schoolModel->where('id', $id)->find();
        $this->assign('result', $result);
        return $this->fetch();
    }

    public function editPost()
    {
        $data           = $this->request->param();
        $schoolModel = new SchoolModel();
        $result         = $schoolModel->validate(true)->save($data, ['id' => $data['id']]);
        if ($result === false) {
            $this->error($schoolModel->getError());
        }
        $this->success("保存成功！", url("school/index"));
    }

    public function delete()
    {
        $id             = $this->request->param('id', 0, 'intval');
        $schoolModel = new SchoolModel();
        $result       = $schoolModel->where(['id' => $id])->find();
        if (empty($result)){
            $this->error('学校不存在!');
        }

        //如果存在页面。则不能删除。
        $count = Db::name('exam_school_relation')->where('school_id', $id)->count();
        if ($count > 0) {
            $this->error('此学校有关联刷题无法删除!');
        }

        $data         = [
            'object_id'   => $id,
            'create_time' => time(),
            'table_name'  => 'school',
            'name'        => $result['name']
        ];

        $result = $schoolModel->save(['delete_time' => time(), 'status'=>0], ['id' => $id]);
        if ($result) {
            Db::name('recycleBin')->insert($data);
        }
        $this->success("删除成功！", url("school/index"));
    }
}