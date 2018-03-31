#!/bin/bash
ip_num=`last | head | grep 'still logged in' | awk '{ print $3 }'`

allow_ip_list=()
allow_ip_list[0]=172.16.78.114
allow_ip_list[1]=172.16.78.115
current_ip_list=();
count=0
for i in $ip_num;do
        current_ip_list[count]=$i
        count=`expr $count + 1`
done

for k in ${current_ip_list[@]};do
       count1=0
        for v in ${allow_ip_list[@]};do
                count1=`expr $count1 + 1`
                if [ $k = $v ]; then
                        echo "local ip:$v" | mail -s "Trust -- ssh login zhjy vpn server" 2083969687@qq.com
                        exit
                else
                        if [ $count1 -ge ${#allow_ip_list[@]} ];then
                                echo "outisde ip:$k" | mail -s "**Distrust** -- ssh login zhjy vpn server" 2083969687@qq.com
                        else
                                continue
                        fi
                fi

        done

done
