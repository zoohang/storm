<?php
namespace app\admin\controller;

use app\admin\model\CategoryModel;
use app\admin\model\GoodsModel;
use cmf\controller\AdminBaseController;

class GoodsController extends AdminBaseController
{
    //商品列表
    public function index()
    {
        $keywords = $this->request->param('keywords', '', 'trim,htmlentities');
        $type = $this->request->param('type', '', 'intval');
        $category_id = $this->request->param('category_id', '', 'intval');

        $where = ['goods_status'=> ['EGT'=>0]];
        if ($type) $where['goods_type'] = $type;
        if ($category_id) $where['category_id'] = $category_id;
        if ($keywords) $where['goods_name'] = ['like', "%{$keywords}%"];

        $list = GoodsModel::instance()->where($where)->order(['goods_id'=>'desc'])->paginate();
        // 分页注入搜索条件
        $list->appends(['keyword' => $keywords, 'type' => $type, 'category_id'=>$category_id]);
        // 获取分页显示
        $page = $list->render();
        $this->assign(['keywords' => $keywords, 'type' => $type, 'category_id'=>$category_id]);
        $this->assign("page", $page);
        $this->assign("list", $list);
        return $this->fetch();
    }

    //更新商品信息 todo
    public function edit()
    {
        $goods_id = $this->request->param('goods_id', 0, 'intval,abs');
        if (!$goods_id) $this->error('请选择一个商品');
        GoodsModel::instance()->where();
}

    //保存更新
    public function save()
    {

    }

    public function getCategoryByType($type='')
    {
        $type = $type ?: $this->request->param('type', 0, 'intval,abs');
        if (!$type) $this->error('请选择类型');
        if (!in_array($type, [1,2,3,4]))  $this->error('只能选择 刷题 打卡 在线课堂 线下课堂中的一种');
        $list = CategoryModel::instance()->categoryTree(0, 0, $type);
        exit($list);
    }
}