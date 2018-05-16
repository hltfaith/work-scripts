#!/bin/bash

startupeasyscan=`ps -ef | grep startup-easyscan.sh | wc -l`
startupworkflow=`ps -ef | grep startup-easyscan.sh | wc -l`

#kill server process
function close_server(){

	if [ $startupeasyscan>=2 ]
	then
		value=`ps -ef  | grep startup-easyscan.sh | awk -F ' ' '{print $2}' | awk 'NR==1'`
		kill -9 $value
	fi

	if [ $startupworkflow>=2 ]
	then
		value1=`ps -ef | grep startup-workflow.sh | awk -F ' ' '{print $2}' | awk 'NR==1'`
		kill -9 $value1
	fi
}

#upload log file
function upload_file(){

	if [ $startupeasyscan -eq 1 && $startupworkflow -eq 1]
	then
		cd /image/logs
		tar zcf expall_wfl_$(date +"%y%m%d%k%M").tar.gz *
		sleep 5

		ftp -n<<!
		open 172.16.6.105
		user database database 
		cd zj
		binary
		prompt
		mput *.tar.gz
		bye
		!
		sleep 5
	fi
}

# remove log file
function remove_log(){

	touch /root/script/backup_values.log
	ftp -n <<- EOF >> /root/script/backup_values.log
		open 172.16.6.105
		user database database
		cd zj
		dir
		bye
	EOF

	xing=*
	backup_values=`cat /root/script/backup_values.log | grep expall_wfl_$(date +"%y%m%d")$xing.tar.gz | wc -l`
	if [ $backup_values -ge 1 ]
	then
		cd /image/logs
		rm -rf  *.tar.gz
		rm -rf /root/script/backup_values.log

	else
		upload_file
		cd /image/logs
		rm -rf  *.tar.gz
		rm -rf /root/script/backup_values.log
	fi
}

#start server
function start_server(){
	bash /image/bin/startup-easyscan.sh
	bash /image/bin/startup-workflow.sh
}

close_server
upload_file
remove_log
start_server

#10 0 * * * /bin/bash /root/script/backup_ftp.sh
