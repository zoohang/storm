<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2018 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 老猫 <thinkcmf@126.com>
// +----------------------------------------------------------------------
namespace app\admin\model;

use app\admin\model\RouteModel;
use think\Model;
use tree\Tree;

class CourseItemModel extends Model
{
    protected $type = [
        'more' => 'array',
    ];

    public static $category_type = [
        0=>'全部',
        1=>'刷题',
        2=>'打卡',
        3=>'在线课堂',
        4=>'线下课堂',
        11=>'大学',
    ];

    public function getTypeAttr($value)
    {
        $status = [-1=>'默认',0=>'小节',1=>'视频',2=>'图文'];
        return $status[$value];
    }

    public function getStatusAttr($value)
    {
        $status = [0=>'删除',1=>'正常'];
        return $status[$value];
    }

    public function getCreateTimeAttr($value)
    {
        return $value ? date('Y-m-d H:i:s', $value):'';
    }

    public function getUpdateTimeAttr($value)
    {
        return $value ? date('Y-m-d H:i:s', $value):'';
    }

    public function getVideoLongAttr($value)
    {
        return $value;
    }

    /**
     * post_content 自动转化
     * @param $value
     * @return string
     */
    public function getDescriptionAttr($value)
    {
        return cmf_replace_content_file_url(htmlspecialchars_decode($value));
    }

    /**
     * post_content 自动转化
     * @param $value
     * @return string
     */
    public function setDescriptionAttr($value)
    {
        return htmlspecialchars(cmf_replace_content_file_url(htmlspecialchars_decode($value), true));
    }

    /**
     * 生成分类 select树形结构
     * @param int $selectId 需要选中的分类 id
     * @param int $currentCid 需要隐藏的分类 id
     * @return string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function categoryTree($selectId = 0, $currentCid = 0, $type=0)
    {
        $where = ['delete_time' => 0];
        if (!empty($currentCid)) {
            $where['id'] = ['neq', $currentCid];
        }
        if ($type) {
            $where['type'] = $type;
        }
        $categories = $this->order("list_order ASC")->where($where)->select()->toArray();

        $tree       = new Tree();
        $tree->icon = ['&nbsp;&nbsp;│', '&nbsp;&nbsp;├─', '&nbsp;&nbsp;└─'];
        $tree->nbsp = '&nbsp;&nbsp;';

        $newCategories = [];
        foreach ($categories as $item) {
            $item['selected'] = $selectId == $item['id'] ? "selected" : "";

            array_push($newCategories, $item);
        }

        $tree->init($newCategories);
        $str     = '<option value=\"{$id}\" {$selected}>{$spacer}{$name}</option>';
        $treeStr = $tree->getTree(0, $str);

        return $treeStr;
    }

    /**
     * 分类树形结构
     * @param int $currentIds
     * @param string $tpl
     * @return string
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function CategoryTableTree($currentIds = 0, $tpl = '', $type=0)
    {
        $where = ['status' => 1];
//        if (!empty($currentCid)) {
//            $where['id'] = ['neq', $currentCid];
//        }
        if (!empty($type)) {
            $where['type'] = $type;
        }
        $categories = $this->order("list_order ASC")->where($where)->select()->toArray();
        //dump($categories);
        $tree       = new Tree();
        $tree->icon = ['&nbsp;&nbsp;│', '&nbsp;&nbsp;├─', '&nbsp;&nbsp;└─'];
        $tree->nbsp = '&nbsp;&nbsp;';

        if (!is_array($currentIds)) {
            $currentIds = [$currentIds];
        }

        $newCategories = [];
        foreach ($categories as $item) {
            $item['id'] = $item['item_id'];
            $item['name'] = $item['item_title'];
            $item['parent_id_node'] = ($item['parent_id']) ? ' class="child-of-node-' . $item['parent_id'] . '"' : '';
            $item['style']          = empty($item['parent_id']) ? '' : '';
            $item['status_text']    = empty($item['status'])?'隐藏':'显示';
            if ($item['type']=='小节') {
                $edit_url = url("course/editSection", ["item_id" => $item['item_id'], 'cid'=>$item['cid']]);
                $del_url = url("course/delete_item", ["item_id" => $item['item_id']]);
            }elseif($item['type']=='视频') {
                $edit_url = url("course/editItem", ["item_id" => $item['item_id'], 'cid'=>$item['cid'], 'type'=>1]);
                $del_url = url("course/delete_item", ["item_id" => $item['item_id']]);
            } elseif($item['type']=='图文'){
                $edit_url = url("course/editItem", ["item_id" => $item['item_id'], 'cid'=>$item['cid'], 'type'=>2]);
                $del_url = url("course/delete_item", ["item_id" => $item['item_id']]);
            }
            $item['str_action']     = '<a href="' . $edit_url . '">' . lang('EDIT') . '</a>  <a class="js-ajax-delete" href="' . $del_url . '">' . lang('DELETE') . '</a> ';
            array_push($newCategories, $item);
        }

        $tree->init($newCategories);

        if (empty($tpl)) {
            $tpl = " <tr id='node-\$id' \$parent_id_node style='\$style' data-parent_id='\$parent_id' data-id='\$id'>
                        <td style='padding-left:20px;'><input type='checkbox' class='js-check' data-yid='js-check-y' data-xid='js-check-x' name='ids[]' value='\$id' data-parent_id='\$parent_id' data-id='\$id'></td>
                        <td><input name='list_orders[\$id]' type='text' size='3' value='\$list_order' class='input-order'></td>
                        <td>\$id</td>
                        <td>\$spacer <mark class='success'>\$name</mark></td>
                        <td>\$type</td>
                        <td>\$summary</td>
                        <td>\$create_time</td>
                        <td>\$update_time</td>
                        <td>\$str_action</td>
                    </tr>";
        }
        $treeStr = $tree->getTree(0, $tpl);
        return $treeStr;
    }

    /**
     * 添加文章分类
     * @param $data
     * @return bool
     */
    public function addCategory($data)
    {
        $result = true;
        self::startTrans();
        try {
            if (!empty($data['more']['thumbnail'])) {
                $data['more']['thumbnail'] = cmf_asset_relative_url($data['more']['thumbnail']);
            }
            $this->allowField(true)->save($data);
            $id = $this->id;
            if (empty($data['parent_id'])) {

                $this->where(['id' => $id])->update(['path' => '0-' . $id]);
            } else {
                $parentPath = $this->where('id', intval($data['parent_id']))->value('path');
                $this->where(['id' => $id])->update(['path' => "$parentPath-$id"]);

            }
            self::commit();
        } catch (\Exception $e) {
            self::rollback();
            $result = false;
        }

        return $result;
    }

    public function editCategory($data)
    {
        $result = true;

        $id          = intval($data['id']);
        $parentId    = intval($data['parent_id']);
        $oldCategory = $this->where('id', $id)->find();

        if (empty($parentId)) {
            $newPath = '0-' . $id;
        } else {
            $parentPath = $this->where('id', intval($data['parent_id']))->value('path');
            if ($parentPath === false) {
                $newPath = false;
            } else {
                $newPath = "$parentPath-$id";
            }
        }

        if (empty($oldCategory) || empty($newPath)) {
            $result = false;
        } else {

            $data['path'] = $newPath;
            if (!empty($data['more']['thumbnail'])) {
                $data['more']['thumbnail'] = cmf_asset_relative_url($data['more']['thumbnail']);
            }
            $this->isUpdate(true)->allowField(true)->save($data, ['id' => $id]);

            $children = $this->field('id,path')->where('path', 'like', $oldCategory['path'] . "-%")->select();
            if (!$children->isEmpty()) {
                foreach ($children as $child) {
                    $childPath = str_replace($oldCategory['path'] . '-', $newPath . '-', $child['path']);
                    $this->where('id', $child['id'])->update(['path' => $childPath], ['id' => $child['id']]);
                }
            }

            $routeModel = new RouteModel();
            if (!empty($data['alias'])) {
                $routeModel->setRoute($data['alias'], 'portal/List/index', ['id' => $data['id']], 2, 5000);
                $routeModel->setRoute($data['alias'] . '/:id', 'portal/Article/index', ['cid' => $data['id']], 2, 4999);
            } else {
                $routeModel->deleteRoute('portal/List/index', ['id' => $data['id']]);
                $routeModel->deleteRoute('portal/Article/index', ['cid' => $data['id']]);
            }

            $routeModel->getRoutes(true);
        }


        return $result;
    }

}