<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

use api\v1\model\CourseModel;
use api\v1\model\DakaModel;
use api\v1\model\ExamModel;
use api\v1\model\FeedbackModel;
use api\v1\model\UserModel;
use cmf\controller\RestUserBaseController;
use think\Db;
use think\Validate;

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

    //完善登陆过程中的用户信息
    public function bindPhone() {
        //用户姓名 专业 手机号 验证码
        $param = $this->request->param();
        $rules = [
            'true_name' => 'require|length:2,20',//用户名称
            'speciality' => 'require',//专业
            'mobile'  => 'require|regex:1[34578]{1}[0-9]{9}',
            'code' => 'require'
        ];
        $message = [
            'mobile.require' => '手机号不能为空',
            'mobile.regex' => '手机号格式不对',
        ];
        $validate = new Validate($rules, $message);
        if (!$validate->check($param)) {
            $this->error($validate->getError());
        }
        //一个小时内有效
        $log = DB::name('sms')->where(['phone'=>$param['mobile'], 'create_time'=> ['EGT', NOW_TIME-993600]])->order(['id'=>'desc'])->find();
        if (!$log || $log['code'] != $param['code']) {
            $this->error('验证码错误');
        }
        $res = UserModel::instance()->allowField(true)->save($param, ['id'=>$this->userId]);
        if ($res !== false) {
            $this->success('ok');
        } else {
            $this->error('保存失败, 请重试');
        }
    }

    //判断用户是否有绑定过手机信息
    public function checkUserMobile() {
        $info = UserModel::instance()->where(['id' => $this->userId])->find()->toArray();
        $this->success('ok', ['mobile'=> $info['mobile'] ?: '']);
    }

    //添加收藏 打卡 type服务类型 1-刷题 2-打卡 3在线课堂 4-线下课堂
    public function addCollect() {
        //拼接好数据 调用公共收藏方法
        $id = $this->request->param('id', 0, 'intval,abs');
        $type = $this->request->param('type', 0, 'intval,abs');
        if(!$id) $this->error('手册id必填');
        if(!$type) $this->error('type必填');
        switch ($type) {
            case 1:
                $title = ExamModel::instance()->where(['id'=>$id])->value('title');
                $url = json_encode(['action' => 'v1/exam/detail', 'param' => ['id' => $id]]);
                $table = 'exam';
                break;
            case 2:
                $title = DakaModel::instance()->where(['id'=>$id])->value('post_title');
                $url = json_encode(['action' => 'v1/daka/detail', 'param' => ['id' => $id]]);
                $table = 'daka';
                break;
            case 3:
                $title = CourseModel::instance()->where(['cid'=>$id])->value('ctitle');
                $url = json_encode(['action' => 'v1/course/detail', 'param' => ['id' => $id]]);
                $table = 'course';
                break;
            case 4:
                //todo
                break;
        }
        $data = [
            'id' => $id,
            'title' => $title,
            'table' => $table,
            'url'   => $url,
            'type'  => $type
        ];
        $result = $this->validate($data, 'Favorite');
        if ($result !== true) {
            $this->error($result);
        }
        $this->collect($data);
    }

    public function deleteCollect() {
        $id = $this->request->param('id', 0, 'intval,abs');
        $type = $this->request->param('type', 0, 'intval,abs');
        if(!$id) $this->error('手册id必填');
        if(!$type) $this->error('type必填');
        $data = [
            'id' => $id,
            'type' => $type,
        ];
        $this->delCollect($data);
    }
}
