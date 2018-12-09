<?php
namespace app\base\controller;

require_once EXTEND_PATH . "/aliyun-dysms-php-sdk-lite/SignatureHelper.php";

use Aliyun\DySDKLite\SignatureHelper;

class Alisms{

    public static $instance;
    protected $accessKeyId;
    protected $accessKeySecret;

    public static function instance($option=[]) {
        if (empty(self::$instance)) {
            self::$instance = new self($option);
        }
        return self::$instance;
    }

    public function __construct($option=[]) {

        $config = \think\Config::get('aliyun_sms');
        $config = $option + $config;
        $this->accessKeyId = $config['accessKeyId'];
        $this->accessKeySecret = $config['accessKeySecret'];
    }

    /**
     * @param $type
     * @return mixed
     *
     * 身份验证验证码 SMS_126615372 验证码${code}，您正在进行身份验证，打死不要告诉别人哦！
     * 登录确认验证码 SMS_126615371 验证码${code}，您正在登录，若非本人操作，请勿泄露。
     * 登录异常验证码 SMS_126615370 验证码${code}，您正尝试异地登录，若非本人操作，请勿泄露。
     * 用户注册验证码 SMS_126615369 验证码${code}，您正在注册成为新用户，感谢您的支持！
     * 修改密码验证码 SMS_126615368 验证码${code}，您正在尝试修改登录密码，请妥善保管账户信息。
     * 信息变更验证码 SMS_126615367 验证码${code}，您正在尝试变更重要信息，请妥善保管账户信息。
     * 报名成功通知   SMS_126358359 手机号${tel}的学员，${stuname}于${date}报名成功，请知悉
     * 推广          SMS_133261560 十周年活动等你参加！
     * 儿童节推广     SMS_136395812 六一儿童节风暴特惠猜拳挑战各校区钜惠活动！
     */
    protected function autoChooseTemplate($type) {
        $list =  [
            'login' => 'SMS_126615371',
            'login_error' => 'SMS_126615370',
            'register' => 'SMS_126615369',
            'update_info' => 'SMS_126615367',
            'update_pwd' => 'SMS_126615368',
            'identity_verification' => 'SMS_126615372',
            'reg_ok_notice' => 'SMS_126358359',
            '10year' => 'SMS_133261560',
            '61day' => 'SMS_136395812',
        ];
        return $list[$type];
    }

    /**
     * 发送短信
     * @param $tel 手机号
     * @param $type 信息类型
     * @param array $data 模板中的变量
     * @return true or errorMessage
     * ps $res = Alisms::instance()->sendSms($info['PhoneNumbers'], 'login', ['code'=>1900]);
     */
    public function sendSms($tel, $type, $data=[]) {

        $params = array ();

        // *** 需用户填写部分 ***
        // 必填：是否启用https todo 成功上线并接入https之后可以打开
        $security = false;

        $accessKeyId = $this->accessKeyId;
        $accessKeySecret = $this->accessKeySecret;

        $params["PhoneNumbers"] = (string)$tel;
        $SignName = \think\Config::get('aliyun_sms.SignName');
        $params["SignName"] = !empty($SignName) ? $SignName : "风暴教育";

        $params["TemplateCode"] = $this->autoChooseTemplate($type);

        // 可选: 设置模板参数, 假如模板中存在变量需要替换则为必填项
        if (!empty($data) && is_array($data)){
            $params['TemplateParam'] = $data;
        }

        // 可选: 设置发送短信流水号
        //$params['OutId'] = "12345";

        // 可选: 上行短信扩展码, 扩展码字段控制在7位或以下，无特殊需求用户请忽略此字段
        //$params['SmsUpExtendCode'] = "1234567";

        // *** 需用户填写部分结束, 以下代码若无必要无需更改 ***
        if(!empty($params["TemplateParam"]) && is_array($params["TemplateParam"])) {
            $params["TemplateParam"] = json_encode($params["TemplateParam"], JSON_UNESCAPED_UNICODE);
        }

        // 初始化SignatureHelper实例用于设置参数，签名以及发送请求
        $helper = new SignatureHelper();
        // 此处可能会抛出异常，注意catch
        $content = $helper->request(
            $accessKeyId,
            $accessKeySecret,
            "dysmsapi.aliyuncs.com",
            array_merge($params, array(
                "RegionId" => "cn-hangzhou",
                "Action" => "SendSms",
                "Version" => "2017-05-25",
            )),
            $security
        );
        return $content->Code === 'OK' ? true : $content->Message;
    }

}