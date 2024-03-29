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
use think\Config;
use think\Db;
use think\Url;
use dir\Dir;
use think\Route;
use think\Loader;
use think\Request;
use cmf\lib\Storage;

function diy_test() {
    return '12321312';
}

function get_image_url($file, $style = '750') {
    if (empty($file)) {
        return '';
    }
    if (strpos($file, "http") === 0) {
        if (strpos($file, \config('aliyun_oss.Preview_Pre')) === 0 && $style && strpos($file, 'x-oss-process=style') === false) $file .= "?x-oss-process=style/$style";
        return $file;
    } else if (strpos($file, "/") === 0) {
        return cmf_get_domain() . $file;
    } else {
        //return config('aliyun_oss.Preview_Pre') . $file;
        $storage = Storage::instance();
        return $storage->getImageUrl($file, $style);
    }
}

function get_static_domain() {
    return config('url_domain_root');
}

/**
 * 替换编辑器内容中的文件地址
 * @param string $content 编辑器内容
 * @param boolean $isForDbSave true:表示把绝对地址换成相对地址,用于数据库保存,false:表示把相对地址换成绝对地址用于界面显示
 * @return string
 */
function replace_content_file_url($content, $isForDbSave = false)
{
    //import('phpQuery.phpQuery', EXTEND_PATH);
    \phpQuery::newDocumentHTML($content);
    $pq = pq(null);

    $storage       = Storage::instance();
    $localStorage  = new cmf\lib\storage\Local([]);
    $storageDomain = $storage->getDomain();
    $domain        = request()->host();

    $images = $pq->find("img");
    if ($images->length) {
        foreach ($images as $img) {
            $img    = pq($img);
            $imgSrc = $img->attr("src");

            if ($isForDbSave) {
                if (preg_match("/^\/upload\//", $imgSrc)) {
                    $img->attr("src", preg_replace("/^\/upload\//", '', $imgSrc));
                } elseif (preg_match("/^http(s)?:\/\/$domain\/upload\//", $imgSrc)) {
                    $img->attr("src", $localStorage->getFilePath($imgSrc));
                } elseif (preg_match("/^http(s)?:\/\/$storageDomain\//", $imgSrc)) {
                    $img->attr("src", $storage->getFilePath($imgSrc));
                }

            } else {
                $img->attr("src", get_image_url($imgSrc));
            }

        }
    }

    $links = $pq->find("a");
    if ($links->length) {
        foreach ($links as $link) {
            $link = pq($link);
            $href = $link->attr("href");

            if ($isForDbSave) {
                if (preg_match("/^\/upload\//", $href)) {
                    $link->attr("href", preg_replace("/^\/upload\//", '', $href));
                } elseif (preg_match("/^http(s)?:\/\/$domain\/upload\//", $href)) {
                    $link->attr("href", $localStorage->getFilePath($href));
                } elseif (preg_match("/^http(s)?:\/\/$storageDomain\//", $href)) {
                    $link->attr("href", $storage->getFilePath($href));
                }

            } else {
                if (!(preg_match("/^\//", $href) || preg_match("/^http/", $href))) {
                    $link->attr("href", get_file_download_url($href));
                }

            }

        }
    }

    $content = $pq->html();

    \phpQuery::$documents = null;


    return $content;

}

/**
 * 获取文件下载链接
 * @param string $file 文件路径，数据库里保存的相对路径
 * @param int $expires 过期时间，单位 s
 * @return string 文件链接
 */
function get_file_download_url($file, $expires = 3600)
{
    if (empty($file)) {
        return '';
    }

    if (strpos($file, "http") === 0) {
        return $file;
    } else if (strpos($file, "/") === 0) {
        return $file;
    } else {
        //$storage = Storage::instance();
        //return $storage->getFileDownloadUrl($file, $expires);
        return get_static_domain() . 'upload/' . $file;
    }
}

function gmt_iso8601($time) {
    $dtStr = date("c", $time);
    $mydatetime = new DateTime($dtStr);
    $expiration = $mydatetime->format(DateTime::ISO8601);
    $pos = strpos($expiration, '+');
    $expiration = substr($expiration, 0, $pos);
    return $expiration."Z";
}

function oss_img_pre($img) {
    return Config::get('aliyun_oss.Preview_Pre').$img;
}

function build_order_no() {
    return date('Ymd').substr(implode(NULL, array_map('ord', str_split(substr(uniqid(), 7, 13), 1))), 0, 8);
}

function sec2time($sec) {
    $format = $sec>=3600 ? 'H:i:s': 'i:s';
    return date($format, $sec);
}

function baiduLinkFormat($str) {
    preg_match('/[a-zA-z]+:\/\/[^\s]*/', $str, $urls);
    preg_match_all('/[0-9a-zA-Z]+/', $str, $codes);
    return ['url' => array_shift($urls), 'code'=> array_pop($codes[0]), 'download_addr'=>$str];
}

if (!function_exists('dd')) {
    function dd()
    {
        $vars = func_get_args();
        foreach ($vars as $v) {
            var_dump($v);
            echo PHP_EOL;
        }
        exit(1);
    }
}