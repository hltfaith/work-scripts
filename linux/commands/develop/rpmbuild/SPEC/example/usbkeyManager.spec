Name:           usbkeyManager
Version:        1.2.221
Release:        1
Summary:        usbkeyManager tools

Group:          Application
License:        GPL
BuildRoot:      %{mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX}

Autoreqprov:	no

#Requires:
Packager:	IdeaBank Development GK 20190221 PM4

%description
This is a usbkeyManager tool for IB Keys rpm package;
fixed:
	1、优化针对PCSCD服务的监控方式；
    2、about界面可能引起的崩溃问题。

		
#

%grep
#%setup -q
#

%build
#

%pre
#rpm安装前执行的脚本
pkill pcscd
if [ $? -eq 0 ]; then
	echo "stop service pcscd....succ"
fi

%install
sh_install="cp -rP"
mkdir -p %{buildroot}/usr/local/lib/
mkdir -p %{buildroot}/opt/IdeaBank/usbkeyManager/
mkdir -p %{buildroot}/etc/udev/rules.d/
mkdir -p %{buildroot}/lib64/
mkdir -p %{buildroot}/etc/reader.conf.d/
$sh_install $RPM_BUILD_DIR/lib/libXXX.so %{buildroot}/lib64/
$sh_install $RPM_BUILD_DIR/lib/libpcsc_IB_key_1.so %{buildroot}/lib64/
$sh_install $RPM_BUILD_DIR/lib/libpcsc_IB_key_2.so %{buildroot}/lib64/
#$sh_install $RPM_BUILD_DIR/config/50_IdeaBank_key2020.rules %{buildroot}/etc/udev/rules.d/
$sh_install $RPM_BUILD_DIR/config/reader.conf %{buildroot}/etc/reader.conf.d/

$sh_install $RPM_BUILD_DIR/usbkeyManager/Qtlib %{buildroot}/opt/IdeaBank/usbkeyManager/
$sh_install $RPM_BUILD_DIR/usbkeyManager/lib %{buildroot}/opt/IdeaBank/usbkeyManager/
$sh_install $RPM_BUILD_DIR/usbkeyManager/bin %{buildroot}/opt/IdeaBank/usbkeyManager/
$sh_install $RPM_BUILD_DIR/usbkeyManager/tools %{buildroot}/opt/IdeaBank/usbkeyManager/
$sh_install $RPM_BUILD_DIR/usbkeyManager/icon %{buildroot}/opt/IdeaBank/usbkeyManager/
$sh_install $RPM_BUILD_DIR/usbkeyManager/doc %{buildroot}/opt/IdeaBank/usbkeyManager/
$sh_install $RPM_BUILD_DIR/usbkeyManager/script %{buildroot}/opt/IdeaBank/usbkeyManager/

mkdir -p %{buildroot}/etc/xdg/autostart
$sh_install $RPM_BUILD_DIR/usbkeyManager/bin/usbkeyManager.desktop %{buildroot}/etc/xdg/autostart/

mkdir -p %{buildroot}/root/Desktop
$sh_install $RPM_BUILD_DIR/usbkeyManager/bin/usbkeyManager.desktop %{buildroot}/root/Desktop/
mkdir -p %{buildroot}/root/桌面
$sh_install $RPM_BUILD_DIR/usbkeyManager/bin/usbkeyManager.desktop %{buildroot}/root/桌面/

mkdir -p %{buildroot}/usr/share/applications
$sh_install $RPM_BUILD_DIR/usbkeyManager/bin/usbkeyManager.desktop %{buildroot}/usr/share/applications/


%clean
rm -rf %{buildroot}

%post
#/opt/IdeaBank/usbkeyManager/bin/uid.sh
chmod 0777 /opt/IdeaBank/usbkeyManager/bin/usbkeyManager.desktop

users=`cat /etc/passwd | awk -F : '/home/ { print $6 }'`
for the_user in $users
do
 if [ -e $the_user/桌面/ ]; then
  cp -P /opt/IdeaBank/usbkeyManager/bin/usbkeyManager.desktop $the_user/桌面/
 elif [ -e $the_user/Desktop/ ]; then
  cp -P /opt/IdeaBank/usbkeyManager/bin/usbkeyManager.desktop $the_user/Desktop/
 elif [ -e $the_user/desktop/ ]; then
  cp -P /opt/IdeaBank/usbkeyManager/bin/usbkeyManager.desktop $the_user/desktop/
 fi
done

ln -s /opt/IdeaBank/usbkeyManager/tools/usbkeyManager /bin/usbkeyManager
ln -s /opt/IdeaBank/usbkeyManager/tools/IB_PCSC_Deamon /bin/IB_PCSC_Deamon
#mv /usr/local/lib/libpcsc-key.so /usr/lib64
#mv /etc/reader.conf.d/50_IdeaBank_key2020.rules /etc/udev/rules.d/

chmod 0777 /opt/IdeaBank/usbkeyManager/tools/*
chmod 0777 /opt/IdeaBank/usbkeyManager/tools
chmod 0777 /opt/IdeaBank/usbkeyManager
chmod 0777 /opt/IdeaBank
chmod 0777 /opt/IdeaBank/usbkeyManager/icon
chmod 0777 /opt/IdeaBank/usbkeyManager/icon/*
chmod 0777 /opt/IdeaBank/usbkeyManager/script

#link Qt
ln -s /opt/IdeaBank/usbkeyManager/Qtlib/libQtGui.so.4.8.7 /opt/IdeaBank/usbkeyManager/Qtlib/libQtGui.so.4
ln -s /opt/IdeaBank/usbkeyManager/Qtlib/libQtNetwork.so.4.8.7 /opt/IdeaBank/usbkeyManager/Qtlib/libQtNetwork.so.4
ln -s /opt/IdeaBank/usbkeyManager/Qtlib/libQtCore.so.4.8.7 /opt/IdeaBank/usbkeyManager/Qtlib/libQtCore.so.4

ln -s /opt/IdeaBank/usbkeyManager/lib/libpcsclite.so.1.0.0 /opt/IdeaBank/usbkeyManager/lib/libpcsclite.so
ln -s /opt/IdeaBank/usbkeyManager/lib/libusb-1.0.so.0.1.0 /opt/IdeaBank/usbkeyManager/lib/libusb.so

i=0;
while [ $i -le 5 ]
do
	pkill pcscd
	if [ $? -eq 0 ]; then
		echo "stop service pcscd...succ"
		break
	fi
	echo "service pcscd stopping..."
	sleep 1
	let i++
	if [ $i -eq 4 ]; then
		echo "stop service pcscd...falied..."
		break
	fi
done

#pcscd 
if [ ! -e "/usr/sbin/pcscd" ]; then
	echo "pcscd not exist..."
	cp /opt/IdeaBank/usbkeyManager/lib/pcscd /usr/sbin/
	chmod 777 /usr/sbin/pcscd
fi

if [ ! -e "/lib64/libpcsclite.so.1.0.0" ]; then
	echo "pcsclite not exist"
	cp /opt/IdeaBank/usbkeyManager/lib/libpcsclite.so.1.0.0 /lib64/
	ln -s /lib64/libpcsclite.so.1.0.0 /lib64/libpcsclite.so
fi

if [ ! -e "/lib64/libusb-1.0.so.0.1.0" ]; then
	echo "usb not exist"
	cp /opt/IdeaBank/usbkeyManager/lib/libusb-1.0.so.0.1.0 /lib64/
	ln -s /lib64/libusb-1.0.so.0.1.0 /lib64/libusb.so
fi

if [ ! -e "/lib64/libcrypto.so.1.0.1j" ]; then
	echo "crypto not exist"
	cp /opt/IdeaBank/usbkeyManager/lib/libcrypto.so.1.0.1j /lib64/
	ln -s /lib64/libcrypto.so.1.0.1j /lib64/libcrypto.so
fi

if [ ! -e "/lib64/libQtCore.so.4.8.7" ]; then
	echo "QtCore not exist"
	cp /opt/IdeaBank/usbkeyManager/Qtlib/libQtCore.so.4.8.7 /lib64/
	ln -s /lib64/libQtCore.so.4.8.7 /lib64/libQtCore.so.4
fi

#restart pcscd service
i=0;
while [ $i -le 5 ]
do
	pcscd
	if [ $? -eq 0 ]; then
		echo "start service pcscd...succ"
		break
	fi
	echo "service pcscd restarting..."
	sleep 1
	let i++
	if [ $i -eq 4 ]; then
		echo "restart service pcscd...falied, please restart pcscd server yourself..."
		break
	fi
done

#link script
ln -s /opt/IdeaBank/usbkeyManager/script/SPCSC.sh /etc/rc.d/rc5.d/S00SPCSC
ln -s /opt/IdeaBank/usbkeyManager/script/KPCSC.sh /etc/rc.d/rc5.d/K01KPCSC

chmod 777 /opt/IdeaBank
chmod 777 /opt/IdeaBank/usbkeyManager
chmod 777 /opt/IdeaBank/usbkeyManager/*

chown root /opt/IdeaBank/usbkeyManager/tools/usbkeyManager
chmod 777 /opt/IdeaBank/usbkeyManager/tools/usbkeyManager
chmod +s /opt/IdeaBank/usbkeyManager/tools/usbkeyManager

chown root /opt/IdeaBank/usbkeyManager/tools/IB_PCSC_Deamon
chmod 777 /opt/IdeaBank/usbkeyManager/tools/IB_PCSC_Deamon

usbkeyManager &


%preun
echo "uninstalling..."
#rpm卸载前执行的脚本
kill_id=`ps afx | grep usbkeyManager | awk '{ print $1 }' | tail -n 1`
if [ $kill_id ]; then
	kill -9 $kill_id > /dev/null
fi

kill_id=`ps afx | grep IB_PCSC_Deamon | awk '{ print $1 }' | tail -n 1`
if [ $kill_id ]; then
	kill -9 $kill_id  > /dev/null
fi

%postun
#rpm卸载后执行的脚本
rm -rf /opt/IdeaBank
users=`cat /etc/passwd | awk -F : '/home/ { print $6 }'`
for the_user in $users
do
 if [ -e $the_user/桌面/usbkeyManager.desktop ]; then
	rm -rf $the_user/桌面/usbkeyManager.desktop
 fi
 if [ -e $the_user/Desktop/usbkeyManager.desktop ]; then
	rm -rf $the_user/Desktop/usbkeyManager.desktop
 fi
 if [ -e $the_user/desktop/usbkeyManager.desktop ]; then
	rm -rf $the_user/desktop/usbkeyManager.desktop
 fi
done

rm -fr /bin/usbkeyManager > /dev/null
rm -fr /bin/IB_PCSC_Deamon > /dev/null
rm -rf /etc/rc.d/rc5.d/S00SPCSC > /dev/null 
rm -rf /etc/rc.d/rc5.d/K01KPCSC > /dev/null
rm -rf /lib64/libXXX.so > /dev/null
echo "removed."

%files
%defattr(-, root, root, -)
#/usr/local/lib/*
/opt/IdeaBank
/etc/xdg/autostart/*
/root/Desktop/*
/root/桌面/*
/usr/share/applications/*
#/etc/udev/rules.d/*
/etc/reader.conf.d/*
/lib64/*

