<?php
namespace app\admin\controller;

use app\admin\model\CategoryModel;
use app\admin\model\GoodsModel;
use cmf\controller\AdminBaseController;
use think\Response;
use think\Validate;

class GoodsController extends AdminBaseController
{
    //商品列表
    public function index()
    {
        $keyword = $this->request->param('keyword', '', 'trim,htmlentities');
        $type = $this->request->param('type', '', 'intval');
        $category_id = $this->request->param('category_id', '', 'intval');
        //var_dump($this->request->param('category_id'));die;
        $where = ['goods_status'=> ['EGT', 0]];
        if ($type) $where['goods_type'] = $type;
        if ($category_id) $where['category_id'] = $category_id;
        if ($type || $category_id) {
            $type_category = $this->getCategoryByType($type, $category_id?:0);
            $this->assign("type_category", $type_category);
        }
        if ($keyword) $where['goods_name'] = ['like', "%{$keyword}%"];
        $list = GoodsModel::instance()->where($where)->order(['goods_id'=>'desc'])->paginate(10);
        // 分页注入搜索条件
        $list->appends(['keyword' => $keyword, 'type' => $type, 'category_id'=>$category_id]);
        // 获取分页显示
        $page = $list->render();
        $this->assign(['keyword' => $keyword, 'type' => $type, 'category_id'=>$category_id]);
        $this->assign("page", $page);
        $this->assign("list", $list);
        return $this->fetch();
    }

    //更新商品信息
    public function edit()
    {
        $goods_id = $this->request->param('goods_id', 0, 'intval,abs');
        if (!$goods_id) $this->error('请选择一个商品');
        $info = GoodsModel::instance()->where(['goods_id'=>$goods_id])->find();
        $this->assign('info', $info);
        return $this->fetch();
}

    //保存更新
    public function save()
    {
        $param = $this->request->param();
        $result = $this->validate($param, 'Goods');
        if ($result !== true) {
            $this->error($result);
        }
        $res = GoodsModel::instance()->isUpdate(true)->allowField(true)->save($param);
        if ($res !== false) {
            $this->success('成功!');
        } else {
            $this->error('更新失败!');
        }
    }

    public function getCategoryByType($type='', $selectid=0)
    {
        $type = $type ?: $this->request->param('type', 0, 'intval,abs');
        if (!$type) $this->error('请选择类型');
        if (!in_array($type, [1,2,3,4]))  $this->error('只能选择 刷题 打卡 在线课堂 线下课堂中的一种');
        $list = CategoryModel::instance()->categoryTree($selectid, 0, $type);
        if ($this->request->action() != strtolower(__FUNCTION__)) {
            return $list;
        } else {
            $this->ajaxReturn($list);
        }
    }
}