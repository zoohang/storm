<?php
return [
    //阿里云 vod
    'ALIYUN_VOD' => [
        'ACCESS_KEY_ID' => 'LTAIY772Hdl4w5QB',
        'ACCESS_KEY_SECRET' => 'tviQv1nPfTwzTiOHGkchb8GYjyjNsU'
    ],
    'aliyun_sms' => [
        'accessKeyId' => 'LTAIBi1DisoozD3j', //LTAIBi1DisoozD3j 备选
        'accessKeySecret' => '5m4m2Y0kVUXQ225Vbwl7dtgGnUXGLt', //5m4m2Y0kVUXQ225Vbwl7dtgGnUXGLt 备选
        'SignName' => '风暴教育',
        'dayLimit' => 5, //24H最大发送数量
        'exception' => '13399878665,18581290597', //例外手机号[测试用]
    ],
    'aliyun_oss' => [
        "AccessKeyID" => "LTAITi0IhXXUImZu",
        "AccessKeySecret" => "ZAmO8sF2sYiSR9CXYSyrG8fjjZnl69",
        "RoleArn" => "acs:ram::1316020317035687:role/aliyunosstokengeneratorrole",
        "BucketName" => "fengbaojy-static-resource",
        "Endpoint" => "oss-cn-shanghai.aliyuncs.com",
        "TokenExpireTime" => "900",
        "PolicyFile" =>"simplewind/extend/aliyun-php-sdk/policy/all_policy.txt",
        "Dir" => 'images/'
    ],
    //静态文件url前缀
    'statis_url_prefix' => 'http://www.storm.com/',
];