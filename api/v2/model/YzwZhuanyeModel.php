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
use think\helper\Str;
use think\Model;

class YzwZhuanyeModel extends Model
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
    protected $table = 'spider_yzw_zhuanye';
    protected $resultSetType = 'collection';

    public function getZsList()
    {
        return $this->cache(true, 600)->where('zhuanye', 'LIKE', "%专业学位%")->group('zhuanye')->column('zhuanye');
    }

    public function getXsList()
    {
        return $this->cache(true, 600)->where('zhuanye', 'NOT LIKE', "%专业学位%")->group('zhuanye')->column('zhuanye');
    }

    public function getKsMethod()
    {
        return $this->cache(true, 600)->group('kaoshi_fangshi')->column('kaoshi_fangshi');
    }

    public function getXxMethod()
    {
        return $this->cache(true, 600)->group('xuexi_fangshi')->column('xuexi_fangshi');
    }

    public function getZsAttr($value, $data)
    {
        return strpos($data['zhuanye'], '专业学位') === false ? '学硕' : '专硕';
    }

    public function getCodeAttr($value, $data)
    {
        $res = preg_match('/^\(\d+\)/', $data['zhuanye'], $match);
        if ($res) {
            return trim(current($match), '()');
        } else {
            return '';
        }
    }

    public function getNameAttr($value, $data)
    {
        if (Str::contains($data['zhuanye'], '专业学位')) {
            return Str::substr($data['zhuanye'], 8);
        } else {
            return '(学术学位)' . Str::substr($data['zhuanye'], 8);
        }
    }
}
