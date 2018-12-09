<?php
/**
 * 百度vod视频管理
 */
namespace app\base\model;
use string\String;
require_once EXTEND_PATH.'aliyun-php-sdk/aliyun-php-sdk-core/Config.php';
require_once EXTEND_PATH.'aliyun-php-sdk/aliyun-oss-php-sdk-2.2.4/autoload.php';
use vod\Request\V20170321 as vod;
use OSS\OssClient;
use OSS\Core\OssException;

class VodModel {
    protected $accessKeyId;
    protected $accessKeySecret;
    protected $client;
    protected $debug = false;
    private static $instance = null;
    public function __construct() {
        header("Content-type:text/html;charset=utf-8");
        header("Access-Control-Allow-Methods:GET,POST");
        $this->accessKeyId = \think\config::get('ALIYUN_VOD.ACCESS_KEY_ID');
        $this->accessKeySecret = \think\config::get('ALIYUN_VOD.ACCESS_KEY_SECRET');
        $this->client = $this->init_vod_client($this->accessKeyId, $this->accessKeySecret);
    }

    private function __clone()
    {

    }

    public static function getInstance(){
        if (!self::$instance instanceof self) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    //初始化客户端
    private function init_vod_client ($accessKeyId, $accessKeySecret) {
        $regionId = 'cn-shanghai';  // 点播服务所在的Region，国内请填cn-shanghai，不要填写别的区域
        $profile = \DefaultProfile::getProfile($regionId, $accessKeyId, $accessKeySecret);
        return new \DefaultAcsClient($profile);
    }

    //获取播放地址
    public function get_play_info ($videoId) {
        $request = new vod\GetPlayInfoRequest();
        $request->setVideoId($videoId);
        $request->setAcceptFormat('JSON');
        return $this->client->getAcsResponse($request);
    }

    //获取播放凭证
    public function get_play_auth ($videoId) {
        try {
            $request = new vod\GetVideoPlayAuthRequest();
            $request->setVideoId($videoId);
            // 播放凭证过期时间，默认为100秒，取值范围100~3600；
            // 注意：播放凭证用来传给播放器自动换取播放地址，凭证过期时间不是播放地址的过期时间
            $request->setAuthInfoTimeout(600);
            $request->setAcceptFormat('JSON');
            return $this->client->getAcsResponse($request);
        } catch (\Exception $e) {
            if ($this->debug) {
                printf("Failed, ErrorMessage: %s", $e->getMessage());
            }
            return false;
        }
    }

    /**
     * 获取视频上传地址和凭证
     * @param array $vinfo
     *      字段 | 类型 | 是否必填 | 描述
     *      $vinfo['title']  String  是 视频标题。长度不超过128个字节。UTF8编码。
     *      $vinfo['file_name']  String  是 视频源文件名。必须带扩展名，且扩展名不区分大小写。支持的扩展名参见 上传概述 的限制部分。
     *      $vinfo['description']  String  否 视频描述。长度不超1024个字节。UTF8编码。
     *      $vinfo['img']  String  否 自定义视频封面URL地址。
     *      $vinfo['tags']  String  否 视频标签。单个标签不超过32字节，最多不超过16个标签。多个用逗号分隔。UTF8编码。
     * @return object
     *      RequestId	String	请求ID。
     *      VideoId	String	视频ID。
     *      UploadAddress	String	上传地址。
     *      UploadAuth	String	上传凭证。
     */
    public function create_upload_video(array $vinfo) {
        $res = $this->_upload_flie_filter($vinfo);
        if (!$res['status']) return (['status'=>false, 'message'=> $res['message'], 'data'=> '']);
        $request = new vod\CreateUploadVideoRequest();
        $request->setTitle($vinfo['title']);        // 视频标题(必填参数)
        $request->setFileName($vinfo['file_name']); // 视频源文件名称，必须包含扩展名(必填参数)
        if (isset($vinfo['description'])) {
            $request->setDescription($vinfo['description']);  // 视频源文件描述(可选)
        }
        if (isset($vinfo['img'])) {
            $request->setCoverURL($vinfo['img']); // 自定义视频封面(可选)
        }
        if (isset($vinfo['tags']) && is_string($vinfo['tags'])) {
            $request->setTags($vinfo['tags']); // 视频标签，多个用逗号分隔(可选)
        }
        $request->setAcceptFormat('JSON');
        return $this->client->getAcsResponse($request);
    }

    /**
     * 刷新上传凭证
     * @param $videoId
     * @return mixed
     */
    private function refresh_upload_video($videoId) {
        $request = new vod\RefreshUploadVideoRequest();
        $request->setVideoId($videoId);
        return $this->client->getAcsResponse($request);
    }

    /**
     * 视频上传之必填字段验证
     * @param $vinfo
     * @return array|bool
     */
    private function _upload_flie_filter($vinfo) {
        $error = ['status'=>false, 'message'=> ''];
        if ($vinfo['title']) {
            if (!String::isUtf8($vinfo['title'])) {
                $error['message'] = '标题内容请用utf8编码格式';
            }
            if (strlen($vinfo['title']) >= 128) {
                $error['message'] = '标题长度不超过128个字节';
            }
        } else {
            $error['message'] = '视频标题不能为空';
        }
        /*if ($vinfo['file_name']) {
            if (!file_exists($vinfo['file_name'])) {
                $error['message'] = '文件不存在';
            }
        } else{
            $error['message'] = '视频源文件不能为空';
        }*/
        if ($error['message']) {
            return $error;
        } else {
            return ['status'=>true, 'message'=> 'filter ok'];
        }
    }

    //使用上传凭证和地址初始化OSS客户端
    private function init_oss_client($uploadAuth, $uploadAddress) {
        $ossClient = new OssClient($uploadAuth['AccessKeyId'], $uploadAuth['AccessKeySecret'], $uploadAddress['Endpoint'],
            false, $uploadAuth['SecurityToken']);
        $ossClient->setTimeout(86400*7);    // 设置请求超时时间，单位秒，默认是5184000秒, 建议不要设置太小，如果上传文件很大，消耗的时间会比较长
        $ossClient->setConnectTimeout(10);  // 设置连接超时时间，单位秒，默认是10秒
        return $ossClient;
    }

    // 使用简单方式上传本地文件：适用于小文件上传；最大支持5GB的单个文件
    // 更多上传方式参考：https://help.aliyun.com/document_detail/32103.html
    private function upload_local_file($ossClient, $uploadAddress, $localFile) {
        return $ossClient->uploadFile($uploadAddress['Bucket'], $uploadAddress['FileName'], $localFile);
    }

    // 大文件分片上传，支持断点续传；最大支持48.8TB
    private function multipart_upload_file($ossClient, $uploadAddress, $localFile) {
        return $ossClient->multiuploadFile($uploadAddress['Bucket'], $uploadAddress['FileName'], $localFile);
    }

    /**
     * 视频上传
     * @param array $vinfo
     *      字段 | 类型 | 是否必填 | 描述
     *      $vinfo['title']  String  是 视频标题。长度不超过128个字节。UTF8编码。
     *      $vinfo['file_name']  String  是 视频源文件名。必须带扩展名，且扩展名不区分大小写。支持的扩展名参见 上传概述 的限制部分。
     *      $vinfo['description']  String  否 视频描述。长度不超1024个字节。UTF8编码。
     *      $vinfo['img']  String  否 自定义视频封面URL地址。
     *      $vinfo['tags']  String  否 视频标签。单个标签不超过32字节，最多不超过16个标签。多个用逗号分隔。UTF8编码。
     * @return object
     *      RequestId	String	请求ID。
     *      VideoId	String	视频ID。
     *      UploadAddress	String	上传地址。
     *      UploadAuth	String	上传凭证。
     */
    public function vod_upload($vinfo=[]){
        try {
            // 初始化VOD客户端并获取上传地址和凭证
            $createRes = $this->create_upload_video($vinfo);
            // 执行成功会返回VideoId、UploadAddress和UploadAuth
            $videoId = $createRes->VideoId;
            $uploadAddress = json_decode(base64_decode($createRes->UploadAddress), true);
            $uploadAuth = json_decode(base64_decode($createRes->UploadAuth), true);
            // 使用UploadAuth和UploadAddress初始化OSS客户端
            $ossClient = $this->init_oss_client($uploadAuth, $uploadAddress);
            // 上传文件，注意是同步上传会阻塞等待，耗时与文件大小和网络上行带宽有关
            $result = $this->upload_local_file($ossClient, $uploadAddress, $vinfo['file_name']);
            //$result = multipart_upload_file($ossClient, $uploadAddress, $vinfo['file_name']);
            return $videoId;
        } catch (\Exception $e) {
            if ($this->debug) {
                printf("Failed, ErrorMessage: %s", $e->getMessage());
            }
            exit();
        }
    }

    /**
     * 获取视频信息
     * @param $videoId
     * @return mixed
     */
    public function get_video_info($videoId) {
        try {
            $request = new vod\GetVideoInfoRequest();
            $request->setVideoId($videoId);
            $request->setAcceptFormat('JSON');
            return $this->client->getAcsResponse($request);
        } catch (\Exception $e) {
            if ($this->debug) {
                var_dump($e->getMessage());
            }
            return false;
        }
    }

    /**
     * 获取视频源文件地址。
     * 注意：当一路流转码完成后才可以获取到完整的源文件信息。
     * @param $videoId 视频id
     * @param int $AuthTimeout 设置超时 默认 30秒
     * @return object
     */
    public function get_mezzanine_info($videoId, $AuthTimeout=30) {
        try {
            $request = new vod\GetMezzanineInfoRequest();
            $request->setVideoId($videoId);
            if (intval($AuthTimeout) < 1) $AuthTimeout = 30;
            $request->setAuthTimeout($AuthTimeout);
            $request->setAcceptFormat('JSON');
            return $this->client->getAcsResponse($request);
        } catch (\Exception $e) {
            if ($this->debug) {
                var_dump($e->getMessage());
            }
            return false;
        }
    }

    /**
     * 修改视频信息
     * @param $videoId 要更新的视频id
     * @param $vinfo
     *      $vinfo['title']  String  否 视频标题。长度不超过128个字节。UTF8编码。
     *      $vinfo['description']  String  否 视频描述。长度不超1024个字节。UTF8编码。
     *      $vinfo['img']  String  否 自定义视频封面URL地址。
     *      $vinfo['tags']  String  否 视频标签。单个标签不超过32字节，最多不超过16个标签。多个用逗号分隔。UTF8编码。
     * @return mixed
     */
    public function update_video_info($videoId, $vinfo) {
        try {
            $request = new vod\UpdateVideoInfoRequest();
            $request->setVideoId($videoId);
            if (isset($vinfo['title'])) {
                $request->setTitle($vinfo['title']);   // 更改视频标题
            }
            if (isset($vinfo['description'])) {
                $request->setDescription($vinfo['description']);    // 更改视频描述
            }
            if (isset($vinfo['img'])) {
                $request->setCoverURL($vinfo['img']);  // 更改视频封面
            }
            if (isset($vinfo['tags']) && is_string($vinfo['tags'])) {
                $request->setTags($vinfo['tags']); // 视频标签，多个用逗号分隔(可选)
            }
            #// 更改视频分类(可在点播控制台·全局设置·分类管理里查看分类ID：https://vod.console.aliyun.com/#/vod/settings/category)
            #$request->setCateId(0);
            $request->setAcceptFormat('JSON');
            return $this->client->getAcsResponse($request);
        } catch (\Exception $e) {
            if ($this->debug) {
                var_dump($e->getMessage());
            }
            return false;
        }
    }

    /**
     * 获取vod视频列表
     * @param array $where
     * 字段 | 类型 | 是否必填 | 描述
     *      $where['start_time'] | int | 否 | 开始时间
     *      $where['end_time'] | int | 否 | 结束时间
     *      $where['page'] | int | 否 | 第几页 默认-1
     *      $where['limit'] | int | 否 | 每页显示条数 默认-20
     *      $where['sort'] | int | 否 | 根据时间顺序排序 默认降序-0 升序-1
     * @return object
     */
    public function get_video_list(array $where=[]) {
        try {
            $request = new vod\GetVideoListRequest();
            // 示例：分别取一个月前、当前时间的UTC时间作为筛选视频列表的起止时间
            $localTimeZone = date_default_timezone_get();
            date_default_timezone_set('UTC');
            //结束时间
            if (isset($where['end_time']) && intval($where['end_time']) > 1000000000) {
                $utcNow = gmdate('Y-m-d\TH:i:s\Z', $where['end_time']);
            } else {
                $utcNow = gmdate('Y-m-d\TH:i:s\Z');
                $where['end_time'] = time();
            }
            //开始时间
            if (isset($where['start_time']) && intval($where['start_time']) > 1000000000 && intval($where['start_time']) < intval($where['end_time'])) {
                $utcMonthAgo = gmdate('Y-m-d\TH:i:s\Z', $where['start_time']);
            } else {
                $utcMonthAgo = gmdate('Y-m-d\TH:i:s\Z', time() - 3*86400);
            }
            //翻页
            if (isset($where['page']) && abs(intval($where['page'])) > 0) {
                $page = abs(intval($where['page']));
            } else {
                $page = 1;
            }
            //每页显示数量 默认20
            if (isset($where['limit']) && abs(intval($where['limit'])) > 0) {
                $limit = abs(intval($where['limit']));
            } else {
                $limit = 20;
            }
            //排序
            if (isset($where['sort']) && intval($where['sort']) == 1) {
                $request->setSortBy('CreationTime：Asc');
            }
            date_default_timezone_set($localTimeZone);
            $request->setStartTime($utcMonthAgo);   // 视频创建的起始时间，为UTC格式
            $request->setEndTime($utcNow);          // 视频创建的结束时间，为UTC格式
            #$request->setStatus('Uploading,Normal,Transcoding');  // 视频状态，默认获取所有状态的视频，多个用逗号分隔
            #$request->setCateId(0);               // 按分类进行筛选
            $request->setPageNo($page);
            $request->setPageSize($limit);
            $request->setAcceptFormat('JSON');
            return $this->client->getAcsResponse($request);
        } catch (\Exception $e) {
            if ($this->debug) {
                var_dump($e->getMessage());
            }
            return [];
        }
    }

    /**
     * 删除媒体流（视频流，音频流）信息及存储文件，并且支持批量删除。
     * ps 不是删除视频原文件, 是删除视频的转码文件
     * @param $videoId
     * @return bool
     */
    public function delete_stream($videoId='') {
        try {
            if (!$videoId) {
                throw new \Exception("视频id不能为空!");
            }
            $info = $this->get_play_info($videoId);
            if ($info) {
                $jobIds = array_column($info->PlayInfoList->PlayInfo, 'JobId');
                $jobIds = array_map(function ($item) {
                    return $item->JobId;
                }, $info->PlayInfoList->PlayInfo);
                $jobIds = join(',', $jobIds);
            } else {
                $jobIds = '';
            }
            $request = new vod\DeleteStreamRequest();
            $request->setVideoId($videoId);
            $request->setJobIds($jobIds);   // 媒体流转码的作业ID列表，多个用逗号分隔；JobId可通过获取播放地址接口(GetPlayInfo)获取到。
            $request->setAcceptFormat('JSON');
            return $this->client->getAcsResponse($request);
        } catch (\Exception $e) {
            if ($this->debug) {
                var_dump($e->getMessage());
            }
            return false;
        }
    }

    /**
     * 删除视频，并且支持批量删除。
     * @param $VideoIds 多个id 用逗号分隔
     * @return mixed
     */
    public function delete_video($VideoIds='') {
        try {
            if (!$VideoIds) {
                throw new \Exception("视频id不能为空!");
            }
            if (is_array($VideoIds)) {
                $VideoIds = join(',', $VideoIds);
            }
            $request = new vod\DeleteVideoRequest();
            $request->setVideoIds($VideoIds);
            $request->setAcceptFormat('JSON');
            return $this->client->getAcsResponse($request);
        } catch (\Exception $e) {
            if ($this->debug) {
                var_dump($e->getMessage());
            }
            return false;
        }
    }
}