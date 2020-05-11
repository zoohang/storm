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

use app\admin\model\MallModel;
use app\admin\model\GoodsModel;
use cmf\controller\AdminBaseController;
use app\admin\model\CategoryModel;
use think\Cookie;
use think\Db;

class MallController extends AdminBaseController
{
    public $type=5; //category 表中type=1的分类
    public $status = [-1=>'删除', 0=>'未发布', 1=>'已发布'];
    public $types = [
        ['id'=> 1, 'name'=>'电子文档','desc'=>'兑换购买后根据所提供的百度网盘链接即可下载', 'select'=>'selected'],
        ['id'=> 2, 'name'=>'实体书籍','desc'=>'兑换购买后会通过客服联系并寄送到收货地址', 'select'=>''],
        ];
    public $levels = ['无等级','初级','中级','高级'];

    public function _initialize()
    {
        parent::_initialize();
        $this->assign('type', $this->type);
        $this->assign('status' ,$this->status);
        $this->assign('types' ,$this->types);
        $this->assign('levels' ,$this->levels);
    }

    public function index()
    {
        $where = [];
        /**搜索条件**/
        $keyword = $this->request->param('keyword');
        $cid = $this->request->param('cid', 0, 'intval');
        $level = $this->request->param('level', '');
        $where = ['status'=> ['EGT', 0]];
        if ($keyword) {
            $where['post_title'] = ['like', "%{$keyword}%"];
        }
        if ($cid) {
            $where['cid'] = $cid;
        }
        if ($cid) {
            //兼容下级栏目
            $data = \api\v1\model\CategoryModel::instance($this->type)->getCategoryTreeArray($cid);
            $ids = \api\v1\model\CategoryModel::instance($this->type)->getCategoryIds($data);
            array_unshift($ids, $cid);
            $where['cid'] = ['IN', $ids];
        }

        if ($level !== '') {
            $where['level'] = $level;
        }
        //获取所有的分类
        $categoryModel = new CategoryModel();
        $category_list = $categoryModel->categoryTree($cid, '', $this->type);
        $list = DB::name('Mall')
            ->where($where)
            ->order("list_order ASC,id DESC")
            ->paginate();
        // 分页注入搜索条件
        $list->appends(['keyword' => $keyword, 'cid'=>$cid, 'level'=>$level]);
        // 获取分页显示
        $page = $list->render();
        $this->assign(['keyword' => $keyword, 'cid'=>$cid, 'level'=>$level]);
        $this->assign("page", $page);
        $this->assign("list", $list);
        $this->assign("category_list", $category_list);
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
        return $this->fetch();
    }

    /**
     * 添加 post
     */
    public function addPost()
    {
        $MallModel = new MallModel();
        $data = $this->request->param();
        $goods = $data['goods'];
        $data = $data['post'];
        $result = $this->validate($data, 'Mall');
        if ($result !== true) {
            $this->error($result);
        }
        $category_info = Db::name('Category')->where(['id'=>$data['cid']])->find();
        $data['cname'] = $category_info['name'];
        $data['post_uid'] = session('ADMIN_ID');

        Db::startTrans();
        try{
            //商品售价
            $other = [
                'category_id'=> $data['cid'],
                'goods_name'=> $data['post_title'],
                'image'=> $data['thumbnail'],
                'goods_status' => $data['status'],
            ];
            $data['goods_id'] = GoodsModel::instance()->editGoods($goods, $other, $this->type);
            //多图上传
            if (!empty($data['photo_names']) && !empty($data['photo_urls'])) {
                $data['more']['photos'] = [];
                foreach ($data['photo_urls'] as $key => $url) {
                    array_push($data['more']['photos'], ["url" => $url, "name" => $data['photo_names'][$key]]);
                }
            }
            $MallModel->allowField(true)->isUpdate(false)->save($data);
            Db::commit();
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            $this->error($e->getMessage());
        }
        $this->success('添加成功!', url('Mall/index'));
    }

    /**
     * 编辑
     * @return mixed
     */
    public function edit()
    {
        $id    = $this->request->param('id', 0, 'intval');
        $MallModel = new MallModel();
        $info = $MallModel->where(["id" => $id])->find();
        $CategoryModel = new CategoryModel();
        $categoryTree = $CategoryModel->categoryTree($info['cid'], '', $this->type);
        $this->assign('category_tree', $categoryTree);
        $this->assign('post', $info);
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
            $MallModel = new MallModel();
            $data = $this->request->param();
            $goods = $data['goods'];
            $data = $data['post'];
            $category_info = Db::name('Category')->where(['id'=>$data['cid']])->find();
            $data['cname'] = $category_info['name'];
            unset($data['parent_id']);
            $result = $this->validate($data, 'Mall');

            if ($result !== true) {
                $this->error($result);
            }

            $other = [
                'category_id'=> $data['cid'],
                'goods_name'=> $data['post_title'],
                'image'=> $data['thumbnail'],
                'goods_status' => $data['status']
            ];

            if (!empty($data['photo_names']) && !empty($data['photo_urls'])) {
                $data['more']['photos'] = [];
                foreach ($data['photo_urls'] as $key => $url) {
                    array_push($data['more']['photos'], ["url" => $url, "name" => $data['photo_names'][$key]]);
                }
            }
            Db::startTrans();
            try{
                $data['goods_id'] = GoodsModel::instance()->editGoods($goods, $other, $this->type);
                $result = $MallModel->allowField(true)->isUpdate(true)->save($data);
                Db::commit();
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                $this->error('添加失败!');
            }
            $this->success('编辑成功!', url('Mall/index'));

        }
    }

    public function publish()
    {
        $param           = $this->request->param();
        $MallModel = new MallModel();

        if (isset($param['ids']) && isset($param["yes"])) {
            $ids = $this->request->param('ids/a');

            $MallModel->where(['id' => ['in', $ids]])->update(['status' => 1, 'published_time' => time()]);

            $this->success("发布成功！", '');
        }

        if (isset($param['ids']) && isset($param["no"])) {
            $ids = $this->request->param('ids/a');

            $MallModel->where(['id' => ['in', $ids]])->update(['status' => 0]);

            $this->success("取消发布成功！", '');
        }

    }
    
    public function top()
    {
        $param           = $this->request->param();
        $MallModel = new MallModel();

        if (isset($param['ids']) && isset($param["yes"])) {
            $ids = $this->request->param('ids/a');

            $MallModel->where(['id' => ['in', $ids]])->update(['is_top' => 1]);

            $this->success("置顶成功！", '');

        }

        if (isset($_POST['ids']) && isset($param["no"])) {
            $ids = $this->request->param('ids/a');

            $MallModel->where(['id' => ['in', $ids]])->update(['is_top' => 0]);

            $this->success("取消置顶成功！", '');
        }
    }

    public function recommend()
    {
        $param           = $this->request->param();
        $MallModel = new MallModel();

        if (isset($param['ids']) && isset($param["yes"])) {
            $ids = $this->request->param('ids/a');

            $MallModel->where(['id' => ['in', $ids]])->update(['recommended' => 1]);

            $this->success("推荐成功！", '');

        }
        if (isset($param['ids']) && isset($param["no"])) {
            $ids = $this->request->param('ids/a');

            $MallModel->where(['id' => ['in', $ids]])->update(['recommended' => 0]);

            $this->success("取消推荐成功！", '');

        }
    }

    public function listOrder()
    {
        parent::listOrders(Db::name('mall'));
        $this->success("排序更新成功！", '');
    }

    public function delete()
    {
        $param           = $this->request->param();
        $MallModel = new MallModel();
        if (isset($param['id'])) {
            if ($MallModel->isUpdate(true)->save(['status' => -1, 'delete_time'=>time()], ['id'=> $param['id']]) !== false) {
                $this->success("删除成功！");
            } else {
                $this->error("删除失败！");
            }
        }
        if (isset($param['ids'])) {
            if ($MallModel->isUpdate(true)->save(['status' => -1, 'delete_time'=>time()],['id'=> ['in', $param['ids']]]) !== false) {
                $this->success("删除成功！");
            } else {
                $this->error("删除失败！");
            }
        }
    }
}