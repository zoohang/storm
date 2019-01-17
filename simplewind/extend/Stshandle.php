<?php
use Sts\Request\V20150401 as Sts;
class Stshandle {

    public function read_file($fname) {
        $content = '';
        if (!file_exists($fname)) {
            echo "The file $fname does not exist\n";
            exit (0);
        }
        $handle = fopen($fname, "rb");
        while (!feof($handle)) {
            $content .= fread($handle, 10000);
        }
        fclose($handle);
        return $content;
    }

    public function getToken() {
        include_once EXTEND_PATH. 'aliyun-php-sdk/aliyun-php-sdk-core/Config.php';
        date_default_timezone_set('PRC');
        \think\Config::load(CMF_ROOT.'data/conf/config.php');
        //$content = $this->read_file(EXTEND_PATH.'aliyun-php-sdk/config.json');
        $content = \think\Config::get('aliyun_oss');
        $myjsonarray = (object)$content;
        $accessKeyID = $myjsonarray->AccessKeyID;
        $accessKeySecret = $myjsonarray->AccessKeySecret;
        $roleArn = $myjsonarray->RoleArn;
        $tokenExpire = $myjsonarray->TokenExpireTime;
        //$policy = $this->read_file(EXTEND_PATH.'aliyun-php-sdk/'.$myjsonarray->PolicyFile);
        $policy = $this->read_file(CMF_ROOT.$myjsonarray->PolicyFile);


        try{
            $iClientProfile = DefaultProfile::getProfile("cn-shanghai", $accessKeyID, $accessKeySecret);
            $client = new DefaultAcsClient($iClientProfile);
            $request = new Sts\AssumeRoleRequest();
            $request->setRoleSessionName("client_name");
            $request->setRoleArn($roleArn);
            $request->setPolicy($policy);
            $request->setDurationSeconds($tokenExpire);
            //$response = $client->doAction($request);
            $response = $client->getAcsResponse($request);
            $rows = array();
            $content = $response;
            if ($content->Credentials)
            {
                $rows['AccessKeyId'] = $content->Credentials->AccessKeyId;
                $rows['AccessKeySecret'] = $content->Credentials->AccessKeySecret;
                $rows['Expiration'] = $content->Credentials->Expiration;
                $rows['SecurityToken'] = $content->Credentials->SecurityToken;
            }
            else
            {
                $rows['AccessKeyId'] = "";
                $rows['AccessKeySecret'] = "";
                $rows['Expiration'] = "";
                $rows['SecurityToken'] = "";
            }
            return $rows;
        }catch (\Exception $e) {
            return json_encode($e->getTrace());
        }
    }
}