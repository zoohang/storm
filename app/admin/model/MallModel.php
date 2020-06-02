<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2018 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 老猫 <thinkcmf@126.com>
// +----------------------------------------------------------------------
namespace app\admin\model;

use think\Db;
use think\Model;

class MallModel extends Model
{

    protected $autoWriteTimestamp = true;
    protected $insert = ['category_name'];
    private static $instance = null;
    public $mallTypeList = [
        '请选择类型',
        '考研素材',
        '手绘素材',
        '竞赛图纸',
        '电子书',
        '设计素材',
        '作品集',
        '软件素材',
    ];
    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    protected function getMallTypeNameAttr($value, $data) {
        return $this->mallTypeList[$data['mall_type']];
    }

    /**
     * post_content 自动转化
     * @param $value
     * @return string
     */
    public function getPostContentAttr($value)
    {
        return cmf_replace_content_file_url(htmlspecialchars_decode($value));
    }

    /**
     * post_content 自动转化
     * @param $value
     * @return string
     */
    public function setPostContentAttr($value)
    {
        return htmlspecialchars(cmf_replace_content_file_url(htmlspecialchars_decode($value), true));
    }

    public function setCategoryNameAttr()
    {
        $category_id = request()->param('cid');
        $info = Db::name('Category')->where(['id'=>$category_id])->find();
        return $info['name'];
    }

    public function getMoreAttr($value)
    {
        return json_decode($value, true);
    }

    public function setMoreAttr($value)
    {
        return json_encode($value, JSON_UNESCAPED_SLASHES|JSON_UNESCAPED_UNICODE);
    }

    public function setPublishedTimeAttr($value)
    {
        return strtotime($value);
    }

}