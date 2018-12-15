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

    /**
     * @param int $num
     * @return array
     */
    public function getRecommendCourse($num=4)
    {
        $where = ['recommended' => 1];
        return $this->where($where)->order(['list_order' => 'desc'])->limit(10)->select()->toArray();
    }
}

