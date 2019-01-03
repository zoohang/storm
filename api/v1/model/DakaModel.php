<?php
namespace api\v1\model;

use think\Db;
use think\Model;

class DakaModel extends Model
{
    private static $instance = null;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    /**
     * [base 全局查询范围status=1显示状态]
     * @Author:   wuwu<15093565100@163.com>
     * @DateTime: 2017-05-25T21:54:03+0800
     * @since:    1.0
     */
    protected function base($query)
    {
        $query->where('post_status', 1)
            ->whereTime('published_time', 'between', [1, time()]);
    }

    /**
     * image 自动转化
     * @param $value
     * @return array
     */
    public function getThumbnailAttr($value)
    {
        return cmf_get_image_url($value);
    }

    public function getMoreAttr($value)
    {
        if (empty($value)) return [];
        $temp = json_decode($value, true);
        if (isset($temp['photos']) && $temp['photos']) {
            foreach($temp['photos'] as &$item) {
                $item['url'] = cmf_get_image_url($item['url']);
            }
        }
        if (isset($temp['files']) && $temp['files']) {
            foreach($temp['files'] as &$item) {
                $item['url'] = cmf_get_image_url($item['url']);
            }
        }
        return $temp;
    }
}

