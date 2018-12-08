<?php
/**
 * CURL request
 * @param $path
 * @param $method
 * @param null $body
 * @param null $headers
 * @return array
 */
function curl_request($path, $method, $body = null, $headers = null)
{
    $curl    = curl_init();
    $set_arr = array(
        CURLOPT_URL            => $path,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING       => "",
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_SSL_VERIFYHOST => false,
        CURLOPT_MAXREDIRS      => 10,
        CURLOPT_TIMEOUT        => 30,
        CURLOPT_HTTP_VERSION   => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST  => "{$method}",
        CURLOPT_HTTPHEADER     => array(
            "cache-control: no-cache",
        ),
    );
    if ($method == 'POST' || $method == 'PUT') {
        $set_arr[CURLOPT_POSTFIELDS] = $body;
        $set_arr[CURLOPT_HTTPHEADER] = array(
            "cache-control: no-cache",
            "content-type: application/json",
        );
    }
//        dump($set_arr);
    curl_setopt_array($curl, $set_arr);
    $response = curl_exec($curl);
    $status   = curl_getinfo($curl, CURLINFO_HTTP_CODE);
    $err      = curl_error($curl);
    curl_close($curl);
    if ($err) {
        $message = "cURL Error #:" . $err;
        $res     = '';
    } elseif ($status == 200 || $status == 204) {
        $res     = $response;
        $message = 'ok';
    } else {
        $res     = '';
        $message = 'failed';
    }
    return ['status' => $status, 'data' => $res, 'message' => $message];
}

function convert_time($time) {
    $format = $time >= 3600 ? 'H:i:s': 'i:s';
    return $time ? date($format, $time) : '';
}

function get_client_ip($type = 0) {
    $type       =  $type ? 1 : 0;
    static $ip  =   NULL;
    if ($ip !== NULL) return $ip[$type];
    if (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) {
        $arr    =   explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
        $pos    =   array_search('unknown',$arr);
        if(false !== $pos) unset($arr[$pos]);
        $ip     =   trim($arr[0]);
    }elseif (isset($_SERVER['HTTP_CLIENT_IP'])) {
        $ip     =   $_SERVER['HTTP_CLIENT_IP'];
    }elseif (isset($_SERVER['REMOTE_ADDR'])) {
        $ip     =   $_SERVER['REMOTE_ADDR'];
    }
    // IP地址合法验证
    $long = sprintf("%u",ip2long($ip));
    $ip   = $long ? array($ip, $long) : array('0.0.0.0', 0);
    return $ip[$type];
}

if (!function_exists('getallheaders')) {
    function getallheaders() {
        $headers = [];
        foreach ($_SERVER as $name => $value) {
            if (substr($name, 0, 5) == 'HTTP_') {
                $headers[str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($name, 5)))))] = $value;
            }
        }
        return $headers;
    }
}
