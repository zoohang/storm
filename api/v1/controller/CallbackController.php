<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace api\v1\controller;

use cmf\controller\BaseController;
use think\Config;
use think\Db;
use think\Log;

class CallbackController extends BaseController
{
    public function vodCallback()
    {
        $data = $this->request->param();
        if (!$data) $this->ajaxReturn([], 400, 'no data');
        if (!isset($data['Status']) || $data['Status'] !== 'success') $this->ajaxReturn([], 400, 'callback failed');
        Db::startTrans();
        try {
            $video_id = $data['VideoId'];
            $video_url = $data['StreamInfos'][0]['FileUrl'];
            $source_raw = json_encode($data, JSON_UNESCAPED_SLASHES|JSON_UNESCAPED_UNICODE);
            $exists = Db::name('video_vod')->where(['video_id'=>$video_id])->find();
            if (!$exists) {
                Db::name('video_vod')->insert([
                    'video_id' => $video_id,
                    'video_url' => $video_url,
                    'source_raw' => $source_raw,
                    'create_time' => NOW_TIME
                ]);
            } else {
                Db::name('video_vod')->where(['video_id'=>$video_id])->update([
                    'video_url' => $video_url,
                    'source_raw' => $source_raw,
                    'update_time' => NOW_TIME
                ]);
            }
            Db::commit();
        } catch (\Exception $e) {
            Db::rollback();
            $this->ajaxReturn([], 400, $e->getMessage());
        }
        $this->ajaxReturn([], 0, 'success');
    }
}
