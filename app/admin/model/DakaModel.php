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

class DakaModel extends Model
{

    protected $autoWriteTimestamp = true;
    protected $insert = ['category_name'];
    private static $instance = null;

    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
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
        $category_id = request()->param('post.category_id');
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

    public function setEndTimeAttr($value)
    {
        return strtotime($value);
    }

    public function adminAddArticle($data, $category_id)
    {
        $data['user_id'] = cmf_get_current_admin_id();

        if (isset($data['more']['thumbnail']) && !empty($data['more']['thumbnail'])) {
            $data['more']['thumbnail'] = cmf_asset_relative_url($data['more']['thumbnail']);
            $data['thumbnail']         = $data['more']['thumbnail'];
        }

        /*if (!empty($data['more']['audio'])) {
            $data['more']['audio'] = cmf_asset_relative_url($data['more']['audio']);
        }

        if (!empty($data['more']['video'])) {
            $data['more']['video'] = cmf_asset_relative_url($data['more']['video']);
        }*/
        if (isset($data['more']) && $data['more']) $data['more'] = json_encode($data['more'], JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES);
        if ($category_id) $data['category_name'] = $this->setCategoryNameAttr();
        $this->allowField(true)->data($data, true)->isUpdate(false)->save();
        CategoryModel::instance()->where(['id'=>$category_id])->setInc('count', 1);
        return $this;

    }

    public function adminEditArticle($data, $category_id)
    {

        unset($data['user_id']);

        if (!empty($data['more']['thumbnail'])) {
            $data['more']['thumbnail'] = cmf_asset_relative_url($data['more']['thumbnail']);
            $data['thumbnail']         = $data['more']['thumbnail'];
        }

        if (!empty($data['more']['audio'])) {
            $data['more']['audio'] = cmf_asset_relative_url($data['more']['audio']);
        }

        if (!empty($data['more']['video'])) {
            $data['more']['video'] = cmf_asset_relative_url($data['more']['video']);
        }
        if ($category_id) $data['category_name'] = $this->setCategoryNameAttr();
        $this->allowField(true)->isUpdate(true)->data($data, true)->save();

        return $this;

    }

    public function getTeacherHomeWrokList($where=[]) {
        $field = ['a.*', 'b.end_time','b.post_title title2','c.post_title title', 'c.category_name', 'c.category_id'];
        return Db::name('daka_homework a')
            ->join('__DAKA__ b', 'a.daka_id=b.id')
            ->join('__DAKA__ c', 'a.daka_parent_id=c.id')
            ->field($field)
            ->where($where)
            ->paginate();
    }

    public function getDakaList($where) {
        return Db::name('daka_homework a')
            ->join('__DAKA__ b', 'a.daka_parent_id=b.id')
            ->field(['b.id', 'b.post_title', 'b.category_name'])
            ->where($where)
            ->group('b.id')
            ->select()
            ->toArray();
    }

    public function getHomeWorkInfo($where) {
        return Db::name('daka_homework')->where($where)->find();
    }

    public function getDakaDetail($where) {
        return $this->alias('a')
            ->join('__DAKA__ b', 'a.id=b.parent_id')->field('a.post_title daka_title,b.*')
            ->where($where)->find()->toArray();
    }
}