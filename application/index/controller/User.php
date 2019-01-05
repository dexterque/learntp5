<?php
/**
 * Created by PhpStorm.
 * User: TF
 * Date: 2018/11/15
 * Time: 9:30
 */

namespace app\index\controller;

use think\App;
use think\Config;
use think\Db;
use app\index\controller\Lottery;
use think\Controller;
use think\Loader;
use think\Request;
use app\index\controller\UserCheck;
use think\session;

// 用户类
class User extends Controller
{
    private $userinfo = [];

    // 用户中心
    public function ucenter()
    {
        UserCheck::checkLogin();
        echo 'ucenter';
    }

    // 用户登录
    public function loginIndex()
    {
        echo "登录页面";
    }

    public function login(Request $request)
    {
        // 用户登录，写入session，跳转到用户中心
        $username = isset($_GET['username']) ? $_GET['username'] : '';
        $password = isset($_GET['password']) ? $_GET['password'] : '';
        $nickName = $request->nickName;

        $url = config('api') . "login?username=$username&password=$password";
        $result = file_get_contents($url);
        $obj = json_decode($result);
        if ($obj->error) {
            echo $result;
            die;
        }
        $uid = $obj->data->userid;

        if (!$this->isExistInUserAsset($uid)) {
            // 写入用户资产表
            Db::table('user_asset')
                ->insert(['uid' => $obj->data->userid, 'nick_name' =>$nickName]);
        }
        session('uid', $uid);
        $this->success('登录成功', 'User/ucenter');
    }

    // 发送短信验证码
    public function sendMobileCode()
    {
        $username = isset($_GET['username']) ? $_GET['username'] : '';
        // 正则验证手机号
        if (!preg_match("/^1[34578]\d{9}$/", $username)) {
            return json(['error' => 1, 'msg' => '手机号格式错误']);
        }

        $digits = 4;
        $randomNumbers = rand(pow(10, $digits - 1), pow(10, $digits) - 1); // 4位随机码
        $obj = new \alisms\SendSms($username, $randomNumbers);
        $obj->mySendSms(); // 发送验证码
        session('mobile_code', $randomNumbers); // 写到session
    }

    // 用户注册
    public function register(Request $request)
    {
        // 线上交易所用户注册成功后，把返回的用户信息插入游戏平台
        $username = isset($request->username) ? $request->username : '';
        $password = isset($request->password) ? $request->password : '';

        // 正则验证手机号
        if (!preg_match("/^1[34578]\d{9}$/", $username)) {
            return json(['error' => 1, 'msg' => '手机号格式错误']);
        }


        // 判断手机验证码是否输入正确
        if ($request->mobile_code != session('mobile_code')) {
            $data = ['error' => 1, 'msg' => '验证码输入有误'];
            return json($data);
        }


        $url = config('api') . "register?username=$username&password=$password";
        $result = file_get_contents($url);

        $obj = json_decode($result);
        if ($obj->error) {
            echo $result;
            die;
        }
        // 插入游戏平台用户资产表， 写入session，跳转到用户中心
        Db::table('user_asset')
            ->insert(['uid' => $obj->data->userid]);

        session('uid', $obj->data->userid);

        $this->success('注册成功', 'User/ucenter');
    }

    // 实名认证页面
    public function id_check_page(){
        return view("user/id_check_page", []);
    }
    // 实名认证
    public function upload(){

        $uid = \session("uid");

        // 获取表单上传文件
        $files = request()->file('image');
        $imgs = [];
        foreach($files as $file){
            // 移动到框架应用根目录/public/uploads/ 目录下
            $info = $file->move(ROOT_PATH . '/public/' . 'uploads');
            if($info){
                // 成功上传后 获取上传信息
                // 输出 jpg
//                echo $info->getExtension();
                // 输出 42a79759f284b767dfcb2a0197904287.jpg
                $imgs[] = $info->getSaveName();
            }else{
                // 上传失败获取错误信息
                echo $file->getError();
            }
        }
        // 上传图片到服务器，并更改用户实名认证状态为1
        Db::table('user_asset')
            ->where("uid", "=", $uid)
            ->update([
                'imgs' => implode(",", $imgs),
                'id_check' => 1
            ]);

        return json(['error' => 1, 'msg' => "提交成功！"]);
    }


    // 退出
    public function logout()
    {
        session(null);
        $this->success('退出成功', 'User/loginIndex');
    }

    // 检查用户是否已存在资产表
    public function isExistInUserAsset($uid = 0)
    {
        if (!$uid) {
            $this->error("缺少必要信息！");
        }

        $result = Db::table("user_asset")
            ->where("uid", "=", $uid)
            ->count();

        if (!$result) {
            return false;
        }

        return true;
    }

    // 修改密码
    public function changePwd()
    {
        echo "changePwd";
    }


    // 投注页面
    public function userCrap()
    {
        UserCheck::checkLogin();
        $data = [];
        return view("user/user_crap", $data);
    }

    // 投注 (期数，投注时间，投注钱数)
    public function doCrap(Request $request)
    {
        UserCheck::checkLogin();
        // 1. 查询开始时间，结束时间
//        $jounal_id = 1;
//        $crap_types = ['single', 'double', 'big', 'small', 'big_single', 'big_double', 'small_double', 'small_single'];
//        $key = rand(0, count($crap_types) - 1);
//        $crap_type = $crap_types[$key];
//        $crap_money = rand(100, 1000);
        $jounal_id = intval($request->jounal_id); // 期数id
        $crap_money = $request->crap_money; // 投注钱数
        $crap_type = trim($request->crap_type);
        $crap_time = crapTimeIsAllowed(time(), $jounal_id) ? time() : 0; // 要核实当前时间是否处于最后5秒
        $user_id = \session("uid");
        if (!$jounal_id || !$crap_money || !$crap_time || !$user_id) {
            return json(['error' => 1, 'msg' => '缺少必要参数']);
        }

        //入库
        $data = ['jid' => $jounal_id, 'crap_money' => $crap_money, 'crap_time' => $crap_time, 'crap_type' => $crap_type, 'uid' => $user_id];
        $crap_id = DB::table('crap')->insert($data);

        // 扣除用户账户钱数 @todo
        $this->userBalanceOperate(-$crap_money, "lottery");

        return json(['error' => 0, 'msg' => '投注成功！']);
    }

    // 用户的投注记录
    public function userCrapHistory()
    {
        UserCheck::checkLogin();
        $uid = \session("uid");
        $sql = "SELECT
            C.uid, C.crap_money, C.jid,  B.bonus, J.stime journal_stime, J.lottery_number
        FROM
            crap C,
            bonus B,
            journal J
        WHERE
            C.jid = B.jid
        and C.uid = B.uid
        AND J.id = C.jid
            and C.uid='$uid'";

        $rows = Db::query($sql);

        return json(['error' => 0, 'data' => ['list' => $rows]]);
    }

    // 用户的余额操作 增 + 减 -
    public function userBalanceOperate($money, $operate_type = 'admin')
    {
        $uid = \session('uid');

        // 更新用户余额
        $sql = "update user_asset set balance=balance+$money where uid={$uid}";
        Db::query($sql);
        // 插入订单
        Db::table('order')
            ->insert(['operate_type' => $operate_type, 'note' => "", 'create_time' => time(),
                'money' => $money, 'uid' => $uid]);
    }

}