<?php
// +----------------------------------------------------------------------
// | 文件说明：用户表关联model 
// +----------------------------------------------------------------------
// | Copyright (c) 2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: wuwu <15093565100@163.com>
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Date: 2017-7-26
// +----------------------------------------------------------------------
namespace api\v2\model;

use think\Db;
use think\Model;

class YzwCategoryModel extends Model
{
    private static $instance = null;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    protected $connection = 'kaoyan';
    protected $table = 'spider_yzw_category';

    public function getUpCategoryByCode($code)
    {
        if (strlen($code) > 4) { // 提取出里面的code的前四位
            if (preg_match('/\d{4}/', $code, $match)) {
                $code = current($match);
            }
        }
        return $this->cache(true, 600)->alias('a')
            ->join('spider_yzw_category b', 'b.pid=a.id')
            ->field('a.`name` name1,a.`code`,b.`name` name2,b.`code` code2')
            ->where(['b.code' => $code])->find()->toArray();
    }
}
