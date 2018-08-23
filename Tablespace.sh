#!/bin/bash

sum_capacity=247179
warting_capacity=245131

readfile(){

	rm -rf /home/db/oracle/table_capacity.txt

	sqlplus petl/petl <<- EOF >> /home/db/oracle/table_capacity.txt
	col FILE_NAME format a50
	select FILE_NAME,
       bytes / 1024 / 1024  as Total_M,
       (select sum(bytes) / 1024 / 1024
          from dba_free_space d
         where d.file_id = s.file_id
         group by file_id)  as Free_M
  	from dba_data_files s
 	where s.tablespace_name = 'TBS_RPT';
	exit
	EOF
	
    if [ $? != 0 ];then
        echo -e "\033[41;37m采集数据异常错误！！！！\033[0m"
        exit
    fi

    sed -i "1, 14d" /home/db/oracle/table_capacity.txt
    sed -i "9, 14d" /home/db/oracle/table_capacity.txt

}

monitor(){

	current_capacity=`cat /home/db/oracle/table_capacity.txt | awk '{ print $2 }' | awk '{ sum+=$1 } END { print sum }'`
	use_capacity=`tail -n 1 /home/db/oracle/table_capacity.txt | awk '{ print $3 }'`
	cha=`expr $current_capacity - $use_capacity`
	free_capacity=`expr $sum_capacity - $cha`
	current_time=`date +%Y/%m/%d" "%H:%M`
	
	if [ $cha -ge $warting_capacity ];then
		echo "$current_time   TBS_RPT表空间容量剩余不足 2G ！！!  当前使用容量：`expr $cha / 1024` G, 剩余容量：`expr $free_capacity / 1024` G"
	else
		echo "$current_time   TBS_RPT表空间容量正常，当前使用容量：`expr $cha / 1024` G, 剩余容量：`expr $free_capacity / 1024` G" >> /home/db/oracle/table_capacity.log
	fi

}

run_server(){

	while true
	do
		readfile
		monitor
		sleep 60
	done
	
}

run_server
