function ip_resolu(){
	i=1
	while true
	do
			ping linuxch.cn -c 1 > /dev/null 2>&1
			if [ $? -ne 0 ];then
					echo "Unable to obtain DNS!!!!$i"       
					i=`expr $i + 1`
					sleep 10
					continue
			else
					echo " success !!!"
					exit
			fi
	done
}

function main(){
	ip_resolu
}
main
