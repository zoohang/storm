<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2017 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
use think\Route;
//自定义路由
Route::group('v2', [
    'course/videoMain' => ['@/v2/Index/courseVideoMain'],
    'course/videoList' => ['@/v2/Index/videoList'],
    'mall/index' => ['@/v2/Index/mallIndex'],
    'mall/getList' => ['@/v2/Index/getList'],
]);
Route::group('v1', [
    'exam/getCategoryExam' => ['@/v2/Index/examGetCategoryExam'],
    'exam/getSchool' => ['@/v2/Index/examGetSchool'],
    'exam/getExamList' => ['@/v2/Index/getExamList'],
]);

$apps = cmf_scan_dir(APP_PATH . '*', GLOB_ONLYDIR);

foreach ($apps as $app) {
    $routeFile = APP_PATH . $app . '/route.php';

    if (file_exists($routeFile)) {
        include_once $routeFile;
    }

}


if (file_exists(CMF_ROOT . "data/conf/route.php")) {
    $runtimeRoutes = include CMF_ROOT . "data/conf/route.php";
} else {
    $runtimeRoutes = [];
}

return $runtimeRoutes;