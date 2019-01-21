<?php
require_once '../simplewind/extend/aliyun-php-sdk/aliyun-php-sdk-core/Config.php';    // 假定您的源码文件和aliyun-php-sdk处于同一目录。
require_once '../simplewind/extend/aliyun-php-sdk/aliyun-oss-php-sdk-2.2.4/autoload.php';
require_once './db/db.php';
use vod\Request\V20170321 as vod;
use OSS\OssClient;
use OSS\Core\OssException;
$accessKeyId = 'LTAIY772Hdl4w5QB';                    // 您的AccessKeyId
$accessKeySecret = 'tviQv1nPfTwzTiOHGkchb8GYjyjNsU';            // 您的AccessKeySecret

// 使用账号AK初始化VOD客户端
function init_vod_client($accessKeyId, $accessKeySecret) {
    $regionId = 'cn-shanghai';  // 点播服务所在的Region，国内请填cn-shanghai，不要填写别的区域
    $profile = DefaultProfile::getProfile($regionId, $accessKeyId, $accessKeySecret);
    return new DefaultAcsClient($profile);
}

// 获取视频上传地址和凭证
function create_upload_video($vodClient, $vinfo) {
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
    return $vodClient->getAcsResponse($request);
}

// 刷新上传凭证
function refresh_upload_video($vodClient, $videoId) {
    $request = new vod\RefreshUploadVideoRequest();
    $request->setVideoId($videoId);
    return $vodClient->getAcsResponse($request);
}

// 使用上传凭证和地址信息初始化OSS客户端（注意需要先Base64解码并Json Decode再传入）
function init_oss_client($uploadAuth, $uploadAddress) {
    $ossClient = new OssClient($uploadAuth['AccessKeyId'], $uploadAuth['AccessKeySecret'], $uploadAddress['Endpoint'], 
        false, $uploadAuth['SecurityToken']);
    $ossClient->setTimeout(86400*7);    // 设置请求超时时间，单位秒，默认是5184000秒, 建议不要设置太小，如果上传文件很大，消耗的时间会比较长
    $ossClient->setConnectTimeout(10);  // 设置连接超时时间，单位秒，默认是10秒
    return $ossClient;
}

// 使用简单方式上传本地文件：适用于小文件上传；最大支持5GB的单个文件
// 更多上传方式参考：https://help.aliyun.com/document_detail/32103.html
function upload_local_file($ossClient, $uploadAddress, $localFile) {
    return $ossClient->uploadFile($uploadAddress['Bucket'], $uploadAddress['FileName'], $localFile);
}

// 大文件分片上传，支持断点续传；最大支持48.8TB
function multipart_upload_file($ossClient, $uploadAddress, $localFile) {
    return $ossClient->multiuploadFile($uploadAddress['Bucket'], $uploadAddress['FileName'], $localFile);
}


function upload_work($vinfo) {
    $accessKeyId = 'LTAIY772Hdl4w5QB';                    // 您的AccessKeyId
    $accessKeySecret = 'tviQv1nPfTwzTiOHGkchb8GYjyjNsU';            // 您的AccessKeySecret
    $date = date('Ymd');
    try {
        // 初始化VOD客户端并获取上传地址和凭证
        $vodClient = init_vod_client($accessKeyId, $accessKeySecret);
        $createRes = create_upload_video($vodClient, $vinfo);

        // 执行成功会返回VideoId、UploadAddress和UploadAuth
        $videoId = $createRes->VideoId;
        $uploadAddress = json_decode(base64_decode($createRes->UploadAddress), true);
        $uploadAuth = json_decode(base64_decode($createRes->UploadAuth), true);

        // 使用UploadAuth和UploadAddress初始化OSS客户端
        $ossClient = init_oss_client($uploadAuth, $uploadAddress);

        // 上传文件，注意是同步上传会阻塞等待，耗时与文件大小和网络上行带宽有关
        //$result = upload_local_file($ossClient, $uploadAddress, $vinfo['file_name']);
        $result = multipart_upload_file($ossClient, $uploadAddress, $vinfo['file_name']);
        //存储videoId
        $row = ['vid'=>$vinfo['id'], 'videoId'=>$videoId];
        file_put_contents("./ok_{$date}.txt", json_encode($row).",\n", FILE_APPEND);
        printf("Succeed, VideoId: %s\n", $videoId);

    } catch (Exception $e) {
        //记录失败的视频信息
        file_put_contents("./error_{$date}.txt", json_encode($vinfo).",\n", FILE_APPEND);
        printf("Failed, ErrorMessage: %s\n", $e->getMessage());
    }

}

function get_play_info($client, $videoId) {
    $request = new vod\GetPlayInfoRequest();
    $request->setVideoId($videoId);
    $request->setAuthTimeout(3600*24);    // 播放地址过期时间（只有开启了URL鉴权才生效），默认为3600秒，支持设置最小值为3600秒
    $request->setAcceptFormat('JSON');
    return $client->getAcsResponse($request);
}

function object_to_array($obj) {
    $obj = (array)$obj;
    foreach ($obj as $k => $v) {
        if (gettype($v) == 'resource') {
            return;
        }
        if (gettype($v) == 'object' || gettype($v) == 'array') {
            $obj[$k] = (array) object_to_array($v);
        }
    }
    return $obj;
}

function create_upload_image($client, $imageType, $imageExt) {
    $request = new vod\CreateUploadImageRequest();
    $request->setImageType($imageType);
    $request->setImageExt($imageExt);
    $request->setAcceptFormat('JSON');
    return $client->getAcsResponse($request);
}

try {
    $client = init_vod_client($accessKeyId, $accessKeySecret);
    $imageInfo = create_upload_image($client, 'default', 'jpg');
    var_dump($imageInfo);
} catch (Exception $e) {
    print $e->getMessage()."\n";
}
exit;

//修复my_video_vod表数据
//try {
    //todo
    set_time_limit(0);
    ini_set('memory_limit', '2000M');
    $client = init_vod_client($accessKeyId, $accessKeySecret);
    // todu
    $sql = "SELECT vid,video_id FROM `st_video_vod` where video_url = '' order by create_time desc";
    $data = query($sql);
    foreach($data as $item) {
        try{
            $playInfo = get_play_info($client, $item['video_id']);
        }catch (\Exception $e){
            echo "video {$item['video_id']}: {$e->getMessage()} \n";
            continue;
        }
        if (!$playInfo) continue;
        //把获取到的数据写入到my_video_vod中
        $res = object_to_array($playInfo);
        $update = [
            'origin_url' => '',
            'origin_info' => '',
            'fd_mp4_url' => $res['PlayInfoList']['PlayInfo'][2]['PlayURL'],
            'fd_mp4' => json_encode($res['PlayInfoList']['PlayInfo'][2]),
            'fd_m3u8_url' => $res['PlayInfoList']['PlayInfo'][0]['PlayURL'],
            'fd_m3u8' => json_encode($res['PlayInfoList']['PlayInfo'][0]),
            'ld_mp4_url' => $res['PlayInfoList']['PlayInfo'][3]['PlayURL'],
            'ld_mp4' => json_encode($res['PlayInfoList']['PlayInfo'][3]),
            'ld_m3u8_url' => $res['PlayInfoList']['PlayInfo'][1]['PlayURL'],
            'ld_m3u8' => json_encode($res['PlayInfoList']['PlayInfo'][1]),
        ];
        // UPDATE `my_video_vod` SET origin_url='1', origin_info='2' WHERE `vid`='96'
        $sql = "UPDATE `my_video_vod` SET origin_url='', origin_info='', 
fd_mp4_url='{$update['fd_mp4_url']}', 
fd_mp4 = '{$update['fd_mp4']}', 
fd_m3u8_url = '{$update['fd_m3u8_url']}',
fd_m3u8 = '{$update['fd_m3u8']}',
ld_mp4_url='{$update['ld_mp4_url']}',
ld_mp4='{$update['ld_mp4']}',
ld_m3u8_url='{$update['ld_m3u8_url']}',
ld_m3u8='{$update['ld_m3u8']}' where  `vid`={$item['vid']}
";
        try{
            $res = query($sql,'mingyi');
            $r2 = query("UPDATE `my_video` SET `status`='1' WHERE (`id`={$item['vid']})");
        }catch (\Exception $exception){
            echo "video update error \n";
        }

        if ($res !== false) {
            echo "ok \n";
        } else {
            throw new Exception("sql exec error");
        }
    }

    //var_dump($playInfo);

    //todu
//} catch (Exception $e) {
//    print $e->getMessage()."\n";
//}
//修复my_video_vod表数据

//导数据
//set_time_limit(0);
//$sql = "select a.id,a.title,a.main_tag tags,CONCAT('http://img1.myzx.cn/video/',b.max) as img,CONCAT('/web/home1/picture/video/',a.url) as file_name from my_video a LEFT JOIN my_images b on a.img=b.id where a.type = 2 and a.id=18288";
//$res = query($sql,'mingyi');
//foreach($res as $item) {
//    $item['description'] = '';
//    $item['tags'] = $item['tags'] ?: '';
//    upload_work($item);
//}
//echo "完成!\n";
//导数据
