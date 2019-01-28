<?php
namespace api\v1\model;

use think\Db;
use think\Model;

class CourseModel extends Model
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
        $query->where('status', 1)
            ->whereTime('published_time', 'between', [1, time()]);
    }

    /**
     * image 自动转化
     * @param $value
     * @return array
     */
    public function getImageAttr($value)
    {
        return get_image_url($value);
    }

    public function getContentImgAttr($value)
    {
        return get_image_url($value);
    }

    /*public function getTypeAttr($value)
    {
        switch ($value) {
            case 1:
                $name='视频';
                break;
            case 2:
                $name='语音';
                break;
            case 3:
                $name='图文';
                break;
            default:
                $name='默认';
        }
        return $name;
    }*/

    /**
     * @param int $num
     * @return array
     */
    public function getRecommendCourse($num=4)
    {
        $userid = request()->post('user_id');
        $where = ['a.recommended' => 1];
        $field = ['a.cid', 'a.ctitle', 'a.num', 'a.join_num', 'a.type', 'a.image', 'b.price', 'IFNULL(c.order_status,0) is_buy'];
        //todo 判断用户是否购买
        return $this->alias('a')
            ->join('__GOODS__ b', 'a.goods_id=b.goods_id')
            ->join('__ORDER__ c', "a.goods_id=c.order_id and c.user_id={$userid} and pay_status=2 and order_status=1", 'left')
            ->field($field)
            ->where($where)->order(['list_order' => 'desc'])
            ->limit($num)->select()->toArray();
    }

    public function getRelationTeachers($cid) {
        $teachers = Db::name('course_teacher_relation a')->join('__COURSE_TEACHER__ b', 'a.tid=b.tid')->field(['b.tid', 'b.tname', 'b.summary', 'b.description', 'b.avatar'])->where(['a.cid'=>$cid, 'a.status'=>1, 'b.status'=>1])->select()->toArray();
        foreach ($teachers as &$item) {
            $item['avatar'] = get_image_url($item['avatar']);
        }
        unset($item);
        return $teachers;
    }

    public function searchCourse($keywords) {
        $where = ['ctitle'=> ['like', "%{$keywords}%"]];
        $list = $this->where($where)->paginate();
        return $list;
    }

    public function getBugCourse() {
        $where = ['b.user_id'=>request()->post('user_id'), 'b.pay_status'=>2, 'b.order_status'=>1];
        return $this->alias('a')->join('__ORDER__ b','a.goods_id=b.goods_id')->field('a.*')->where($where)->select();
    }

    public function getCollectionCourse() {
        $where = ['b.user_id'=>request()->post('user_id'), 'b.type'=>3];
        return $this->alias('a')->join('__USER_FAVORITE__ b', 'a.cid=b.object_id')->where($where)->order(['b.id'=>'desc'])->select();
    }
}

