<?php
namespace api\v1\model;

use app\admin\model\GoodsModel;
use think\Db;
use think\Model;

class OrderModel extends Model
{
    private static $instance = null;
    protected $userId;
    protected $user;
    public static function instance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new static();
        }
        return self::$instance;
    }

    public function buy($goods_id)
    {
        $this->userId = request()->post('user_id');
        $user = request()->post('user', '', 'html_entity_decode');
        $this->user = unserialize($user);
        $goods_info = GoodsModel::instance()->where(['goods_id'=>$goods_id])->find();
        if (!$goods_info) return ['status'=>false, 'message'=>'没有该商品信息'];
        $data = [
            'order_sn' => build_order_no(),
            'user_id' => $this->userId,
            'user_name' => $this->user['user_nickname'],
            'goods_id' => $goods_id,
            'goods_amount' => $goods_info['price'],
            'pay_fee' => $goods_info['price'],
            'pay_time' => NOW_TIME,
            'order_status' => 1,
            'pay_status' => 2,
        ];
        Db::startTrans();
        try {
            //查询是否已经购买过了
            $exists = OrderModel::instance()->where(['user_id'=>$this->userId, 'goods_id'=>$goods_id, 'pay_status'=>2])->count();
            if ($exists) throw new \Exception("你已经购买过了");
            //库存处理
            if ($goods_info['stock'] == 0) {
                throw new \Exception("该商品库存不足");
            } elseif($goods_info['stock'] > 0) {
                GoodsModel::instance()->where(['goods_id'=>$goods_id])->setDec('stock');
            }
            $user_info = UserModel::instance()->where(['id'=>$this->userId])->find();
            if ($user_info['coin'] < $goods_info['price']) throw new \Exception("你剩余的图币不够{$goods_info['price']}个");
            OrderModel::instance()->data($data)->isUpdate(false)->allowField(true)->save();
            UserModel::instance()->where(['id'=>$this->userId])->setDec('coin', $goods_info['price']);
            $log = [
                'user_id' => $this->userId,
                'create_time' => NOW_TIME,
                'change' => $goods_info['price'],
                'coin' => intval($user_info['coin'] - $goods_info['price']),
                'description' => $goods_info['goods_name'],
                'remark' => '消费',
                'type' => 1
            ];
            Db::name('user_coin_log')->insert($log);
            //商品类型 1-刷题 2-打卡 3-在线课堂 4-线下课堂 5-其他
            switch ($goods_info['goods_type']) {
                case 1:
                    ExamModel::instance()->where(['goods_id'=>$goods_id])->setInc('use_num');
                    break;
                case 2:
                    DakaModel::instance()->where(['goods_id'=>$goods_id])->setInc('join_num');
                    break;
                case 3:
                case 4:
                    CourseModel::instance()->where(['goods_id'=>$goods_id])->setInc('join_num');
                    break;
            }
            Db::commit();
        } catch (\Exception $e) {
            Db::rollback();
            return ['status'=>false, 'message'=>$e->getMessage()];
        }
        return true;
    }
}

