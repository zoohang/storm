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

use app\admin\model\DakaModel;
use app\admin\model\ExamItemModel;
use app\admin\model\ExamModel;
use cmf\controller\AdminBaseController;
use app\admin\model\CategoryModel;
use think\Cookie;
use think\Db;

class DakaController extends AdminBaseController
{
    public $type=2; //category 表中type=1的分类
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
        $where = ['parent_id'=>0];
        /**搜索条件**/
        $keyword = $this->request->param('keyword');
        $category = $this->request->param('category', '', 'intval');
        if ($keyword) {
            $where['post_title'] = ['like', "%{$keyword}%"];
        }
        if ($category) {
            $where['category_id'] = $category;
            $selectId = $category;
        } else $selectId=0;
        //所属分类 start
        $categoryModel = new CategoryModel();
        $category_list = $categoryModel->categoryTree($selectId, '', $this->type);
        $this->assign("category_list", $category_list);
        //所属分类 end
        $list = DakaModel::instance()
            ->where($where)
            ->order(['list_order'=>'asc', 'id'=>'desc'])
            ->paginate();
        // 分页注入搜索条件
        $list->appends(['keyword' => $keyword, 'category' => $category]);
        // 获取分页显示
        $page = $list->render();
        $this->assign(['keyword' => $keyword, 'category' => $category]);
        $this->assign("page", $page);
        $this->assign("list", $list);
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
     * 添加
     */
    public function addPost()
    {
        if ($this->request->isPost()) {
            $data = $this->request->param();

            //需要抹除发布、置顶、推荐的修改。
            unset($data['post']['post_status']);
            unset($data['post']['is_top']);
            unset($data['post']['recommended']);

            $post   = $data['post'];
            $result = $this->validate($post, 'Daka');
            if ($result !== true) {
                $this->error($result);
            }

            $model = new DakaModel();

            if (!empty($data['photo_names']) && !empty($data['photo_urls'])) {
                $data['post']['more']['photos'] = [];
                foreach ($data['photo_urls'] as $key => $url) {
                    $photoUrl = cmf_asset_relative_url($url);
                    array_push($data['post']['more']['photos'], ["url" => $photoUrl, "name" => $data['photo_names'][$key]]);
                }
            }

            if (!empty($data['file_names']) && !empty($data['file_urls'])) {
                $data['post']['more']['files'] = [];
                foreach ($data['file_urls'] as $key => $url) {
                    $fileUrl = cmf_asset_relative_url($url);
                    array_push($data['post']['more']['files'], ["url" => $fileUrl, "name" => $data['file_names'][$key]]);
                }
            }
            $res = $model->adminAddArticle($data['post'], $data['post']['category_id']);
            $this->success('保存成功!', url('Daka/edit', ['id'=> $res->id]));

        }
    }

    /**
     * 编辑
     * @return mixed
     */
    public function edit()
    {
        $id    = $this->request->param('id', 0, 'intval');
        $info = DakaModel::instance()->where(["id" => $id])->find();
        $CategoryModel = new CategoryModel();
        $categoryTree = $CategoryModel->categoryTree($info['category_id'], '', $this->type);
        $this->assign('category_tree', $categoryTree);
        $this->assign('post', $info);
        return $this->fetch();
    }

    /**
     * 保存
     */
    public function editPost()
    {
        if ($this->request->isPost()) {
            $model = new DakaModel();
            $data = $this->request->param();

            $post   = $data['post'];
            $result = $this->validate($post, 'Daka');
            if ($result !== true) {
                $this->error($result);
            }

            $category_info = Db::name('Category')->where(['id'=>$post['category_id']])->find();
            $post['category_name'] = $category_info['name'];

            if (!empty($data['photo_names']) && !empty($data['photo_urls'])) {
                $data['post']['more']['photos'] = [];
                foreach ($data['photo_urls'] as $key => $url) {
                    $photoUrl = cmf_asset_relative_url($url);
                    array_push($data['post']['more']['photos'], ["url" => $photoUrl, "name" => $data['photo_names'][$key]]);
                }
            }

            if (!empty($data['file_names']) && !empty($data['file_urls'])) {
                $data['post']['more']['files'] = [];
                foreach ($data['file_urls'] as $key => $url) {
                    $fileUrl = cmf_asset_relative_url($url);
                    array_push($data['post']['more']['files'], ["url" => $fileUrl, "name" => $data['file_names'][$key]]);
                }
            }

            $result =  $model->adminEditArticle($data['post'], $data['post']['category_id']);
            if ($result === false) {
                $this->error('编辑失败!');
            }
            $this->success('编辑成功!', url('Daka/edit', ['id'=> $data['post']['id']]));

        }
    }

    /**
     * 详细题目列表
     */
    public function detail() {

        $id = $this->request->param('id', 0, 'intval');
        if (!$id) $this->error('请选择一套打卡内容');
        $where = ['parent_id'=>$id, 'post_status'=>1];
        $list = DakaModel::instance()
            ->where($where)
            ->order("list_order ASC,id ASC")
            ->select();
        $this->assign('list' , $list);
        //获取信息
        $info = DakaModel::instance()->where(['id'=>$id])->find();
        $this->assign('info', $info);
        return $this->fetch();
    }

    /**
     * 编辑题目
     */
    public function editItem() {
        $parent_id = $this->request->param('parent_id', 0, 'intval');
        $id = $this->request->param('id', 0, 'intval');
        if (!$parent_id) $this->error('父级id不能为空');
        //题目信息
        $parent_info = DakaModel::instance()->where(['id'=>$parent_id])->find();
        $info = [];
        if ($id) {
            $info = DakaModel::instance()->where(['id'=>$id])->find();
        }
        $this->assign('parent_info', $parent_info);
        $this->assign('post', $info);
        return $this->fetch();
    }

    /**
     * 保存题目
     */
    public function saveItem() {
        $id = $this->request->param('id');
        $parent_id = $this->request->param("parent_id");
        $model = new DakaModel();
        $data = $this->request->param();
        if ($id) {
            $info = DakaModel::instance()->where(['id'=>$id])->find();
        } elseif($parent_id) {
            $info = DakaModel::instance()->where(['id'=>$parent_id])->find();
            $data['post']['parent_id'] = $info['id'];
        } else {
            $this->error('缺少关键数据');
        }

        $data['post']['category_id'] = $info['category_id'];
        $post   = $data['post'];
        $result = $this->validate($post, 'Daka');
        if ($result !== true) {
            $this->error($result);
        }

        if (!empty($data['photo_names']) && !empty($data['photo_urls'])) {
            $data['post']['more']['photos'] = [];
            foreach ($data['photo_urls'] as $key => $url) {
                $photoUrl = cmf_asset_relative_url($url);
                array_push($data['post']['more']['photos'], ["url" => $photoUrl, "name" => $data['photo_names'][$key]]);
            }
        }

        if (!empty($data['file_names']) && !empty($data['file_urls'])) {
            $data['post']['more']['files'] = [];
            foreach ($data['file_urls'] as $key => $url) {
                $fileUrl = cmf_asset_relative_url($url);
                array_push($data['post']['more']['files'], ["url" => $fileUrl, "name" => $data['file_names'][$key]]);
            }
        }

        if ($id) {
            //save
            $result =  $model->adminEditArticle($data['post'], $data['post']['category_id']);
            if ($result === false) {
                $this->error('编辑失败!');
            }
            $this->success('编辑成功!', url('Daka/editItem', ['id'=> $data['post']['id'], 'parent_id'=>$parent_id]));
        } else {
            //add
            //需要抹除发布、置顶、推荐的修改。
            unset($data['post']['post_status']);
            unset($data['post']['is_top']);
            unset($data['post']['recommended']);
            unset($data['post']['id']);
            $data['post']['parent_id'] =  $parent_id;
            //var_dump($data['post'], $data['post']['category_id']);die;
            $res = $model->adminAddArticle($data['post'], $data['post']['category_id']);
            $this->success('编辑成功!', url('Daka/editItem', ['id'=> $res->id, 'parent_id'=>$parent_id]));
        }
    }

    public function publish()
    {
        $param           = $this->request->param();
        $model = new DakaModel();

        if (isset($param['ids']) && isset($param["yes"])) {
            $ids = $this->request->param('ids/a');

            $model->where(['id' => ['in', $ids]])->update(['post_status' => 1, 'update_time' => time()]);

            $this->success("发布成功！", '');
        }

        if (isset($param['ids']) && isset($param["no"])) {
            $ids = $this->request->param('ids/a');

            $model->where(['id' => ['in', $ids]])->update(['post_status' => 0]);

            $this->success("取消发布成功！", '');
        }

    }
    
    public function top()
    {
        $param           = $this->request->param();
        $model = new DakaModel();

        if (isset($param['ids']) && isset($param["yes"])) {
            $ids = $this->request->param('ids/a');

            $model->where(['id' => ['in', $ids]])->update(['is_top' => 1]);

            $this->success("置顶成功！", '');

        }

        if (isset($_POST['ids']) && isset($param["no"])) {
            $ids = $this->request->param('ids/a');

            $model->where(['id' => ['in', $ids]])->update(['is_top' => 0]);

            $this->success("取消置顶成功！", '');
        }
    }

    public function recommend()
    {
        $param           = $this->request->param();
        $model = new DakaModel();

        if (isset($param['ids']) && isset($param["yes"])) {
            $ids = $this->request->param('ids/a');

            $model->where(['id' => ['in', $ids]])->update(['recommended' => 1]);

            $this->success("推荐成功！", '');

        }
        if (isset($param['ids']) && isset($param["no"])) {
            $ids = $this->request->param('ids/a');

            $model->where(['id' => ['in', $ids]])->update(['recommended' => 0]);

            $this->success("取消推荐成功！", '');

        }
    }

    public function listOrder()
    {
        $model = new DakaModel();
        parent::listOrders($model);
        $this->success("排序更新成功！", '');
    }


    public function toggle()
    {
        $data                = $this->request->param();
        $examItemModel = new ExamItemModel();

        if (isset($data['ids']) && !empty($data["display"])) {
            $ids = $this->request->param('ids/a');
            $examItemModel->where(['id' => ['in', $ids]])->update(['post_status' => 1]);
            $this->success("更新成功！");
        }

        if (isset($data['ids']) && !empty($data["hide"])) {
            $ids = $this->request->param('ids/a');
            $examItemModel->where(['id' => ['in', $ids]])->update(['post_status' => 0]);
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
}