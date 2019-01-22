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

use think\Db;

class RestUserBaseController extends RestBaseController
{

    public function _initialize()
    {

        if (empty($this->user)) {
            $this->error(['code' => 401, 'msg' => '登录已失效!']);
        }

    }

    /**
     * 用户取消收藏
     */
    public function delCollect($data)
    {
        $where['object_id'] = $data['id'];
        $where['type']      = $data['type'];
        $where['user_id'] = $this->userId;
        $data             = Db::name("UserFavorite")->where($where)->delete();
        if ($data !== false) {
            $this->success("取消收藏成功！");
        } else {
            $this->error("取消收藏失败！");
        }
    }

    /**
     * 用户收藏 type [2=>'daka']
     */
    public function collect($data)
    {
        $id    = $data['id'];
        $table = $data['table'];

        $findFavoriteCount = Db::name("user_favorite")->where([
            'object_id'  => $id,
            'table_name' => $table,
            'user_id'    => $this->userId
        ])->count();

        if ($findFavoriteCount > 0) {
            $this->error("您已收藏过啦");
        }

        $type       = $data['type'];
        $title       = $data['title'];
        $url         = $data['url'];
        $description = isset($data['description']) ? $data['description'] : '';
        $description = empty($description) ? $title : $description;
        Db::name("user_favorite")->insert([
            'user_id'     => $this->userId,
            'title'       => $title,
            'description' => $description,
            'url'         => $url,
            'object_id'   => $id,
            'table_name'  => $table,
            'create_time' => time(),
            'type'        => $type
        ]);

        $this->success('收藏成功');
    }

}