#!/bin/bash
__version__="1.0"
__author__="wu_chang_hao@qq.com"
__wxgzh__="公众号: 帽儿山的枪手"
__blog__="http://blog.changhao.tech"

DL=https://studygolang.com/dl/golang/
separation="#"

function is_exist_golang()
{
	if test $(command -v go | wc -l) -eq 0 ; then
		return 0
	fi
	echo ">>> 当前环境中已存在 golang <<<"
	echo -n "版本: " && go version
	read -p "是否要移除(y/N)" option
	if test $option = "y" ; then
		rm -rf $(go env GOROOT)
		return 0
	fi
	echo "退出golang安装"
	exit 0
}

function set_title(){
 	title=""
	column_count=0
	for column in "$@"
	do
		title+="|${column}${separation}"
		let column_count++
	done
	title+="|\n"
}

function set_segmentation(){
	seg=""
	for i in $(seq ${column_count})
	do
		seg+="+${separation}"
	done
	seg+="+\n"
}

# set content
function set_content(){
	content=""
	for i in $@
	do
		content+=`set_line ${i//","/" "}`
	done
}

# set line
function set_line(){
	local line=""
	for i in $@
	do
		line+="|${i}${separation}"
	done
	line+="|\n"
	echo ${line}
}

function output_table() {
	set_title "Go版本号"
	set_segmentation
	set_content "1.18.3" "1.17.10" "1.16.15"
	table=${seg}${title}${seg}${content}${seg}
	echo -e ${table}|column -s "${separation}" -t|awk '{if($0 ~ /^+/){gsub(" ","-",$0);print $0}else{gsub("\\(\\*\\)","\033[31m(*)\033[0m",$0);print $0}}'
}

function deploy_golang()
{
	output_table
	read -p "请输入版本号: " version
	package=go${version}.linux-amd64.tar.gz
	package_path=/usr/local/$package
	wget -P /usr/local ${DL}$package
	tar zxf ${package_path} -C /usr/local
	ln -s /usr/local/go/bin/go /usr/bin/go
	rm -rf $package_path 
}

function config_env_golang()
{
	go env -w GOPROXY="https://goproxy.cn,direct" 
}

# start install
is_exist_golang
deploy_golang
config_env_golang

# result log
echo ">>> golang 安装完成 <<<"
echo "当前版本: $(go version)"
echo "go 安装路径: $(go env GOROOT)"
echo "go 代理源地址: $(go env GOPROXY)"
