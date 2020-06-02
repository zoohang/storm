<?php
namespace api\v2\model;

use think\Db;
use think\Model;

class MallModel extends Model
{
    public static $ctype = 5;
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
        $query->where('status', 1)
            ->whereTime('published_time', 'between', [1, time()]);
    }

    public static $list_field = [
        'id',
        #'cid',
        #'cname',
        #'post_title'=>'title',
        #'post_subtitle' => 'subtitle',
        'thumbnail',
    ];

    public static $detail_field = [
        'a.id',
        'a.cid',
        'a.cname',
        'a.post_title'=>'title',
        'a.post_subtitle' => 'subtitle',
        'a.join_num',
        'a.post_image' => 'image',
        #'a.post_content',
        'a.goods_id',
        'a.download_addr',
        'a.status',
        'a.more photos',
    ];

    public function getThumbnail200Attr($value,$data)
    {
        return get_image_url($data['thumbnail'],200);
    }

    public function getThumbnail480Attr($value,$data)
    {
        return get_image_url($data['thumbnail'],480);
    }

    public function getImageAttr($value, $data)
    {
        return get_image_url($data['image']);
    }

    public function getTypeNameAttr($value)
    {
        $types = [
            1 => '资料',
            2 => '实体书籍',
        ];
        return $types[$value];
    }

    public function getExamInfoByItemId($item_id) {
        return $info = Db::name('Exam')
            ->alias('a')
            ->join('__EXAM_ITEM__ b', 'a.id=b.exam_id')
            ->field(['a.*', 'b.id item_id', 'b.item_title', 'b.type'])
            ->where(['b.id'=>$item_id])
            ->find();
    }

    public function searchExam($keywords) {
        $where = ['status'=>1, 'title'=> ['like', "%{$keywords}%"]];
        $list = $this->where($where)->paginate();
        return $list;
    }

    public function getRecommendExam($num=4) {
        $where = ['a.recommended' => 1];
        $field = ['a.*', 'b.price'];
        return $this->alias('a')
            ->join('__GOODS__ b','a.goods_id=b.goods_id')
            ->field($field)
            ->where($where)
            ->order(['a.update_time' => 'desc'])->limit($num)->select()->toArray();
    }

    /**
     * @param int $cid 分类id
     * @param int $exclude 排除资源id
     * @param int $limit 查询条数 ps 增加视频内容的输出 type: text/video 资料和视频
     * @return false|\PDOStatement|string|\think\Collection
     * @throws \think\exception\DbException
     */
    public function getRelationList($cid, $exclude, $limit=6) {
        $texts = $this->field(['id','post_title'=>'title', 'type'=>'type_name'])
            ->where(['cid'=>$cid, 'id'=>['NEQ', $exclude]])
            ->order(['published_time'=>'desc', 'id'=>'desc'])
            ->limit($limit)
            ->select();
    }

    public function getDownLoadInfo($goods_id) {
        $download_addr = $this->where(['goods_id'=>$goods_id])->value('download_addr');
        return baiduLinkFormat($download_addr);
    }

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

    public function getMallTypeList() {
        $list = \app\admin\model\MallModel::instance()->mallTypeList;
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

