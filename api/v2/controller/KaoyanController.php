<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v2\controller;

use api\v2\model\YzwCategoryModel;
use api\v2\model\YzwSchoolModel;
use api\v2\model\YzwZhuanyeModel;
use cmf\controller\RestBaseController;
use think\Exception;
use think\Request;

class KaoyanController extends RestBaseController
{
    protected $expire = 600;
    protected $listRows = 10;

    public function getFilterOption()
    {
        $xs = YzwZhuanyeModel::instance()->getXsList(); // 学硕
        $zs = YzwZhuanyeModel::instance()->getZsList(); // 专硕
        $kaoshi = YzwZhuanyeModel::instance()->getKsMethod(); // 考试方式
        $xuexi = YzwZhuanyeModel::instance()->getXxMethod(); // 学习方式
        $provinces = YzwSchoolModel::instance()->getProvince(); // 学习方式
        // 首页的距离考研还有多少天 每天的12月24日
        $today = strtotime('today');
        $y = date('Y');
        $y1 = date('Y', strtotime('+1 year'));
        $kaoyandays = [strtotime("{$y}-12-24"), strtotime("{$y}-12-25")];
        if (in_array($today, $kaoyandays)) {
            $str = "考研必过，一研为定！";
        } elseif($today<$kaoyandays[0]) {
            $str = sprintf('距离%s考研初试仅剩 %s天', $y, ($kaoyandays[0]-$today)/86400); // 距离2024考研初试仅剩 218天
        } else {
            $str = sprintf('距离%s考研初试仅剩 %s天', $y1, (strtotime("{$y1}-12-24")-$today)/86400); // 距离2024考研初试仅剩 218天
        }
        $this->success('ok', compact('str','xs', 'zs', 'kaoshi', 'xuexi', 'provinces'));
    }
    // 专业列表
    public function zyList(Request $request)
    {
        $list = YzwZhuanyeModel::instance()
            ->scope(function($query) use ($request) {
                $params = $request->param();
                $query->where('year', '=', date('Y'));
                if (!empty($params['kw'])) $query->where('zhuanye', 'LIKE', "%{$params['kw']}%");
                if (!empty($params['zhuanye'])) $query->where('zhuanye', '=', $params['zhuanye']);
            })
            ->field('zhuanye')
            ->group('zhuanye')
            ->select();
        $list->append(['zs']);
        $this->success('ok', $list);
    }

    // 根据专业找院校
    public function getSchoolsByZy(Request $request)
    {
        $params = $request->param();
        if (empty($params['zhuanye'])) $this->error('专业必填');
        // 专业信息
        $info = YzwZhuanyeModel::instance()
            ->field('zhuanye')
            ->limit(1)
            ->where('year', '=', date('Y'))
            ->where(['zhuanye'=>$params['zhuanye']])
            ->cache(true, $this->expire)
            ->find();
        $list = [];
        if ($info) {
            $info->append(['code', 'name']);
            // 院校列表
            $list = YzwZhuanyeModel::instance()->alias('a')
                ->join('spider_yzw_schools b', 'a.school_id=b.school_id')
                ->field('a.id,a.school_id,a.school_name,a.zhuanye,a.kaoshi_fangshi,a.xuexi_fangshi,b.province_id,b.province_name')
                ->group('a.school_id')
                ->select(function($query) use ($request) {
                    $params = $request->param();
                    $query->where('a.year', '=', date('Y'));
                    if (!empty($params['province_id'])) $query->where('b.province_id', '=', $params['province_id']);
                    if (!empty($params['kaoshi_fangshi'])) $query->where('a.kaoshi_fangshi', '=', $params['kaoshi_fangshi']);
                    if (!empty($params['xuexi_fangshi'])) $query->where('a.xuexi_fangshi', '=', $params['xuexi_fangshi']);
                });
        }
        $this->success('ok', compact('info', 'list'));
    }

    // 院校列表
    public function schoolList(Request $request)
    {
        $list = YzwSchoolModel::instance()
            ->scope(function($query) use ($request) {
                $params = $request->param();
                if (!empty($params['kw'])) $query->where('school_name', 'LIKE', "%{$params['kw']}%");
                if (!empty($params['province_id'])) $query->where('province_id', '=', $params['province_id']);
                if (isset($params['is_yan']) && ($params['is_yan'] ==='0' || $params['is_yan'] ==='1')) $query->where('is_yan', '=', $params['is_yan']);
                if (isset($params['is_zi']) && ($params['is_zi'] ==='0' || $params['is_zi'] ==='1')) $query->where('is_zi', '=', $params['is_zi']);
                if (isset($params['is_bo']) && ($params['is_bo'] ==='0' || $params['is_bo'] ==='1')) $query->where('is_bo', '=', $params['is_bo']);
            })
            ->field('province_name_origin,url', true)
            ->cache(true, $this->expire)
            ->select();
        $this->success('ok', $list);
    }

    // 院校专业列表
    public function schoolZyList(Request $request)
    {
        $id = $request->param('id');
        if (!$id) $this->error('id不能为空');
        $info = YzwSchoolModel::instance()->field('url',true)->where('id', '=', $id)->find();
        $zhuanye = $request->param('zhuanye', '', 'trim');
        $where = ['school_id' => $info['school_id'], 'year' => date('Y')];
        if ($zhuanye) {
            $where['zhuanye'] =  $zhuanye;
        }
        $list = YzwZhuanyeModel::instance()
            ->where($where)
            ->field(['id','zhuanye','yanjiu_fangxiang','yuanxisuo'])
            ->order('yanjiu_fangxiang', 'asc')
            //->cache(true, $this->expire)
            ->group('yanjiu_fangxiang')
            ->select()
            ->toArray();
        //dd(YzwZhuanyeModel::instance()->getLastSql(), $list);
        $new = [];
        foreach ($list as $item) {
            $new[$item['zhuanye']]['id'] = $item['id'];
            $new[$item['zhuanye']]['name'] = $item['zhuanye'];
            $new[$item['zhuanye']]['child'][] = [
                'id' => $item['id'],
                'yanjiu_fangxiang' => $item['yanjiu_fangxiang'],
                'yuanxisuo' => $item['yuanxisuo'],
            ];
        }
        $list = array_values($new);
        $this->success('ok', compact('info', 'list'));
    }

    // 院校和专业的详情页
    public function detail(Request $request)
    {
        // 学校信息
        // 专业信息
        $id = $request->param('id'); // id 和 school_id+zhuanye 其中的一组参数必填
        $school_id = $request->param('school_id');
        $zhuanye = $request->param('zhuanye');
        $where = [];
        if ($id) {
            $where['id'] = $id;
        } elseif ($school_id && $zhuanye) {
            $where['school_id'] = $school_id;
            $where['zhuanye'] = $zhuanye;
        } else {
            $this->error('参数错误');
        }
        $zhuanye = YzwZhuanyeModel::instance()->where($where)->select()->toArray();
        $school = YzwSchoolModel::instance()->where(['school_id' => current($zhuanye)['school_id']])->find();
        // 新增该专业的所属父级类目
        $cate = YzwCategoryModel::instance()->getUpCategoryByCode(current($zhuanye)['zhuanye']);
        $cate['name3'] = $cate['name1'] == '专业学位' ? '专硕' : '学硕';
        $this->success('ok', compact('school', 'zhuanye', 'cate'));
    }
}
