#!/bin/bash

# 并行代码
# 使用'&'+wait 实现“多进程”实现
date
for i in `seq 1 5`
do
{
    echo "sleep 5"
    sleep 5
} &
done
wait  ##等待所有子后台进程结束
date
