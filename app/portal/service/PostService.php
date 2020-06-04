<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2018 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 老猫 <thinkcmf@126.com>
// +----------------------------------------------------------------------
namespace app\portal\service;

use app\portal\model\PortalCategoryModel;
use app\portal\model\PortalPostModel;

class PostService
{

    public function adminArticleList($filter)
    {
        return $this->adminPostList($filter);
    }

    public function adminPageList($filter)
    {
        return $this->adminPostList($filter, true);
    }

    public function adminPostList($filter, $isPage = false)
    {

        $where = [
            'a.create_time' => ['>=', 0],
            'a.delete_time' => 0
        ];

        $join = [
            ['__USER__ u', 'a.user_id = u.id']
        ];

        $field = 'a.*,u.user_login,u.user_nickname,u.user_email';
        $sort = [];
        $category = empty($filter['category']) ? 0 : intval($filter['category']);
        if (!empty($category)) {

            // 修改为包含关系 2019-4-18
            $portalCategoryModel = new PortalCategoryModel();
            $category_id       = $portalCategoryModel->adminCategorySampleArray($category);
            $category_id = $portalCategoryModel->getArrayId($category_id);
            $category_id [] = $category;
            $where['b.category_id'] = ['in', $category_id];
            array_push($join, [
                '__PORTAL_CATEGORY_POST__ b', 'a.id = b.post_id'
            ]);
            $field = 'a.*,b.id AS post_category_id,b.category_id,u.user_login,u.user_nickname,u.user_email';
            $sort = ['a.list_order'=>'ASC'];
        }

        $startTime = empty($filter['start_time']) ? 0 : strtotime($filter['start_time']);
        $endTime   = empty($filter['end_time']) ? 0 : strtotime($filter['end_time']);
        if (!empty($startTime) && !empty($endTime)) {
            $where['a.published_time'] = [['>= time', $startTime], ['<= time', $endTime]];
        } else {
            if (!empty($startTime)) {
                $where['a.published_time'] = ['>= time', $startTime];
            }
            if (!empty($endTime)) {
                $where['a.published_time'] = ['<= time', $endTime];
            }
        }

        $keyword = empty($filter['keyword']) ? '' : $filter['keyword'];
        if (!empty($keyword)) {
            $where['a.post_title'] = ['like', "%$keyword%"];
        }

        if ($isPage) {
            $where['a.post_type'] = 2;
        } else {
            $where['a.post_type'] = 1;
        }

        $portalPostModel = new PortalPostModel();
        $articles        = $portalPostModel->alias('a')->field($field)
            ->join($join)
            ->where($where)
            ->order(array_merge($sort, ['update_time'=>'DESC']))
            ->paginate(10);

        return $articles;

    }

    public function publishedArticle($postId, $categoryId = 0)
    {
        $portalPostModel = new PortalPostModel();

        if (empty($categoryId)) {

            $where = [
                'post.post_type'      => 1,
                'post.published_time' => [['< time', time()], ['> time', 0]],
                'post.post_status'    => 1,
                'post.delete_time'    => 0,
                'post.id'             => $postId
            ];

            $article = $portalPostModel->alias('post')->field('post.*')
                ->where($where)
                ->find();
        } else {
            $where = [
                'post.post_type'       => 1,
                'post.published_time'  => [['< time', time()], ['> time', 0]],
                'post.post_status'     => 1,
                'post.delete_time'     => 0,
                'relation.category_id' => $categoryId,
                'relation.post_id'     => $postId
            ];

            $join    = [
                ['__PORTAL_CATEGORY_POST__ relation', 'post.id = relation.post_id']
            ];
            $article = $portalPostModel->alias('post')->field('post.*')
                ->join($join)
                ->where($where)
                ->find();
        }


        return $article;
    }

    //上一篇文章
    public function publishedPrevArticle($postId, $categoryId = 0)
    {
        $portalPostModel = new PortalPostModel();

        if (empty($categoryId)) {

            $where = [
                'post.post_type'      => 1,
                'post.published_time' => [['< time', time()], ['> time', 0]],
                'post.post_status'    => 1,
                'post.delete_time'    => 0,
                'post.id '            => ['<', $postId]
            ];

            $article = $portalPostModel->alias('post')->field('post.*')
                ->where($where)
                ->order('id', 'DESC')
                ->find();

        } else {
            $where = [
                'post.post_type'       => 1,
                'post.published_time'  => [['< time', time()], ['> time', 0]],
                'post.post_status'     => 1,
                'post.delete_time'     => 0,
                'relation.category_id' => $categoryId,
                'relation.post_id'     => ['<', $postId]
            ];

            $join    = [
                ['__PORTAL_CATEGORY_POST__ relation', 'post.id = relation.post_id']
            ];
            $article = $portalPostModel->alias('post')->field('post.*')
                ->join($join)
                ->where($where)
                ->order('id', 'DESC')
                ->find();
        }


        return $article;
    }

    //下一篇文章
    public function publishedNextArticle($postId, $categoryId = 0)
    {
        $portalPostModel = new PortalPostModel();

        if (empty($categoryId)) {

            $where = [
                'post.post_type'      => 1,
                'post.published_time' => [['< time', time()], ['> time', 0]],
                'post.post_status'    => 1,
                'post.delete_time'    => 0,
                'post.id'             => ['>', $postId]
            ];

            $article = $portalPostModel->alias('post')->field('post.*')
                ->where($where)
                ->order('id', 'ASC')
                ->find();
        } else {
            $where = [
                'post.post_type'       => 1,
                'post.published_time'  => [['< time', time()], ['> time', 0]],
                'post.post_status'     => 1,
                'post.delete_time'     => 0,
                'relation.category_id' => $categoryId,
                'relation.post_id'     => ['>', $postId]
            ];

            $join    = [
                ['__PORTAL_CATEGORY_POST__ relation', 'post.id = relation.post_id']
            ];
            $article = $portalPostModel->alias('post')->field('post.*')
                ->join($join)
                ->where($where)
                ->order('id', 'ASC')
                ->find();
        }


        return $article;
    }

    public function publishedPage($pageId)
    {

        $where = [
            'post_type'      => 2,
            'published_time' => [['< time', time()], ['> time', 0]],
            'post_status'    => 1,
            'delete_time'    => 0,
            'id'             => $pageId
        ];

        $portalPostModel = new PortalPostModel();
        $page            = $portalPostModel
            ->where($where)
            ->find();

        return $page;
    }

    public function getPostList($filter, $isPage = false)
    {

        $where = [
            'a.create_time' => ['>=', 0],
            'a.delete_time' => 0,
            'a.published_time' => ['between', [1, time()]],
            'post_status' => 1
        ];

        $join = [
            ['__USER__ u', 'a.user_id = u.id']
        ];

        $field = 'a.id,a.post_title,a.thumbnail,a.post_hits,a.post_keywords,a.post_excerpt,a.post_source';

        $category = empty($filter['category']) ? 0 : $filter['category'];
        if (!empty($category)) {
            $where['b.category_id'] = $category;
            array_push($join, [
                '__PORTAL_CATEGORY_POST__ b', 'a.id = b.post_id'
            ]);
            $field = 'a.id,a.post_title,a.thumbnail,a.post_hits,a.post_keywords,a.post_excerpt,a.post_source';
        }

        $startTime = empty($filter['start_time']) ? 0 : strtotime($filter['start_time']);
        $endTime   = empty($filter['end_time']) ? 0 : strtotime($filter['end_time']);
        if (!empty($startTime) && !empty($endTime)) {
            $where['a.published_time'] = [['>= time', $startTime], ['<= time', $endTime]];
        } else {
            if (!empty($startTime)) {
                $where['a.published_time'] = ['>= time', $startTime];
            }
            if (!empty($endTime)) {
                $where['a.published_time'] = ['<= time', $endTime];
            }
        }

        $keyword = empty($filter['keyword']) ? '' : $filter['keyword'];
        if (!empty($keyword)) {
            $where['a.post_title'] = ['like', "%$keyword%"];
        }

        if ($isPage) {
            $where['a.post_type'] = 2;
        } else {
            $where['a.post_type'] = 1;
        }

        $portalPostModel = new PortalPostModel();
        $articles        = $portalPostModel->alias('a')->field($field)
            ->join($join)
            ->where($where)
            ->order('update_time', 'DESC')
            ->paginate(10);

        return $articles;

    }
}