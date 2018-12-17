<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

use api\v1\model\CategoryModel;
use api\v1\model\ExamItemModel;
use api\v1\model\ExamModel;
use cmf\controller\RestUserBaseController;

class ExamController extends RestUserBaseController
{
    protected $ctype = 1;
    // 首页信息
    public function index()
    {
        $field = ['id', 'parent_id', 'name'];
        $cate = CategoryModel::instance($this->ctype)->field($field)->select()->toArray();

        //参考书籍 todo

        //获取题目

    }

    public function getCategoryExam() {
        $id = $this->request->param('id', 0, 'intval,abs');
        $limit = $this->request->param('limit', 10, 'intval,abs');
        $where = [];
        if ($id) $where['cid'] = $id;
        $list = ExamModel::instance()->where($where)->paginate($limit)->toArray();
        $this->success('ok', $list);
    }

    /**
     * 获取试卷的题目列表
     */
    public function getExamItemList() {
        $id = $this->request->param('id', 0, 'intval,abs');
        if (!$id) $this->error('试卷的id必填');
        $exam_info = ExamModel::instance()->where(['id'=>$id])->find()->toArray();
        $data = ExamItemModel::instance()->where(['exam_id'=>$id])->order(['list_order'=>'asc'])->select()->toArray();
        $result = [];
        $result['info'] = $exam_info;
        $result['count'] = 0;
        $result['chooseQusList'] = $result['blankQusList'] = $result['discusseQusList'] = [];
        if ($data) {
            $result['count'] = count($data);
            foreach ($data as $item) {
                if ($item['type'] == 1) {
                    $result['chooseQusList'][] = $item;
                } elseif($item['type'] == 2) {
                    $result['blankQusList'][] = $item;
                } elseif($item['type'] == 3) {
                    $result['discusseQusList'][] = $item;
                }
            }
        }
        $this->success('ok', $result);
    }


    /**
     * 加入错误列表
     */
    public function addWrongList() {

    }
}
