<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: pl125 <xskjs888@163.com>
// +----------------------------------------------------------------------

namespace api\v2\model;

use think\Db;
use think\Model;

class CategoryModel extends \api\v1\model\CategoryModel
{
    const ALIAS_ENGLISH = 'english';
    const ALIAS_POLITICS = 'politics';
    const ALIAS_HISTORY = 'history';
    private static $instance = null;
    protected function base($query)
    {
        $query->where('type', $this->ctype)
            ->where('status', 1)
            ->where('delete_time', 0)
        ;
    }

    public static function instance($ctype)
    {
        if (is_null(self::$instance)) {
            self::$instance = new self($ctype);
        }
        return self::$instance;
    }

    public function getSimpleCategoryTreeArray($parent_id=0) {
        $where['type'] = $this->ctype;
        $categoryList = Db::name('Category')->field(['id','parent_id','name'])->where($where)->cache(true, 600)->select()->toArray();
        $tree = new \tree\Tree();
        $tree->init($categoryList);
        $data = $tree->getTreeArray($parent_id);
        $data = $this->sortArray($data);
        return $data;
    }

    protected function sortArray($data) {
        sort($data);
        foreach ($data as &$item) {
            if ($item['children']) {
                sort($item['children']);
            }
        }
        unset($item);
        return $data;
    }

    public function getFirstLevelCategory() {
        $where = [
            'type'=> $this->ctype,
            'status'=> 1,
            'delete_time'=> 0,
            'parent_id'=> 0,
        ];
        $data = Db::name('Category')
            ->field('id,name,0 as selected')
            ->where($where)
            ->cache(true, 600)
            ->order('list_order','desc')
            ->select();
        $data->unshift(['id'=>0,'name'=>'全部', 'selected'=>1]);
        return $data;
    }
}
