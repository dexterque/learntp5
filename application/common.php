<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件

define('ROOT_PATH', dirname(dirname(__FILE__)));
use think\Db;
// 检查投注时间是否处于最后5秒
function crapTimeIsAllowed($time, $journal_id){
    $result = Db::table('journal')
        ->field('etime')
        ->where('id', '=', $journal_id)
        ->select();

    $etime = $result[0]['etime'];

    if ($time > $etime - 5) {
        return false;
    } else {
        return true;
    }

}

// 返回乐透随机数
function lotteryRandomNumber($conditionKey){
    $A = [5, 7, 9];
    $B = [1, 3];
    $C = [0, 2, 4];
    $D = [6, 8];

    $keyA = array_rand($A);
    $keyB = array_rand($B);
    $keyC = array_rand($C);
    $keyD = array_rand($D);

    switch ($conditionKey) {
        case 'A':
            return $A[$keyA];
        case 'B':
            return $B[$keyB];
        case 'C':
            return $C[$keyC];
        case 'D':
            return $D[$keyD];
        default:
            exception('不能识别的类型');
    }
}

// 检查中奖号码 大单 小单 大双 小双
function checkLotteryNumberType($number){
    $big_single = [5, 7, 9];
    $small_single = [1, 3];
    $big_double = [6, 8];
    $small_double = [0, 2, 4];

    switch ($number) {
        case in_array($number, $big_single):
            return 'big_single';
        case in_array($number, $small_single):
            return 'small_single';
        case in_array($number, $big_double):
            return 'big_double';
        case in_array($number, $small_double):
            return 'small_double';
    }
}