<?php
namespace app\demo\controller;

class Index
{
    public function index($name = 'haha')
    {
    	return 'hello' . $name;
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
