#!/bin/bash
#  
# createtime: 2019.02.24 
# latelytime: 2019.02.26 11:14 
#   lasttime: 2019.02.27 11:02 
#    version: v1.1.3
#     author: changhao
#

# check env
function check_env()
{
    ##
    ## SElinux 安装环境检测
    ##

    # 检查当前用户
    if [ ! `id -u` -eq 0 ]
    then
        printf "\e[31m 请使用root用户!!! \e[0m \n"
        exit 0
    fi

    # 检查SE强防状态
    if [ `getenforce` == "enforcing" ]
    then
        printf "\e[31m 请关闭强防策略!!! \e[0m \n"
        exit 0
    fi

    # 检查白名单状态
    #if [ `` ]
    #then
  
    #fi 

    # 检查系统当前策略版本号
    if [ `rpm -qa | grep selinux-policy | wc -l` -eq 3 ] 
    then

        if [ `rpm -qa | grep selinux-policy | sed -n '1p'  | cut -d '.' -f 5` -eq `rpm -qa | grep selinux-policy | sed -n '2p'  | cut -d '.' -f 5` ]
        then
	    printf "\n"
            printf "***************************************************\n"    
            printf "*              当前版本策略：`rpm -qa | grep selinux-policy | sed -n '1p'  | cut -d '.' -f 5`                  *\n"
            printf "***************************************************\n\n"    
        else
            printf "\e[31m 请检查当前系统策略包版本号不一致!!! \e[0m \n"
            exit 0
        fi

    else
        printf "\e[31m 请检查策略包数量有异常!!! \e[0m \n"
        exit 0
    fi  

    # 检查需要安装的SE强防策略包

    # 循环当前目录所有SE强防策略包
    array_num=()
    count=1

    for i in `ls | grep rpm | grep selinux-policy | cut -d '.' -f 5`
    do
        array_num[$count]=$i
        count=$count+1
    done

    # SE Package 数量, awk列转行
    se_num=`echo ${array_num[*]} | sed 's/ /\n/g' | sort | uniq | awk '{for(i=0;++i<=NF;)a[i]=a[i]?a[i] FS $i:$i}END{for(i=0;i++<NF;)print a[i]}'`

    # 检查需要安装的SE强防策略包
    if [ `ls | grep rpm | grep selinux-policy | wc -l` -eq 3 ]
    then
        while :
        do
	    printf "当前目录SE策略包 $se_num  \n"
            read -p "是否要安装此策略! 安装(y)/退出(q)>: " choice
	    if [ "$choice" == "" ]
            then
		install $se_num

            elif [ $choice == "q" ]
            then
                exit 0

	    elif [ $choice == 'y' ]
	    then
		install $se_num

            else
                printf "\e[31m 无效字符请重新输入!!! \e[0m \n"

            fi

        done

    elif [ `ls | grep rpm | grep selinux-policy | wc -l` -lt 3 ]
    then
        printf "\e[31m 请检查当前目录强防策略包数量完整性!!! \e[0m \n"
        exit 0

    else

        printf "当前目录有如下策略包: $se_num \n"
        while :
        do
            read -p "请输入安装策略包版本号 (q退出)>: " choice
            if [ "$choice" == "" ]
            then
                printf "\e[31m 无效字符请重新输入!!! \e[0m \n"

            elif [ $choice == "q" ]
            then
                exit 0

            else
                if [ ! -n "`echo $choice | sed 's/[0-9]//g'`" ]
                then
                    if [ $choice -lt 100 ]
                    then
                        printf "\e[31m 当前目录下没有此策略包!!! \e[0m \n"

                    elif [ `ls | grep rpm | grep selinux-policy | grep $choice | wc -l` -ge 3 ]
                    then
                        install $choice
                    else
                        printf "\e[31m 当前目录下没有此策略包!!! \e[0m \n"
                    fi

                else
                    printf "\e[31m 请输入数字类型字符!!! \e[0m \n"

                fi

            fi

        done

    fi

}

function install()
{
    #rpm -Uvh $(ls | grep rpm | grep selinux-policy | grep $1) --nodeps --force
	
    if [ `echo $?` -eq 0 ]
    then
    	printf "\n"
    	printf "\n"
	printf "SE策略包安装成功!\n"
	printf "#########################\n"
	printf " 
    1. 重启打标签
    2. 重启不打标签
    3. 退出稍后重启
		\n"
	printf "#########################\n"

	while :
	do
	    read -p "请输入序号(默认重启打标Enter)>: " choice	

	    if [[ "$choice" == "" || $choice == "1" ]]
	    then
	   	echo "reboot & 重启打标签"	
		# reboot
		exit 0

	    elif [ $choice == "2" ]
	    then
		# rm -rf /.autorelabel
		# reboot
		echo "重启不打标签"

	    elif [ $choice == "3" ]
	    then
		exit 0		

	    else
	        printf "\e[31m 无效字符请重新输入!!! \e[0m \n"
	    fi
	done
    fi
}

function selinux()
{
	##
	## SELinux audit 日志分析
	## 1. 自动生成te文件，并编译成pp
	## 2. 分析audit log 输出关键日志
	## 3. 
	##
	
	echo ""
}

function tools()
{
	echo "tools function"
}

function run()
{
        check_env
}

function help()
{
    echo ""
}

run

