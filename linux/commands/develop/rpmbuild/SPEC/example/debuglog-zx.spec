Name:debuglog-zx
Version:1.1.3	
Release:nd1.0
Summary:debuglog-zx install configure	

Group:	System Environment/Base		
License: GPLv2+		

BuildArch: noarch
AutoReqProv: no

%description
debuglog-zx

#%prep
#%autosetup -c %{name}

#%build
#%configure
#make %{?_smp_mflags}

%post
######################### 开启Debug ##############################
UUID=`grep "ctmm_enable=1 enforcing=1 strict=1" /boot/grub/grub.cfg | awk '{print $3}'`

sed -i "s#.*ctmm_enable=1 enforcing=1 strict=1.*#       linux16 /boot/vmlinuz-3.10.52.x86_64 $UUID  ctmm_enable=1 enforcing=1 strict=1 loglevel=0  iommu=usedac vga=791 radeon.modeset=0 rd.driver.blacklist=radeon loglevel=7 #g" /boot/grub/grub.cfg

exit 0

#%install
#mkdir -p $RPM_BUILD_ROOT/opt/
#tar xf %{SOURCE0} -C $RPM_BUILD_ROOT/opt/

#%clean
#rm -rf $RPM_BUILD_ROOT

%postun
########################## 关闭Debug #############################
UUID=`grep "ctmm_enable=1 enforcing=1 strict=1" /boot/grub/grub.cfg | awk '{print $3}'`
sed -i "s#.*ctmm_enable=1 enforcing=1 strict=1.*#       linux16 /boot/vmlinuz-3.10.52.x86_64 $UUID  ro rhgb quiet  ctmm_enable=1 enforcing=1 strict=1 loglevel=0  iommu=usedac vga=791 radeon.modeset=0 rd.driver.blacklist=radeon #g" /boot/grub/grub.cfg

exit 0

%files
%defattr(-,root,root,-)

%changelog
* Thu May 11 2019 Changhao Wu <changhao.wu@cs2c.com.cn> -1.1.3.nd1.0
- update debuglog-zx package.

* Thu May 11 2019 Changhao Wu <changhao.wu@cs2c.com.cn> -1.1.0.nd1.0
- configure debuglog-zx package.
