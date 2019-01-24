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

use app\admin\model\RecommendModel;
use cmf\controller\AdminBaseController;
use think\Db;

class RecommendController extends AdminBaseController
{
    
    public function index()
    {
        $recommendModel = new RecommendModel();
        $list         = $recommendModel->where(['status' => ['EGT', 0]])->order(['list_order'=>'asc', 'id'=>'desc'])->select();
        $this->assign('list', $list);
        return $this->fetch();
    }

    public function add()
    {
        return $this->fetch();
    }

    public function addPost()
    {
        $data           = $this->request->param();
        $recommendModel = new RecommendModel();
        $result         = $recommendModel->validate(true)->save($data);
        if ($result === false) {
            $this->error($recommendModel->getError());
        }
        $this->success("添加成功！", url("recommend/index"));
    }

    public function edit()
    {
        $id             = $this->request->param('id');
        $recommendModel = new RecommendModel();
        $result         = $recommendModel->where('id', $id)->find();
        $this->assign('result', $result);
        return $this->fetch();
    }

    public function editPost()
    {
        $data           = $this->request->param();
        $recommendModel = new RecommendModel();
        $result         = $recommendModel->validate(true)->save($data, ['id' => $data['id']]);
        if ($result === false) {
            $this->error($recommendModel->getError());
        }
        $this->success("保存成功！", url("recommend/index"));
    }

    public function delete()
    {
        $id             = $this->request->param('id', 0, 'intval');
        $recommendModel = new RecommendModel();
        $result       = $recommendModel->where(['id' => $id])->find();
        if (empty($result)){
            $this->error('不存在!');
        }
        $result = $recommendModel->save(['status'=>-1], ['id' => $id]);
        $this->success("删除成功！", url("recommend/index"));
    }

    public function toggle()
    {
        $data                = $this->request->param();
        $recommendModel = new RecommendModel();

        if (isset($data['ids']) && !empty($data["display"])) {
            $ids = $this->request->param('ids/a');
            $recommendModel->where(['id' => ['in', $ids]])->update(['status' => 1]);
            $this->success("更新成功！");
        }

        if (isset($data['ids']) && !empty($data["hide"])) {
            $ids = $this->request->param('ids/a');
            $recommendModel->where(['id' => ['in', $ids]])->update(['status' => 0]);
            $this->success("更新成功！");
        }

    }

    public function listOrder()
    {
        parent::listOrders(RecommendModel::instance());
        $this->success("排序更新成功！", '');
    }
}