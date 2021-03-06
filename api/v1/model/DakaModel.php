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
        return get_image_url($value);
    }

    public function getPostImageAttr($value)
    {
        return get_image_url($value);
    }

    public function getMoreAttr($value)
    {
        if (empty($value)) return [];
        $temp = json_decode($value, true);
        if (isset($temp['photos']) && $temp['photos']) {
            foreach($temp['photos'] as &$item) {
                $item['url'] = get_image_url($item['url']);
            }
        }
        if (isset($temp['files']) && $temp['files']) {
            foreach($temp['files'] as &$item) {
                $item['url'] = get_image_url($item['url']);
            }
        }
        return $temp;
    }

    /**
     * post_content 自动转化
     * @param $value
     * @return string
     */
    public function getPostContentAttr($value)
    {
        return replace_content_file_url(htmlspecialchars_decode($value));
    }

    public function searchDaka($keywords) {
        $where = ['post_title'=> ['like', "%{$keywords}%"]];
        $list = $this->where($where)->paginate();
        return $list;
    }

    public function getRecommendDaka($num=3) {
        $userid = request()->post('user_id');
        $where = ['recommended' => 1];
        $field = ['a.id','a.post_title','a.thumbnail','a.published_time', 'a.end_time','a.join_num','a.daka_num','a.goods_id','b.price', 'IFNULL(c.order_status,0) is_buy'];
        return $this->alias('a')
            ->join('__GOODS__ b', 'a.goods_id=b.goods_id')
            ->join('__ORDER__ c', "a.goods_id=c.order_id and c.user_id={$userid} and pay_status=2 and order_status=1", 'left')
            ->where($where)
            ->field($field)->order(['list_order' => 'desc'])->limit($num)->select()->toArray();
    }

    public function price() {
        $this->hasOne('__GOODS__', 'goods_id', 'goods_id');
    }
}

