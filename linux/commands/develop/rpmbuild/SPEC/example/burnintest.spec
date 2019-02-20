Name:	burnintest
Version: 1.1.2
Release: 1.bt.1
Summary: burnintest install configure	

Group:	System Environment/Base	
License: GPLv2+	
#URL:		
Source0: bitlinux.tar.gz

BuildArch: noarch
#BuildRequires:	
#Requires:	

%description
burnintest install configure

%prep
#%setup -q
%autosetup -c %{name}

%post
bash %{_builddir}/burnintest-%{version}/burnintest/burnintest.sh
exit 0

#%build
#%configure
#make %{?_smp_mflags}

%install
#make install DESTDIR=%{buildroot}
#bash %{_builddir}/burnintest-%{version}/burnintest/burnintest.sh
#touch /home/desktop/a.txt

%files
%doc

%changelog
* Tue Feb 19 2019 Changhao Wu <changhao.wu@cs2c.com.cn> - 1.1.0-0
- burnintest install configure

