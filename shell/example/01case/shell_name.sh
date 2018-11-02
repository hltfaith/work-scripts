#!/bin/bash
#
##   date: 2018.11.02
##   info: Shell中$#,$@,$0,$1,$2,$*,$$,$?各种dollar开头的变量含义
## author: changhao
#

echo "number:$#"
echo "scname:$0"
echo "first :$1"
echo "second:$2"
echo "argume:$@"
echo "show parm list:$*"
echo "show process id:$$"
echo "show precomm stat: $?"

<<COMMENT
	$# 是传给脚本的参数个数
	$0 是脚本本身的名字
	$1 是传递给该shell脚本的第一个参数
	$2 是传递给该shell脚本的第二个参数
	$@ 是传给脚本的所有参数的列表（与$#相同，但是使用时加引号，并在引号中返回每个参数）
	$! 后台运行的最后一个进程的ID号
	$- 显示shell使用的当前选项。 
	$* 是以一个单字符串显示所有向脚本传递的参数，与位置变量不同，参数可超过9个
	$$ 是脚本运行的当前进程ID号
	$? 是显示最后命令的退出状态，0表示没有错误，其他表示有错误
COMMENT
