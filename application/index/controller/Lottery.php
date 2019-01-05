<?php
/**
 * Created by PhpStorm.
 * User: TF
 * Date: 2018/11/15
 * Time: 11:37
 */
namespace app\index\controller;

use think\db;
use think\Exception;
use think\Controller;
use app\index\controller\UserCheck;
use think\Request;

// 游戏类
class Lottery extends Controller{


    // 开始一期
    public function startLottery(){
        ini_set("max_execution_time", 0);
        set_time_limit(0);// 通过set_time_limit(0)可以让程序无限制的执行下去
        ini_set('memory_limit', '-1');  // 设置内存限制
        $flag = [];
        while (true) {
            $stime = strtotime(date("H:i"));  // 时间点从整分钟开始
            $etime = $stime + 5 * 60 - 5;

            $now_minute = date("i");
            $now_second = date("s");
            echo "\n";
            echo "--\n";
            echo $now_minute;
            echo "\n";
            echo $now_second;
            echo "\n";
            echo "--\n";

            if ($now_minute % 5 == 0 && empty($flag[$now_minute])) {
                echo "\n";
                echo "!!\n";
                echo $now_minute;
                echo "\n";
                echo $now_second;
                echo "\n";
                echo "!!\n";
                // 查询是否有未开奖的记录，如果没有就插入一期
                $check_lottery_number_counts = Db::table('journal')->where('lottery_number', '=', '-1')->count();
                dump($check_lottery_number_counts);
                if (empty($check_lottery_number_counts)) {
                    $flag[$now_minute] = 1;
                    $data = ['stime' => $stime, 'etime' => $etime];
                    $journal_id = Db::table('journal')->insert($data);
                }
            } else {
                unset($flag[$now_minute]);
            }

            if ($now_minute % 5 == 4 && $now_second >= 55 && empty($flag['s'.$now_second])) {
                echo "\n";
                echo "==\n";
                echo $now_minute;
                echo "\n";
                echo $now_second;
                echo "==\n";
                echo "\n";
                // 查到未开奖的记录 更新中奖号码开奖
                $result = Db::table('journal')->field('id')->where('lottery_number', '=', '-1')->select();
                dump($result);
                if (isset($result[0])) {
                    $journal_id = $result[0]['id'];
                } else {
                    $journal_id = 0;
                }

                if (!empty($journal_id)) {
                    $flag['s'.$now_second] = 1;
                    // 开奖
                    $this->lotteryResult($journal_id);

                }
            } else {
                unset($flag['s'.$now_second]);
            }
//            ob_flush();
//            flush();
            sleep(1);
        }
    }

    // 查看当期奖池 （总的bi8币数）
    public function totalBi8(Request $request){
        $journal_id = intval($request ->journal_id);
        $result = Db::table('crap')->where('jid', "=", $journal_id)->sum('crap_money');
        return json(['error' => 0, 'data' => ['total_bi8' => $result]]);
    }

    // 查看本期开奖结果
    public function lotteryResult($journal_id){

        // 查出用户投注情况
        $result = DB::table('crap')
            ->field('sum(crap_money) crap_total, crap_type')
            ->group('crap_type')
            ->select();

        // 用户投注有总共有8种情况
        $crap_types = ['single', 'double', 'big', 'small', 'big_single', 'big_double', 'small_double', 'small_single'];
        foreach ($result as $value) {
            $has_types[] = $value['crap_type'];
        }
        $diff = array_diff($crap_types, $has_types);
        foreach ($diff as $value) {
            $result[] = ['crap_total' => 0, 'crap_type' => $value];
        }

        // 结果只能落在以下4种情况之一
        // 1. a=大+单+2大单
        // 2. b=小+单+2小单
        // 3. c=小+双+2小双
        // 4. d=大+双+2大双

        foreach ($result as $key=>$value) {
            $result[$value['crap_type']] = $value['crap_total'];
            unset($result[$key]);
        }

        // 1.计算(a,b,c,d)随机取最小项结果
        // 2.在最小金额数的投注情况随机出一位数字
        $conditionA = $result['big'] + $result['single'] + 2 * $result['big_single'];
        $conditionB = $result['small'] + $result['single'] + 2 * $result['small_single'];
        $conditionC = $result['small'] + $result['double'] + $result['small_double'];
        $conditionD = $result['big'] + $result['double'] + 2 * $result['big_double'];
        $arr = ['A'  => $conditionA, 'B' => $conditionB, 'C' => $conditionC, 'D' => $conditionD];

        $condition = min($arr);
        $conditionKey = array_search($condition, $arr);
        $lotteryNumber = lotteryRandomNumber($conditionKey); // 获奖号码

        // 检查中奖号码 大单 小单 大双 小双
        $lotteryNumberType = checkLotteryNumberType($lotteryNumber);

        // 本期获奖号码更新到数据表
        $data = ['lottery_number' => $lotteryNumber];
        Db::table('journal')->where('id', $journal_id)->update($data);

        // 查询投注情况，奖励
        $res = Db::table('crap')
            ->field('crap_type, uid, crap_money')
            ->where('jid', '=', $journal_id)
            ->select();


        $data = [];
        foreach ($res as $v) {
            // 计算奖励

            // 完全匹配奖励为3.8倍， 匹配一个奖励1.95倍，完全不匹配奖励0
            if ($v['crap_type'] == $lotteryNumberType) {
                $bonus = $v['crap_money'] * 3.8;
            } elseif ($v['crap_type'] != $lotteryNumberType && strpos($lotteryNumberType, $v['crap_type']) !== false) {
                $bonus = $v['crap_money'] * 1.95;
            } else {
                $bonus = 0;
            }

            $data[] = ['jid' => 1, 'bonus' => $bonus, 'uid' => $v['uid']];
        }
        // 插入奖励表
        Db::table('bonus')->insertAll($data);

        echo $lotteryNumber;
    }

    // 获取最新一期信息 和当前的时间戳
    public function getLatestJournal(){
        $result = Db::table("journal")
            ->field('id journal_id, etime')
            ->order('id', "desc")
            ->limit(0, 1)
            ->find();
        $sever_time = time();
        $result['sever_time'] = $sever_time;

        echo json_encode($result);
        exit;
    }

    // 开奖历史记录
    public function lotteryHistory(){
        $sql = "SELECT
            count(C.uid) users, C.jid,  sum(B.bonus) total_bonus, J.stime journal_stime, J.lottery_number
        FROM
            crap C,
            bonus B,
            journal J
        WHERE
            C.jid = B.jid
        and C.uid = B.uid
        AND J.id = C.jid
        
        GROUP BY J.id";

        $rows = Db::query($sql);

        return json(['error' => 0, 'data' => ['list' => $rows]]);
    }
}