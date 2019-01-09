<?php
namespace app\demo\controller;
use think\Controller;

class Index extends Controller
{
    public function index($name = 'haha')
    {
    	$this->assign('name', $name);
    	return $this->fetch();
    }

    public function test(){
		return 'test func';
    }

    protected function hello2(){
		return 'protected func';
    }

    private function hello3(){

    }
}
