<?php
namespace api\v1\model;

use think\Db;
use think\Model;

class ExamModel extends Model
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
        return cmf_get_image_url($value);
    }

    public function getTypeAttr($value)
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
}

