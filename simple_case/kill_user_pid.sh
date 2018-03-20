#!/bin/bash
read -p "input your username " user
ps aux | grep "^$user" | awk '{print $2}' >/opt/killuser   #查找某个用户的进程，提取进程号
DAT=`cat /opt/killuser`
for i in $DAT    #将进程赋予变量DAY
do
kill -9 $i &>/dev/null   #将进程号对应的pid杀死
done
rm -rf /opt/killuser
