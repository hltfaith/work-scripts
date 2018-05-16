#!/bin/bash

#kill server process
function close_server(){
	startupeasyscan=`ps -ef | grep startup-easyscan.sh | wc -l`
	startupworkflow=`ps -ef | grep startup-easyscan.sh | wc -l`
	if [ $startupeasyscan -ge 2 ]
	then
		value=`ps -ef  | grep startup-easyscan.sh | awk -F ' ' '{print $2}' | awk 'NR==1'`
		kill -9 $value
	fi

	if [ $startupworkflow -ge 2 ]
	then
		value1=`ps -ef | grep startup-workflow.sh | awk -F ' ' '{print $2}' | awk 'NR==1'`
		kill -9 $value1
	fi
}

#upload log file
function upload_file(){
	startupeasyscan=`ps -ef | grep startup-easyscan.sh | wc -l`
	startupworkflow=`ps -ef | grep startup-easyscan.sh | wc -l`

	if [ $startupeasyscan -eq 1 -a $startupworkflow -eq 1 ]
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

	touch /image/bin/backup_values.log
	ftp -n <<- EOF >> /image/bin/backup_values.log
		open 172.16.6.105
		user database database
		cd zj
		dir
		bye
	EOF

	xing=*
	ftpfile_size_value=`cat backup_values.log | grep $(date +"%y%m%d")$xing.tar.gz | awk -F ' ' '{print $5}' | awk 'NR==1'`
	localfile_size_value=`ls -l /image/logs/*.tar.gz | grep $(date +"%y%m%d")$xing.tar.gz | awk -F ' ' '{print $5}' | awk 'NR==1'`
	backup_file_length=`cat /image/bin/backup_values.log | grep expall_wfl_$(date +"%y%m%d")$xing.tar.gz | wc -l`
	
	if [ $backup_file_length -ge 1 -a $localfile_size_value -eq $ftpfile_size_value ]
	then
		cd /image/logs
		rm -rf  *.tar.gz *.log
		rm -rf /image/bin/backup_values.log
	else
		upload_file
		cd /image/logs
		rm -rf  *.tar.gz
		rm -rf /image/bin/backup_values.log
	fi
}

#start server
function start_server(){
	bash /image/bin/startup-easyscan.sh &
	bash /image/bin/startup-workflow.sh &
}

close_server
upload_file
remove_log
start_server

#10 0 * * * /bin/bash /image/bin/backup_ftp.sh
