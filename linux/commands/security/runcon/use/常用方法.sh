
# runcon 使用特定的context来执行指令
runcon -t user_home_t cat /etc/passwd

"root:system_r:user_home_t:SystemLow-SystemHigh is not a valid context"

# 看看svirt_lxc_net_t的进程是否有权限
runcon -u system_u -r system_r -t svirt_lxc_net_t -l s0:c125,c512 /bin/bash
"bash: /home/admin/.bashrc: Permission denied "

bash-4.2$ ls
" ls: cannot open directory .: Permission denied "

bash-4.2$ ps -Z
" system_u:system_r:svirt_lxc_net_t:s0:c125,c512 23686 pts/0 00:00:00 bash
system_u:system_r:svirt_lxc_net_t:s0:c125,c512 23722 pts/0 00:00:00 ps "


