<?php
// +----------------------------------------------------------------------
// | 文件说明：用户-幻灯片
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: wuwu <15093565100@163.com>
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Date: 2017-5-25
// +----------------------------------------------------------------------

namespace api\v1\model;

use think\Model;

class PortalPostModel extends Model
{
    private static $instance = null;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    protected $visible = [
        'id', 'articles.id', 'user_id', 'post_id', 'post_type', 'comment_status',
        'is_top', 'recommended', 'post_hits', 'post_like', 'post_favorites','comment_count',
        'create_time', 'update_time', 'published_time', 'post_title', 'post_keywords',
        'post_excerpt', 'post_source', 'post_content', 'more', 'user_nickname',
        'user', 'category_id'
    ];

    /**
     * [base 全局查询范围status=1显示状态]
     * @Author:   wuwu<15093565100@163.com>
     * @DateTime: 2017-05-25T21:54:03+0800
     * @since:    1.0
     */
    protected function base($query)
    {
        $query->where('delete_time', 0)
            ->where('post_status', 1)
            ->whereTime('published_time', 'between', [1, time()]);
    }

    /**
     * image 自动转化
     * @param $value
     * @return array
     */
    public function getImageAttr($value)
    {
        return cmf_get_image_url($value);
    }

    public function getRecommendArticle()
    {
        $where = ['post_type' => 1, 'recommended' => 1];
        return $this->field(['id', 'post_title', 'published_time'])->where($where)->order(['id' => 'desc'])->limit(10)->select()->toArray();
    }
}

