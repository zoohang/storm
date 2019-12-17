<?php
namespace app\base\model;
use OSS\OssClient;
use OSS\Core\OssException;

class OssModel {

    protected $ossClient;
    protected $bucket;
    private static $instance = null;

    public static function getInstance(){
        if (!self::$instance instanceof self) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function __construct() {
        $ossconf = config('aliyun_oss');
        $accessKeyId = $ossconf['AccessKeyID'];
        $accessKeySecret = $ossconf['AccessKeySecret'];
        $endpoint = $ossconf['Endpoint'];
        $this->bucket = $ossconf['BucketName'];
        try {
            $this->ossClient = new OssClient($accessKeyId, $accessKeySecret, $endpoint);
            //如果没有在阿里云后台手动创建bucket 需要运行下面的代码进行创建
            //$this->ossClient->createBucket($this->bucket);
        } catch (OssException $e) {
            print $e->getMessage();
        }
    }

    /**
     * 字符串上传
     */
    public function uploadStr($file_name, $content) {
        try{
            $res = $this->ossClient->putObject($this->bucket, $file_name, $content);
        } catch(OssException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        return $res['info'];
    }

    /**
     * 文件上传
     */
    public function uploadFile($file_name, $file_path) {
        try {
            $res = $this->ossClient->uploadFile($this->bucket, $file_name, $file_path);
        } catch (OssException $e) {
            printf(__FUNCTION__ . ": FAILED\n");
            printf($e->getMessage() . "\n");
            return;
        }
        return $res['info'];
    }

}