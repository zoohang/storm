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

class YzwSchoolModel extends Model
{
    private static $instance = null;
    protected $hidden = ['url'];
    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    protected $connection = 'kaoyan';
    protected $table = 'spider_yzw_schools';
    protected $resultSetType = 'collection';

    public function getProvince()
    {
        return $this->cache(true, 600)->group('province_id')->field('province_id, province_name')->select();
    }
}
