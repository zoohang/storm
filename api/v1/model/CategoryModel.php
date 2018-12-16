<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: pl125 <xskjs888@163.com>
// +----------------------------------------------------------------------

namespace api\v1\model;

use think\Model;

class CategoryModel extends Model
{
    private static $instance = null;
    protected $ctype = 0;
    public static function instance($ctype)
    {
        if (is_null(self::$instance)) {
            self::$instance = new self([], $ctype);
        }
        return self::$instance;
    }

    //类型转换
    protected $type = [
        'more' => 'array',
    ];

    public function __construct($data = [], $ctype=0)
    {
        parent::__construct($data);
        $this->ctype = $ctype;
    }

    /**
     * 基础查询
     */
    protected function base($query)
    {
        $query->where('type', $this->ctype)
            ->where('status', 1);
    }


}
