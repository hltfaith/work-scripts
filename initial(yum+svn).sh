#!/bin/bash

scp root@$1:/etc/yum.repos.d/163-65.repo /etc/yum.repos.d/
scp root@$1:/etc/yum.repos.d/base6-5.repo /etc/yum.repos.d/
scp root@$1:/etc/yum.repos.d/ustc-6epel.repo /etc/yum.repos.d/

yum list
yum repolist
yum1=`yum list | grep subversion.x86_64 | awk '{print $1}'`
yum2="subversion.x86_64"
	if [ $yum1 = $yum2 ];
	then
		yum install -y subversion
		mkdir /svndata/
		svn checkout svn://172.16.79.2 /svndata/ --username=svnuser --password=Test
		echo "SVN configure install OK!"
		
	else
		echo "yum configure in error!"
		
	fi
