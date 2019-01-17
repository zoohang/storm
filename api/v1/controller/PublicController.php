<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

use app\base\controller\Alisms;
use think\Config;
use think\Db;
use cmf\controller\RestBaseController;
use wxapp\aes\WXBizDataCrypt;
use think\Validate;

class PublicController extends RestBaseController
{
    // 微信小程序用户登录 TODO 增加最后登录信息记录,如 ip
    public function login()
    {
        $validate = new Validate([
            'code'           => 'require',
            'encrypted_data' => 'require',
            'iv'             => 'require',
            #'raw_data'       => 'require',
            #'signature'      => 'require',
        ]);

        $validate->message([
            'code.require'           => '缺少参数code!',
            'encrypted_data.require' => '缺少参数encrypted_data!',
            'iv.require'             => '缺少参数iv!',
            #'raw_data.require'       => '缺少参数raw_data!',
            #'signature.require'      => '缺少参数signature!',
        ]);

        $data = $this->request->param();
        if (!$validate->check($data)) {
            $this->error($validate->getError());
        }

        $code          = $data['code'];
        $wxappSettings = cmf_get_option('wxapp_settings');

        $appId = $this->request->header('Wxapp-AppId');
        if (empty($appId)) {
            if (empty($wxappSettings['default'])) {
                $this->error('没有设置默认小程序！');
            } else {
                $defaultWxapp = $wxappSettings['default'];
                $appId        = $defaultWxapp['app_id'];
                $appSecret    = $defaultWxapp['app_secret'];
            }
        } else {
            if (empty($wxappSettings['wxapps'][$appId])) {
                $this->error('小程序设置不存在！');
            } else {
                $appId     = $wxappSettings['wxapps'][$appId]['app_id'];
                $appSecret = $wxappSettings['wxapps'][$appId]['app_secret'];
            }
        }


        $response = cmf_curl_get("https://api.weixin.qq.com/sns/jscode2session?appid=$appId&secret=$appSecret&js_code=$code&grant_type=authorization_code");

        $response = json_decode($response, true);
        if (!empty($response['errcode'])) {
            $this->error('操作失败!');
        }

        $openid     = $response['openid'];
        $sessionKey = $response['session_key'];

        $pc      = new WXBizDataCrypt($appId, $sessionKey);
        $errCode = $pc->decryptData($data['encrypted_data'], $data['iv'], $wxUserData);

        if ($errCode != 0) {
            $this->error('操作失败!');
        }

        $findThirdPartyUser = Db::name("third_party_user")
            ->where('openid', $openid)
            ->where('app_id', $appId)
            ->find();

        $currentTime = time();
        $ip          = $this->request->ip(0, true);

        $wxUserData['sessionKey'] = $sessionKey;
        unset($wxUserData['watermark']);

        if ($findThirdPartyUser) {
            $userId = $findThirdPartyUser['user_id'];
            $token  = cmf_generate_user_token($findThirdPartyUser['user_id'], 'wxapp');

            $userData = [
                'last_login_ip'   => $ip,
                'last_login_time' => $currentTime,
                'login_times'     => Db::raw('login_times+1'),
                'more'            => json_encode($wxUserData)
            ];

            if (isset($wxUserData['unionId'])) {
                $userData['union_id'] = $wxUserData['unionId'];
            }

            Db::name("third_party_user")
                ->where('openid', $openid)
                ->where('app_id', $appId)
                ->update($userData);

        } else {

            //TODO 使用事务做用户注册
            $userId = Db::name("user")->insertGetId([
                'create_time'     => $currentTime,
                'user_status'     => 1,
                'user_type'       => 2,
                'sex'             => $wxUserData['gender'],
                'user_nickname'   => $wxUserData['nickName'],
                'avatar'          => $wxUserData['avatarUrl'],
                'last_login_ip'   => $ip,
                'last_login_time' => $currentTime,
            ]);

            Db::name("third_party_user")->insert([
                'openid'          => $openid,
                'user_id'         => $userId,
                'third_party'     => 'wxapp',
                'app_id'          => $appId,
                'last_login_ip'   => $ip,
                'union_id'        => isset($wxUserData['unionId']) ? $wxUserData['unionId'] : '',
                'last_login_time' => $currentTime,
                'create_time'     => $currentTime,
                'login_times'     => 1,
                'status'          => 1,
                'more'            => json_encode($wxUserData)
            ]);

            $token = cmf_generate_user_token($userId, 'wxapp');

        }

        $user = Db::name('user')->where('id', $userId)->find();

        $this->success("登录成功!", ['token' => $token, 'user' => $user]);


    }

    //发送注册验证码
    public function sendSms() {
        $phone = $this->request->param('phone');
        $rules = [
            'phone'  => 'require|regex:1[34578]{1}[0-9]{9}',
        ];
        $message = [
            'phone.require' => '手机号不能为空',
            'phone.regex' => '手机号格式不对',
        ];
        $validate = new Validate($rules, $message);
        if (!$validate->check($this->request->param())) {
            $this->error($validate->getError());
        }
        $client_ip = $this->request->ip();
        $today = strtotime('today');
        DB::name('sms')->where(['create_time'=>['EGT', $today], 'phone'=>$phone])->whereOr(['create_time'=>['EGT', $today], 'ip'=>$client_ip])->count();

        //检查数据库 获取请求的ip是否超出规范
        //短信防刷简单验证
        $sms_config = Config::get('aliyun_sms');
        if (!$sms_config) $this->error('请先配置短信选项');
        $except = [];
        if ($sms_config['exception']) $except = explode(',', $sms_config['exception']);
        if (!in_array($phone, $except)) {
            if (DB::name('sms')->where(['phone'=>$phone])->whereOr(['ip'=>$client_ip])->count() >= $sms_config['dayLimit']) {
                $this->error("已经超出每天单个手机号发送次数限制{$sms_config['dayLimit']}条");
            }
        }
        //随机生成4为数字
        $code = mt_rand(1000, 9999);
        $res = Alisms::instance()->sendSms($phone, 'register', ['code'=>$code]);
        if ($res === true) {
            //写数据库进行记录
            DB::name('sms')->insert([
                'phone' => $phone,
                'ip' => $client_ip,
                'code' => $code,
                'type' => 1,
                'create_time' => NOW_TIME
            ]);
            $this->success('ok');
        } else {
            $this->error($res);
        }
    }

    //重新获取token
    public function generateToken() {
        $userId = $this->request->param('user_id', 0, 'intval,abs');
        if (!$userId) $this->error('用户id不合法!');
        $user = Db::name('user')->where('id', $userId)->find();
        if (!$user) $this->error('该用户不存在!');
        $token = cmf_generate_user_token($userId, 'wxapp');
        $this->success("ok", ['token' => $token, 'user' => $user]);
    }
}
