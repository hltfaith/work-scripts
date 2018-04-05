#!/bin/bash

dir_asmcmd_file='/root/shell/asmcmd_file.txt'
arch_free=`cat $dir_asmcmd_file | head -n 2 | tail -n 1 | awk '{ print $(NF-5) }'`
crs_free=`cat $dir_asmcmd_file | head -n 3 | tail -n 1 | awk '{ print $(NF-5) }'`
data_free=`cat $dir_asmcmd_file | head -n 4 | tail -n 1 | awk '{ print $(NF-5) }'`
data01_free=`cat $dir_asmcmd_file | head -n 5 | tail -n 1 | awk '{ print $(NF-5) }'`

arch_sum=`cat $dir_asmcmd_file | head -n 2 | tail -n 1 | awk '{ print $(NF-6) }'`
crs_sum=`cat $dir_asmcmd_file | head -n 3 | tail -n 1 | awk '{ print $(NF-6) }'`
data_sum=`cat $dir_asmcmd_file | head -n 4 | tail -n 1 | awk '{ print $(NF-6) }'`
data01_sum=`cat $dir_asmcmd_file | head -n 5 | tail -n 1 | awk '{ print $(NF-6) }'`

dir_arch=`cat $dir_asmcmd_file | head -n 2 | tail -n 1 | awk '{ print $(NF) }'`
dir_crs=`cat $dir_asmcmd_file | head -n 3 | tail -n 1 | awk '{ print $(NF) }'`
dir_data=`cat $dir_asmcmd_file | head -n 4 | tail -n 1 | awk '{ print $(NF) }'`
dir_data01=`cat $dir_asmcmd_file | head -n 5 | tail -n 1 | awk '{ print $(NF) }'`

readfile(){

	su - grid
	asmcmd <<- EOF >> /root/shell/asmcmd_file.txt
	lsdg
	exit
	EOF
	
    if [ $? != 0 ];then
        echo -e "\033[41;37m采集asmcmd数据异常错误！！！！\033[0m"
        exit
    fi
    su - oracle

}

warning(){

	current_time=`date +%Y/%m/%d" "%H:%M`
	echo -e "$current_time    磁盘空间剩余不足！！!" > /home/oracle/asmcmd_mail.txt
	printf "%-15s %-10s %-10s\n" 挂载目录    总计MB    剩余MB >> /home/oracle/asmcmd_mail.txt 
	printf "%-10s %-8s %-10s\n" $dir_arch $arch_sum $arch_free >> /home/oracle/asmcmd_mail.txt
	printf "%-10s %-8s %-10s\n" $dir_crs $crs_sum $crs_free >> /home/oracle/asmcmd_mail.txt
	printf "%-10s %-8s %-10s\n" $dir_data $data_sum $data_free >> /home/oracle/asmcmd_mail.txt
	printf "%-10s %-8s %-10s\n" $dir_data01 $data01_sum $data01_free >> /home/oracle/asmcmd_mail.txt
	mail_info=`cat /home/oracle/asmcmd_mail.txt`
	echo "$mail_info" | mail -s "asmcmd磁盘容量报警" wu_chang_hao@qq.com
	sleep 15
	rm -rf /home/oracle/asmcmd_mail.txt

}

monitor(){
	while true
	do

	    if [ 200 -le $arch_free -o 200 -le $crs_free -o 200 -le $data_free -o 200 -le $data01_free ];then
	        warning
	        sleep 30
	        main
	    else
	    	sleep 30
	    	main
	    fi

	done
}

main(){
	readfile
	monitor
}

main
