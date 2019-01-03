<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: pl125 <xskjs888@163.com>
// +----------------------------------------------------------------------

namespace api\v1\model;

use think\Db;
use think\Model;

class CategoryModel extends Model
{
    private static $instance = null;
    protected $ctype = 0;
    public static function instance($ctype)
    {
        if (is_null(self::$instance)) {
            self::$instance = new self($ctype);
        }
        return self::$instance;
    }

    //类型转换
    protected $type = [
        'more' => 'array',
    ];

    public function __construct($ctype)
    {
        parent::__construct();
        $this->ctype = $ctype;
    }

    /**
     * 基础查询
     */
    protected function base($query)
    {
        $query->where('type', $this->ctype)
            ->where('status', 1);
    }

    public function getCategoryTreeArray($parent_id=0) {
        $where['type'] = $this->ctype;
        $categoryList = Db::name('Category')->where($where)->select()->toArray();
        $tree = new \tree\Tree();
        $tree->init($categoryList);
        $data = $tree->getTreeArray($parent_id);
        return $data;
    }

    public function getCategoryIds($data) {
        if (!$data) return [];
        static $ids = [];
        if ($data && is_array($data)) {
            foreach ($data as $item) {
                $ids[] = $item['id'];
                if ($item['children']) {
                    $this->getCategoryIds($item['children']);
                }
            }
        }
        return $ids;
    }
}
