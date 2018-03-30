value=`ps -ef | grep root.sh | awk -F ' ' '{print $2}' | awk 'NR==1'`
value1=`ps -ef |grep root.sh | awk -F ' ' '{print $2}' | wc -l`
while true
do

	if [ $value1>=2 ]
	then
		kill -9 $value
		break
	fi
done
