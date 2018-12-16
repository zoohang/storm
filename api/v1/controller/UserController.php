<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

use api\v1\model\FeedbackModel;
use api\v1\model\UserModel;
use cmf\controller\RestUserBaseController;
use think\Db;

class UserController extends RestUserBaseController
{
    // 获取用户信息
    public function getUserInfo()
    {
        $this->success('ok', $this->user);
    }

    /**
     * 用户基本信息获取及修改
     * 姓名 手机 专业 性别 学校 年级 微信号 邮箱
     * 是否成为大使[是,否] 感兴趣[多选] 获取渠道[多选]
     * @param 请求为GET 获取信息
     * @param [string] $[field] [要获取的一个或多个字段名] 可选
     * @return 带参数,返回某个或多个字段信息。不带参数，返回所有信息
     * @param 请求为POST 修改信息
     */
    public function userInfo($field = '')
    {
        //判断请求为GET，获取信息
        if ($this->request->isGet()) {
            $userId   = $this->getUserId();
            $fieldStr = 'user_nickname,mobile,user_email,sex,birthday,coin,user_status,school,speciality,grade,more';
            if (empty($field)) {
                $userData = UserModel::instance()->field($fieldStr)->find($userId);
            } else {
                $fieldArr     = explode(',', $fieldStr);
                $postFieldArr = explode(',', $field);
                $mixedField   = array_intersect($fieldArr, $postFieldArr);
                if (empty($mixedField)) {
                    $this->error('您查询的信息不存在！');
                }
                if (count($mixedField) > 1) {
                    $fieldStr = implode(',', $mixedField);
                    $userData = UserModel::instance()->field($fieldStr)->find($userId);;
                } else {
                    $userData = Db::name("user")->where('id', $userId)->value($mixedField);
                }
            }
            $this->success('获取成功！', $userData);
        }
        //判断请求为POST,修改信息
        if ($this->request->isPost()) {
            $userId   = $this->getUserId();
            $fieldStr = 'user_nickname,user_email,sex,school,speciality,grade,more';
            $data     = $this->request->post();
            if (empty($data)) {
                $this->error('修改失败，提交表单为空！');
            }
            $more = [];
            //微信号
            if (isset($data['wx_no'])) {
                $more['wx_no'] = $data['wx_no'];
            }
            //是否成为大使
            if (isset($data['dashi'])) {
                $more['dashi'] = $data['dashi'];
            }
            //感兴趣的学科
            if (isset($data['enjoy_course'])) {
                $more['enjoy_course'] = $data['enjoy_course'];
            }
            //了解来源
            if (isset($data['source'])) {
                $more['source'] = $data['source'];
            }
            if ($more) $data['more'] = json_encode($more, JSON_UNESCAPED_UNICODE);
            $upData = Db::name("user")->where('id', $userId)->field($fieldStr)->strict(false)->update($data);
            if ($upData !== false) {
                $this->success('修改成功！');
            } else {
                $this->error('修改失败！');
            }
        }
    }

    public function feedback()
    {
        $userId   = $this->getUserId();
        $data     = $this->request->post();
        $data = array_merge(['user_id'=>$userId], $data);

        if (FeedbackModel::instance()->isUpdate(false)->save($data) !== false) {
            $this->success('提交成功！');
        } else {
            $this->error('提交失败！');
        }
    }
}
