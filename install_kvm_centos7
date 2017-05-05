#!/bin/bash

kvm=`lsmod | grep kvm`
libvirt=`systemctl status libvirtd | grep active |awk '{print $2}'`
libvirt1=`service libvirtd status | grep active |awk '{print $2}'`
qemu=`rpm -qa | grep qemu`
virtmanager=`rpm -qa | grep virt-manager`

if [ -z "$kvm" ]
then
	if [ -z "$kvm" ] && [ -z "$qemu" ] && [ -z "$virtmanager" ]
	then
		yum install -y qemu-kvm virt-manager libvirt* 
		service libvirtd start
		if [ $libvirt1 == active ]
		then
			if [ -f /usr/libexec/qemu-kvm ]
			then
				if [ -z "$virtmanager" ]
				then
					yum install -y virt-manager
					if [ -z "$virtmanager" ] 
        				then
                				echo "virt-manager install error"
        				else
                				echo "qemu-kvm,virt-manager,libvirt install success!"
        				fi
				
				else
                				echo "qemu-kvm,virt-manager,libvirt install success!"
				fi
			else
				echo "qemu install error!!!"
				
			fi
		
			echo "qemu-kvm,virt-manager,libvirt install success!"
		else
			echo "libvirt up server error!"
		fi
	else
		echo "kvm,qemu,virtmanager installed....error"
	fi
else
	
	if [ $libvirt == active ]
	then
		if [ -z "$qemu" ]
		then
			yum install -y qemu-kvm
			
			if [ $libvirt1 == active ] && [ -f /usr/libexec/qemu-kvm ] 
        		then
				if [ -z "$virtmanager" ]
				then
					yum install -y virt-manager
					if [ -z "$virtmanager" ] 
        				then
                				echo "virt-manager install error"
        				else
                				echo "qemu-kvm,virt-manager,libvirt install success!"
        				fi
				
				else
                				echo "qemu-kvm,virt-manager,libvirt install success!"
				fi
				
        		else
                		echo "qemu-kvm,libvirt install error!"
        		fi
		  else	
			if [ -f /usr/libexec/qemu-kvm ]
			then
				if [ -z "$virtmanager" ]
				then
					yum install -y virt-manager
					if [ -z "$virtmanager" ] 
        				then
                				echo "virt-manager install error"
        				else
                				echo "qemu-kvm,virt-manager,libvirt install success!"
        				fi
				
				else
                				echo "qemu-kvm,virt-manager,libvirt install success!"
				fi
				
			else
				if [ -z "$virtmanager" ]
				then
					yum install -y virt-manager
					if [ -z "$virtmanager" ] 
        				then
                				echo "virt-manager install error"
        				else
                				echo "qemu-kvm,virt-manager,libvirt install success!"
        				fi
				else
                			echo "qemu-kvm,virt-manager,libvirt install success!"
				fi
				echo "qemu-kvm install error"	
			fi
		     fi
	else
		#systemctl restart libvirtd
		#systemctl start libvirtd
					yum install -y virt-manager libvirt-python python-virtinst libvirt-client virt-install virt-viewer									       
					yum update pygobject3
		if [ $libvirt == active ]
		then
			if [ -z "$qemu" ]
			then
				yum install -y qemu-kvm
					
				if [ -f /usr/libexec/qemu-kvm ] 
        			then
					if [ -z "$virtmanager" ]
					then
						yum install -y virt-manager
						if [ -z "$virtmanager" ] 
        					then
                					echo "virt-manager install error"
        					else
                					echo "qemu-kvm,virt-manager,libvirt install success!"
        					fi
				
					else
                					echo "qemu-kvm,virt-manager,libvirt install success!"
					fi
				
        			else
                			echo "qemu-kvm install error!"
        			fi
			else
				if [ -z "$virtmanager" ]
				then
					yum install -y virt-manager libvirt-python python-virtinst libvirt-client virt-install virt-viewer									       
					yum update pygobject3
					if [ -z "$virtmanager" ] 
       					then
               					echo "virt-manager install error"
       					else
               					echo "qemu-kvm,virt-manager,libvirt install success!"
        				fi
				else
					yum install -y libvirt-python python-virtinst libvirt-client virt-install virt-viewer									       
					yum update pygobject3
                				echo "qemu-kvm,virt-manager,libvirt install success!"
				fi
			fi
		else
			echo "libvirt up server error"
		fi
	fi
fi
