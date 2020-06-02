<?php
namespace api\v2\model;

use think\Db;
use think\Model;

class CourseModel extends \api\v1\model\CourseModel
{
    private static $instance = null;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    public static $levels = [
        ['id'=>0, 'name'=>'全部'],
        ['id'=>1, 'name'=>'初级'],
        ['id'=>2, 'name'=>'中级'],
        ['id'=>3, 'name'=>'高级'],
    ];

    public static $list_field = [
        'cid' => 'id',
        'ctitle' => 'title',
        'pid' => 'cid',
        'pname'=> 'cname',
        'level',
        'image'=>'thumbnail',
    ];

    public static $deteil_field = [
        'cid' => 'id',
        'ctitle' => 'title',
        'pid' => 'cid',
        'pname'=> 'cname',
        'description',
        'level',
        'content_img'=>'image',
        'join_num',
        'a.goods_id',
        'more' => 'photos',
        'type',
    ];

    public static $item_field = [
        'item_id',
        'item_title',
        #'parent_id',
        #'summary',
        #'description',
        'video_long',
        'video_id',
        'a.cid' => 'id',
        'download_addr',
    ];

    /*public function getThumbnailAttr($value,$data)
    {
        return get_image_url($data['thumbnail']);
    }*/

    public function getMoreAttr($value)
    {
        return json_decode($value, true);
    }

    public function getPhotosAttr($value, $data)
    {
        if (empty($data['photos'])) return [];
        $more = json_decode($data['photos'], true);
        $photos = $more['photos'];
        $photos = array_map(function($item){
            $item['url'] = get_image_url($item['url'], 750);
            return $item;
        }, $photos);
        return $photos;
    }

    public function getDescriptionAttr($value)
    {
        $search = ["\r\n","\r", "\n", "\t"];
        return str_replace($search, ' ', $value);
    }

    /**
     * @param int $cid 分类id
     * @param int $exclude 排除资源id
     * @param int $limit 查询条数 ps 增加视频内容的输出 type: text/video 资料和视频
     * @return false|\PDOStatement|string|\think\Collection
     * @throws \think\exception\DbException
     */
    public function getRelationList($cid, $exclude, $limit=6) {
        return $this->field(['cid'=>'id','ctitle'=>'title', 'type', 'type'=>'type_name'])
            ->where(['pid'=>$cid, 'cid'=>['NEQ', $exclude], 'type'=>1])
            ->order(['published_time'=>'desc', 'id'=>'desc'])
            ->limit($limit)
            ->select();
    }

    public function getTypeNameAttr($value, $data)
    {
        $types = [
            1 => '视频',
            2 => '图文',
        ];
        return $types[$data['type']];
    }

    public function getThumbnailAttr($value)
    {
        return get_image_url($value, 200);
    }

    public function getThumbnail_480Attr($value)
    {
        return get_image_url($value, 480);
    }

    //仅仅获取视频 购买
    public function getBugVideoCourse($uid) {
        $where = ['b.user_id'=>$uid, 'b.pay_status'=>2, 'b.order_status'=>1, 'a.type'=>1];
        return $this->alias('a')
            ->field(['a.cid'=>'id','a.image'=>'thumbnail_480'])
            ->join('__ORDER__ b','a.goods_id=b.goods_id')
            ->where($where)
            ->order('b.pay_time','desc')
            ->paginate();
    }
    //仅仅获取视频 收藏
    public function getCollectionVideoCourse($uid) {
        $where = ['b.user_id'=>$uid, 'b.type'=>3, 'a.type'=>1];
        return $this->alias('a')
            ->field(['a.cid'=>'id','a.image'=>'thumbnail_480'])
            ->join('__USER_FAVORITE__ b', 'a.cid=b.object_id')
            ->where($where)
            ->order(['b.id'=>'desc'])
            ->paginate();
    }

    public function getCourseTypeList() {
        $list = \app\admin\model\CourseModel::instance()->courseTypeList;
        array_walk($list, function(&$item, $key){
            if (!$key){
                $item = ['id'=>$key, 'name'=>'全部', 'selected'=>1];
            } else {
                $item = ['id'=>$key, 'name'=>$item, 'selected'=>0];
            }
        });
        unset($item);
        return $list;
    }
}

