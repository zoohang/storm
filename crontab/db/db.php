<?php
set_time_limit(0);
ini_set('memory_limit', '1024M');
date_default_timezone_set('PRC');
const DS = DIRECTORY_SEPARATOR;

function query($sql, $db='storm') {
    $mysql = new \mysqli('myzxmysql.mysql.rds.aliyuncs.com', 'yuanzuohang', 'NRYoP2uLRG*U9dx', $db,'3316');
    if (!$mysql) {
        printf("Can't connect to MySQL Server. Errorcode: %s ", mysqli_connect_error());
        exit;
    }

    if (stripos($sql, 'select') !== false ){
        $list = [];
        if ($result = mysqli_query($mysql, $sql)) {
            while( $row = mysqli_fetch_assoc($result) ){
                array_push($list, $row);
            }
            mysqli_free_result($result);
        }
        mysqli_close($mysql);
        return $list;
    } else {
        $result = mysqli_query($mysql, $sql);
        if ($result) {
            $row = mysqli_affected_rows($mysql);
            mysqli_close($mysql);
            return $row;
        } else {
            printf("MySQL error. Errorcode: %s ; Errormsg: %n", mysqli_errno($mysql), mysqli_error($mysql));
            return false;
        }
    }
}

function mongo_query($table, $condition=[], $field=[], $limit=10, $skip=0) {
    //连接服务器
    $conn = new \MongoClient('mongodb://master.myzx.db:17017');
    $db = $conn->news;
    $collection = $db->$table;
    if ($field) {
        if (is_string($field)) {
            $field = explode(',', $field);
        }
        $new_field = [];
        foreach($field as $val) {
            $new_field[$val] = true;
        }
        unset($field);
        $field = $new_field;
    }
    $field = array_merge($field, ['_id'=>false]);
    $cursor = $collection->find($condition)->fields($field)->skip($skip)->limit($limit);
    $data = [];
    foreach ($cursor as $value) {
        $data[] = $value;
    }
    unset($cursor);
    $conn->close();
    return $data;
}
