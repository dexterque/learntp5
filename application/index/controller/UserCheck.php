<?php
/**
 * Created by PhpStorm.
 * User: TF
 * Date: 2018/11/21
 * Time: 10:51
 */

namespace app\index\controller;


class UserCheck
{
    // 检测用户是否登录
    public static function checkLogin(){
        if (!session('uid')) {
            echo json_encode(['error' => 1, 'msg' => '您还未登录！']);
            die;
        }
    }
}