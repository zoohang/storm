<?php
ini_set('memory_limit', '1024M');
date_default_timezone_set('PRC');

class mongo_db{
    private static $instance = null;
    protected $conn; //链接对象
    protected $link = 'mongodb://master.myzx.db:17017'; //访问链接名称
    protected $db = 'news'; //数据库 名称
    protected $table = ''; //数据表 名称
    protected $where = []; //where条件
    protected $field = []; //查询字段
    protected $collection;

    private function __clone()
    {
    }

    public static function getInstance($link=''){
        if (!self::$instance instanceof self) {
            self::$instance = new self($link);
        }
        return self::$instance;
    }

    public function __construct($link='')
    {
        $link ? $this->link = $link : '';
        //var_dump($this->link);die;
        try {
            $this->conn = new \MongoClient($this->link);
            return $this->conn;
        } catch (\Exception $e) {
            printf('error : %s', $e->getMessage());
        }
    }

    public function table($table, $db='') {
        if ($table) $this->table = $table;
        if ($db) $this->db = $db;
        $this->collection =  $this->conn->selectCollection($this->db, $this->table);
        return $this->collection;
    }

    public function query($table, $condition=[], $field=[], $limit=10, $skip=0) {


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

    public function mongo_exec() {

    }
}