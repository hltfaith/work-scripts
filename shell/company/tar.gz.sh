#!/bin/bash
# shell脚本 把logs 目录下的每个文件夹 里面的文件都压缩
path=/corelogs/card_center/logs
folderlist=`ls $path|grep -v '^$'`

for i in $folderlist
do
cd $path/$i
filelist=`ls|grep -v '^$'`
for k in $filelist
do
zip -q -r $k.zip $k
done
done

