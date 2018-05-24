#!/bin/bash

#start time
echo -e "\n开始备份时间 --- $(date +"%c")" >> /image/bin/ftp_backup.log

#kill server process
easyscan_pid=`ps -ef  | grep startup-easyscan.sh | grep -v "grep startup-easyscan.sh" | awk -F ' ' '{print $2}'`
workflow_pid=`ps -ef | grep startup-workflow.sh | grep -v "grep startup-workflow.sh" | awk -F ' ' '{print $2}'`
kill -9 $easyscan_pid
kill -9 $workflow_pid
echo "easyscan, workflow服务已关闭!" >> /image/bin/ftp_backup.log

#upload log file
easyscan_row=`ps -ef | grep startup-easyscan.sh | wc -l`
workflow_row=`ps -ef | grep startup-workflow.sh | wc -l`

if [ $easyscan_row -eq 1 -a $workflow_row -eq 1 ]
then
        cd /image/logs
        echo "日志开始打包...." >> /image/bin/ftp_backup.log
        tar zcf expall_wfl_$(date +"%y%m%d%H%M").tar.gz image_err.log image_err.log.2018-05-23 prd_easyscan.out prd_workflow.out workflow.error.log workflow.info.log workflow.quartz.log workflow.wf.log
    
echo "tar包开始上传FTP...." >> /image/bin/ftp_backup.log
ftp -n <<!
        open 172.16.6.105
        user log log
        cd workflow
        binary
        prompt
        mput *.tar.gz
        bye
!
        
fi

# remove log file
echo > /image/bin/backup_values.log
ftp -n <<! >> /image/bin/backup_values.log
          open 172.16.6.105
          user log log
          cd workflow
          dir
          bye
!

xing=*
ftpfile_size_value=`cat /image/bin/backup_values.log | grep $(date +"%y%m%d")$xing.tar.gz | awk -F ' ' '{print $5}' | awk 'NR==1'`
localfile_size_value=`ls -l /image/logs/*.tar.gz | grep $(date +"%y%m%d")$xing.tar.gz | awk -F ' ' '{print $5}' | awk 'NR==1'`
backup_file_length=`cat /image/bin/backup_values.log | grep expall_wfl_$(date +"%y%m%d")$xing.tar.gz | wc -l`
if [ $backup_file_length -ge 1 -a $localfile_size_value -eq $ftpfile_size_value ]
then
        echo "上传FTP成功,文件大小检测完整!" >>/image/bin/ftp_backup.log
        echo "backup success!" >> /image/bin/ftp_backup.log
        cd /image/logs
        rm -rf  *.tar.gz
else
        echo "上传FTP,文件大小检测不完整!" >>/image/bin/ftp_backup.log
        echo "backup fail!" >> /image/bin/ftp_backup.log
        #upload_file
        cd /image/logs
        rm -rf  *.tar.gz
fi

#start server
echo "easyscan, workflow服务已启动!" >> /image/bin/ftp_backup.log
nohup bash /image/bin/startup-easyscan.sh 2>&1 &
nohup bash /image/bin/startup-workflow.sh 2>&1 &

#end time
echo 结束备份时间 --- $(date +"%c") >> /image/bin/ftp_backup.log
