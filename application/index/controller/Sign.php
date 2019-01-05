<?php
/**
 * Created by PhpStorm.
 * User: TF
 * Date: 2018/11/15
 * Time: 11:42
 */

namespace app\index\controller;
use think\Controller;
use think\Db;
use think\Exception;
use app\index\controller\User;

// 签到类
class Sign extends Controller
{
    public function userSign(){
        // 用户每日签到
        // 查最新一条记录的continuous_day

        $continuous_day = 0;
        $signed_time = 0;
        $signed_bonus = 0;

        $result = Db::table('sign')
            ->field('continuous_day, signed_time, signed_bonus, buy_gift')
            ->where('uid', '=', '16')
            ->order('signed_time', 'desc')
            ->limit('0, 1')
            ->select();

        if (count($result) > 0 ) {
            $continuous_day = $result[0]['continuous_day'];
            $signed_time = $result[0]['signed_time'];
            $signed_bonus = $result[0]['signed_bonus'];
        }


        $uid = session('uid');
        $now_signed_time = time();

        $datetime1 = new \DateTime(date('Y-m-d', $now_signed_time));
        $datetime2 = new \DateTime(date('Y-m-d', $signed_time));
        $interval = $datetime1->diff($datetime2);
        $interval = $interval->days; // 间隔天数

        if ($interval > 1) {
            // 不连续 bonus + 1
            $signed_bonus += 1;
            $continuous_day = 1;
        } elseif ($interval <= 0) {
            exception("非法操作");
        } else {
            // 连续
            if ($continuous_day >= 7) {
                $signed_bonus += 7;
            } else {
                $signed_bonus = $signed_bonus + $continuous_day + 1;
            }

            $continuous_day += 1;
        }

        $data = ['uid' => $uid, 'continuous_day' => $continuous_day, 'signed_bonus' => $signed_bonus, 'signed_time' => $now_signed_time];
        Db::table('sign')
            ->insert($data);
    }

    // 购买礼包
    public function buyGift(){
//        // 获取配置定义的早期时间段
//        $result = Db::table('config')
//            ->field('early_stime, early_etime')
//            ->where('id', '=', '1')
//            ->select();
//        $early_stime = $result[0]['early_stime'];
//        $early_etime = $result[0]['early_etime'];

        // 更新用户最新一条记录的buy_gift flag
        $uid = session('uid');
        Db::query("UPDATE sign set buy_gift='1' where uid={$uid} ORDER BY signed_time desc LIMIT 1");
        // 用户的账户 - 10个币 @todo
        $user = new User();
        $user->userBalanceOperate(-10, "signed");
    }

    // 获取昨天购买礼包的用户总数
    public function getYesterdayTotalUsers(){
        $result = Db::query("select uid from sign where FROM_UNIXTIME(signed_time, '%Y-%m-%d') = subdate(current_date, 1)");
        $arr = array_map(function ($el) {
            return $el['uid'];
        }, $result);

        return $arr ?: [];
    }

    // 获取今天签到时间 < 9 && > 5 的用户总数 并且 gift_bonus 为0
    public function getTodaySignInRangeUsers(){
        $sql = "select uid from sign where (HOUR(signed_time)>5 and HOUR(signed_time)<9) and gift_bonus=0";
        $result = Db::query($sql);

        $todaySignInRangeUsers = [];
        if (count($result)) {
            $todaySignInRangeUsers = array_map(function ($el) {
                return $el['uid'];
            }, $result);
        }

        return $todaySignInRangeUsers ?: [];
    }

    //

    // 在9点以后执行 礼包奖励
    public function addGiftBonus(){
        $yesterdayUsers = count($this->getYesterdayTotalUsers());
        $todayUsers = count($this->getTodaySignInRangeUsers());

        if ($todayUsers == 0) {
            return;
        }

        // 奖励数
        $totalMoney = $yesterdayUsers * 10;
        $perBonus = $totalMoney / $todayUsers; // 每个人的奖励金额

        if (date("H") > 9) {
            // 今天签到的用户平分昨天奖金池的钱
            $userIds = implode(',', $this->getTodaySignInRangeUsers());
            $sql = "update sign set gift_bonus={$perBonus} where id in ({$userIds}) and DATE(FROM_UNIXTIME(signed_time)) = DATE(NOW())";
            Db::query($sql);
        }
    }
}