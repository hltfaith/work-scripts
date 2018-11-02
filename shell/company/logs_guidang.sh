#!/bin/bash
## info: upload logfile to ftpserver 172.16.6.105:/data/wxlog/
## cron 每天1点执行

## /opt/logs/public 日志上传FTP
cd /opt/logs/public
public_dir=`ls /opt/logs/public | grep $(date +%Y)`

if [ "$public_dir" != "" ]
then
		tar zcvf permission.$(date +%Y-%m-%d --date='1 days ago').tar.gz $public_dir
ftp -n <<!
open 172.16.6.105
user database database
cd wxlog/public
binary
prompt
mput *.tar.gz
bye
!
        rm -rf $public_dir
        rm -rf *.tar.gz
fi

## /opt/logs/zuul 日志上传FTP
cd /opt/logs/zuul
zuul_dir=`ls /opt/logs/zuul | grep $(date +%Y)`

if [ "$zuul_dir" != "" ]
then
	tar zcvf zuul.$(date +%Y-%m-%d --date='1 days ago').tar.gz $zuul_dir
ftp -n <<!
open 172.16.6.105
user database database
cd wxlog/zuul
binary
prompt
mput *.tar.gz
bye
!
        rm -rf $zuul_dir
        rm -rf *.tar.gz
fi

## catalina.out 日志文件上传FTP
cd /opt/server/apache-tomcat-public/logs
tar zcvf catalina.$(date +%Y-%m-%d --date='1 days ago').tar.gz catalina.out

ftp -n <<!
open 172.16.6.105
user database database
cd wxlog/catalina
binary
prompt
mput *.tar.gz
bye
!

rm -rf *.tar.gz
>catalina.out
