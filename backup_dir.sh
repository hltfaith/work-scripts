#!/bin/bash
# author: changhao
## 留存前五天数据文件，其余文件备份至FTP(172.16.6.105) /dianpiao/ECDS

cd /weblogic/user_projects/domains/base_domain/workflow/ECDS
getdir=`ls -l /weblogic/user_projects/domains/base_domain/workflow/ECDS/ | awk '/^d/ {print $NF}' | grep -v $(date +%Y-%m-%d --date='4 days ago') | grep -v $(date +%Y-%m-%d --date='3 days ago') | grep -v $(date +%Y-%m-%d --date='2 days ago') | grep -v $(date +%Y-%m-%d --date='1 days ago') | grep -v $(date +%Y-%m-%d --date='0 days ago')`
tar zcvf $getdir.tar.gz $getdir/*

ftp -n<<!
		open 172.16.6.105
		user log log 
		cd dianpiao/ECDS
		binary
		prompt
		mput *.tar.gz
		bye
!

rm -rf $getdir.tar.gz
rm -rf $getdir
