#!/bin/bash
#
#在多机集群环境中，经常面临修改配置文件后拷贝到多台服务器的情况，传统的执行scp比较麻烦，所以写了以下shell脚本，可以将指定文件拷贝到多台机器。

 help()
 {
  cat << HELP
    --------------HELP------------------------
    This shell script can copy file to many computers.
    Useage:
        copytoall filename(full path form /home) targetpathfrom/ username ip1 ip2 ip3....
    Example:
        copytoall /home/casliyang/Hadoop-2.2.0/etc/hadoop/core-site.xml /home/casliyang/hadoop-2.2.0/etc/hadoop/ casliyang 192.168.0.5 192.168.0.6 192.168.0.7 192.168.0.8
    ------------------------------------------
 HELP
  exit 0
 }
 
 currentdate=$(date +%Y-%m)
 
 echo $currentdate " execute copytoall"
 
 if [ $1 = "-h" ] ; then
    help
    exit 0
 fi
 
 file=$1
 shift
 targetpath=$1
 shift
 user=$1
 shift
 tempip=0
 
 if [ -f $file ] ; then
    while [ $# -gt 0 ] ; do
        tempip=$1
        shift
        scp $file ${user}@${tempip}:${targetpath}
    done
 
else
 
    echo "wrong file!"
 
    exit 0
 fi
