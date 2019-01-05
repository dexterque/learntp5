<?php
/**
 * Created by PhpStorm.
 * User: TF
 * Date: 2018/11/19
 * Time: 15:16
 */

namespace app\admin\controller;
use think\Controller;
use think\Db;
use think\Request;

// 后台类

class Index extends Controller
{
    // 用户列表
    public function users(){
        $result = Db::table("user_asset")
            ->field("id, uid, balance, frozen")
            ->select();

        return view("index/users", ['users' => $result]);
    }

    // 给用户打款
    public function deposit(Request $request){
        $data = $request->param();
        $balance = $data['balance'];
        if ($data['type'] == "minus") {
            $balance = -$data['balance'];
        }
        $uids = $data["uids"];
        unset($data['uids']);

        foreach ($uids as $key => $uid) {
            $data2[$key]['money'] = $balance;
            $data2[$key]['note'] = $data['note'];
            $data2[$key]['create_time'] = time();
            $data2[$key]['uid'] = $uid;
        }

        if (count($uids) == 0) {
            return json(["error" => 1, "msg" => "缺少必要参数"]);
        }

        // 更新用户账户
        foreach ($uids as $uid) {
            $sql = "update user_asset set balance=balance+$balance where uid={$uid}";
            Db::query($sql);
        }

        // 插入订单表
        Db::table("order")->insertAll($data2);
        echo json_encode(['error' => 0, 'msg' => '操作成功！']);
    }

    // 订单列表
    public function orders(){
        $result = Db::table("order")
            ->field("id, uid, money, status, create_time, note, operate_type")
            ->select();

        foreach ($result as $key=>$row) {
            $result[$key]['status'] ? $result[$key]['status'] = "成功" : $result[$key]['status'] = "失败";
            $result[$key]['create_time'] = date("Y-m-d H:i:s", $result[$key]['create_time']);
        }
        return view("index/orders", ['orders' => $result]);
    }
    // 期数列表
    public function journals(){
        $rows = Db::table("journal")
            ->field('*')
            ->select();
        foreach ($rows as $key=>$row) {
            $rows[$key]['stime'] = date("Y-m-d H:i:s", $rows[$key]['stime']);
            $rows[$key]['etime'] = date("Y-m-d H:i:s", $rows[$key]['etime']);
        }

        return view("index/journals", ['journals' => $rows]);
    }
    // 签到列表
    public function signs(){
        $rows = Db::table("sign")
            ->field("*")
            ->select();
        foreach ($rows as $key=>$row) {
            $rows[$key]['signed_time'] = date("Y-m-d H:i:s", $rows[$key]['signed_time']);
            $rows[$key]['buy_gift'] ? $rows[$key]['buy_gift'] = "是" : $rows[$key]['buy_gift'] = "否";
        }

        return view("index/signs", ['signs' => $rows]);
    }
}