<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2018 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +---------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace cmf\controller;

use think\exception\HttpResponseException;
use think\exception\ValidateException;
use think\Request;
use think\Config;
use think\Response;
use think\Loader;
use think\Db;

class RestBaseController
{
    //token
    protected $token = '';

    //设备类型
    protected $deviceType = '';

    protected $apiVersion;

    //用户 id
    protected $userId = 0;

    //用户
    protected $user;

    //用户类型
    protected $userType;

    protected $allowedDeviceTypes = ['mobile', 'android', 'iphone', 'ipad', 'web', 'pc', 'mac', 'wxapp'];

    /**
     * @var \think\Request Request实例
     */
    protected $request;
    // 验证失败是否抛出异常
    protected $failException = false;
    // 是否批量验证
    protected $batchValidate = false;

    /**
     * 前置操作方法列表
     * @var array $beforeActionList
     * @access protected
     */
    protected $beforeActionList = [];

    /**
     * 架构函数
     * @param Request $request Request对象
     * @access public
     */
    public function __construct(Request $request = null)
    {
        if (is_null($request)) {
            $request = Request::instance();
        }
        Config::load(CMF_ROOT.'data/conf/config.php');
        Request::instance()->root(cmf_get_root() . '/');

        $this->request = $request;

        $this->apiVersion = $this->request->header('Api-Version');

        // 用户验证初始化
        $this->_initUser();

        // 控制器初始化
        $this->_initialize();

        // 前置操作方法
        if ($this->beforeActionList) {
            foreach ($this->beforeActionList as $method => $options) {
                is_numeric($method) ?
                    $this->beforeAction($options) :
                    $this->beforeAction($method, $options);
            }
        }
    }

    // 初始化
    protected function _initialize()
    {
    }

    private function _initUser()
    {
        $token      = $this->request->header('Token');
        $deviceType = $this->request->header('Device-Type');
        $debug = $this->request->param('debug');
        if (isset($debug)) {
            $token = '58402d44e82565e3aa3d49605e5bb9c158402d44e82565e3aa3d49605e5bb9c1';
            $deviceType = $this->deviceType = 'wxapp';
        } else {
            if (empty($deviceType)) {
                $this->error('应用来源必填');
                return;
            }

            if (!in_array($deviceType, $this->allowedDeviceTypes)) {
                $this->error('应用来源不在指定的范围中');
                return;
            }

            $this->deviceType = $deviceType;

            if (empty($token)) {
                return;
            }
        }
        $this->token = $token;

        $user = Db::name('user_token')
            ->alias('a')
            ->field('a.expire_time,b.*')
            ->where(['token' => $token, 'device_type' => $deviceType])
            ->join('__USER__ b', 'a.user_id = b.id')
            ->find();

        if (!empty($user)) {
            unset($user['user_pass']);
            //过期返回 10000 通知client重新拉取token
            if ($user['expire_time'] < NOW_TIME) {
                $this->error(['code'=>10000, 'msg'=>'token验证失败, 请重新拉取授权']);
            }
            //if ($user['more']) $user['more'] = json_decode($user['more'], true);
            $this->user     = $user;
            $this->userId   = $user['id'];
            $this->userType = $user['user_type'];
            $this->request->post(['user_id'=>$this->userId]);
            $this->request->post(['user'=>serialize($user)]);
        } else {
            //todo token不存在 验证失败
            $this->error('token验证失败, 请重新拉取授权');
        }

    }

    /**
     * 前置操作
     * @access protected
     * @param string $method 前置操作方法名
     * @param array $options 调用参数 ['only'=>[...]] 或者['except'=>[...]]
     */
    protected function beforeAction($method, $options = [])
    {
        if (isset($options['only'])) {
            if (is_string($options['only'])) {
                $options['only'] = explode(',', $options['only']);
            }
            if (!in_array($this->request->action(), $options['only'])) {
                return;
            }
        } elseif (isset($options['except'])) {
            if (is_string($options['except'])) {
                $options['except'] = explode(',', $options['except']);
            }
            if (in_array($this->request->action(), $options['except'])) {
                return;
            }
        }

        call_user_func([$this, $method]);
    }


    /**
     * 设置验证失败后是否抛出异常
     * @access protected
     * @param bool $fail 是否抛出异常
     * @return $this
     */
    protected function validateFailException($fail = true)
    {
        $this->failException = $fail;
        return $this;
    }

    /**
     * 验证数据
     * @access protected
     * @param array $data 数据
     * @param string|array $validate 验证器名或者验证规则数组
     * @param array $message 提示信息
     * @param bool $batch 是否批量验证
     * @param mixed $callback 回调方法（闭包）
     * @return array|string|true
     * @throws ValidateException
     */
    protected function validate($data, $validate, $message = [], $batch = false, $callback = null)
    {
        if (is_array($validate)) {
            $v = Loader::validate();
            $v->rule($validate);
        } else {
            if (strpos($validate, '.')) {
                // 支持场景
                list($validate, $scene) = explode('.', $validate);
            }
            $v = Loader::validate($validate);
            if (!empty($scene)) {
                $v->scene($scene);
            }
        }
        // 是否批量验证
        if ($batch || $this->batchValidate) {
            $v->batch(true);
        }

        if (is_array($message)) {
            $v->message($message);
        }

        if ($callback && is_callable($callback)) {
            call_user_func_array($callback, [$v, &$data]);
        }

        if (!$v->check($data)) {
            if ($this->failException) {
                throw new ValidateException($v->getError());
            } else {
                return $v->getError();
            }
        } else {
            return true;
        }
    }

    /**
     * 操作成功跳转的快捷方法
     * @access protected
     * @param mixed $msg 提示信息
     * @param mixed $data 返回的数据
     * @param array $header 发送的Header信息
     * @return void
     */
    protected function success($msg = '', $data = '', array $header = [])
    {
        $code   = 200;
        $result = [
            'code' => $code,
            'msg'  => $msg,
            'data' => $data,
        ];

        $type                                   = $this->getResponseType();
        $header['Access-Control-Allow-Origin']  = '*';
        $header['Access-Control-Allow-Headers'] = 'X-Requested-With,Content-Type,Device-Type,Token';
        $header['Access-Control-Allow-Methods'] = 'GET,POST,PATCH,PUT,DELETE,OPTIONS';
        $response                               = Response::create($result, $type)->header($header);
        throw new HttpResponseException($response);
    }

    /**
     * 操作错误跳转的快捷方法
     * @access protected
     * @param mixed $msg 提示信息,若要指定错误码,可以传数组,格式为['code'=>您的错误码,'msg'=>'您的错误消息']
     * @param mixed $data 返回的数据
     * @param array $header 发送的Header信息
     * @return void
     */
    protected function error($msg = '', $data = '', array $header = [])
    {
        $code = 400;
        if (is_array($msg)) {
            $code = $msg['code'];
            $msg  = $msg['msg'];
        }
        $result = [
            'code' => $code,
            'msg'  => $msg,
            'data' => $data,
        ];

        $type                                   = $this->getResponseType();
        $header['Access-Control-Allow-Origin']  = '*';
        $header['Access-Control-Allow-Headers'] = 'X-Requested-With,Content-Type,Device-Type,Token';
        $header['Access-Control-Allow-Methods'] = 'GET,POST,PATCH,PUT,DELETE,OPTIONS';
        $response                               = Response::create($result, $type)->header($header);
        throw new HttpResponseException($response);
    }

    /**
     * 获取当前的response 输出类型
     * @access protected
     * @return string
     */
    protected function getResponseType()
    {
        return 'json';
    }

    /**
     * 获取当前登录用户的id
     * @return int
     */
    public function getUserId()
    {
        if (empty($this->userId)) {
            $this->error(['code' => 401, 'msg' => '用户未登录']);
        }
        return $this->userId;


    }


}