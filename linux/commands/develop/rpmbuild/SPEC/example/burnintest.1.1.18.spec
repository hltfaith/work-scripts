Name:	burnintest
Version: 1.1.18
Release: 1.bt.1
Summary: burnintest install configure	

Group:	System Environment/Base	
License: GPLv2+	
Source0: bitlinux.tar.gz

#BuildArch: noarch
#BuildRequires:	
#Requires: bash
AutoReqProv: no

%description
burnintest install configure

%prep
%autosetup -c %{name}

%post
#tar zxf /var/bitlinux.tar.gz -C /var/
#rm -rf /var/bitlinux.tar.gz
exit 0

#%build
#%configure
#make %{?_smp_mflags}

%install
#mkdir -p $RPM_BUILD_ROOT/var/
#install -D -m 0755 %{SOURCE0} %{_localstatedir} 
#cp -f %{SOURCE0} $RPM_BUILD_ROOT/var/
#tar zxf /var/bitlinux.tar.gz -C /var/

# install -D -m 0755 %{SOURCE0} %{_localstatedir} 
mkdir -p $RPM_BUILD_ROOT/opt/
tar xf %{SOURCE0} -C $RPM_BUILD_ROOT/opt/

%clean
rm -rf $RPM_BUILD_ROOT

%postun
rm -rf /var/burnintest
exit 0

%files
%defattr(-,root,root,-)
/opt/burnintest/*

%changelog
* Tue Feb 26 2019 Changhao Wu <changhao.wu@cs2c.com.cn> - 1.1.18-0
- burnintest build package & ctmm.

* Tue Feb 19 2019 Changhao Wu <changhao.wu@cs2c.com.cn> - 1.1.0-0
- burnintest install configure
