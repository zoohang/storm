<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: pl125 <xskjs888@163.com>
// +----------------------------------------------------------------------

namespace api\V1\model;

use api\common\model\CommonModel;

class PortalCategoryModel extends CommonModel
{
    private static $instance = null;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    //类型转换
    protected $type = [
        'more' => 'array',
    ];

    //可查询字段
    protected $visible = [
        'id', 'name', 'description', 'post_count', 'parent_id',
        'seo_title', 'seo_keywords', 'seo_description',
	'list_order','more', 'PostIds', 'articles'
    ];

    //模型关联方法
    protected $relationFilter = ['articles'];

    /**
     * 基础查询
     */
    protected function base($query)
    {
        $query->alias('portal_category')->where('delete_time', 0)
            ->where('portal_category.status', 1);
    }

    /**
     * more 自动转化
     * @param $value
     * @return array
     */
    public function getMoreAttr($value)
    {
        $more = json_decode($value, true);
        if (!empty($more['thumbnail'])) {
            $more['thumbnail'] = cmf_get_image_url($more['thumbnail']);
        }

        if (!empty($more['photos'])) {
            foreach ($more['photos'] as $key => $value) {
                $more['photos'][$key]['url'] = cmf_get_image_url($value['url']);
            }
        }
        return $more;
    }

    /**
     * 关联文章表
     * @return $this
     */
    public function articles()
    {
        return $this->belongsToMany('PortalPostModel', 'portal_category_post', 'post_id', 'category_id');
    }

    /**
     * [PostIds 关联]
     * @Author:   wuwu<15093565100@163.com>
     * @DateTime: 2017-07-17T15:20:31+0800
     * @since:    1.0
     */
    public function PostIds()
    {
        return self::hasMany('PortalCategoryPostModel', 'category_id', 'id');
    }

    /**
     * [categoryPostIds 此类文章id数组]
     * @Author:   wuwu<15093565100@163.com>
     * @DateTime: 2017-07-17T15:21:08+0800
     * @since:    1.0
     * @param     [type]                   $category_id [分类ID]
     * @return    [type]                                [文章id数组]
     */
    public static function categoryPostIds($category_id)
    {
        $ids      = [];
        $post_ids = self::relation('PostIds')->field(true)->where('id', $category_id)->find();
        foreach ($post_ids['PostIds'] as $key => $id) {
            $ids[] = $id['post_id'];
        }
        $post_ids['PostIds'] = $ids;
        return $post_ids;
    }

    public function getCategoryTreeArray($parent_id=0) {
        $categoryList = $this->select()->toArray();
        $tree = new \tree\Tree();
        $tree->init($categoryList);
        $data = $tree->getTreeArray($parent_id);
        sort($data);
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
