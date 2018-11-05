#!/bin/bash

# install git
yum install git

# create user or group
groupadd git
adduser git -g git
passwd git

# 初始化Git仓库
cd /usr/local
mkdir git
chown git:git git/
cd git
git init --bare project.git
chown -R git:git project.git

# 禁止git用户shell登录
vim /etc/passwd
#修改git的bash 从/bin/bash改为/usr/bin/git-shell
# /sbin/nologin

# 克隆仓库
git clone git@192.168.33.10:/usr/local/git/project.git #可能需要输入git用户密码
git clone root@192.168.33.10:/usr/local/git/project.git #此时输入root密码
