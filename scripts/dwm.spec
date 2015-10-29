Name:   dwm-customized
Version:  1.0
Release:  1%{?dist}
Summary:  Customized DWM packed to RPM
Packager: Frantisek Kolacek <fkolacek@redhat.com>
Group:    User Interface/Desktops
License:  MIT
URL:    http://github.com/fkolacek/dwm-customized
Source0:  dwm-customized-1.0.tgz

BuildRequires:  gcc libX11-devel libXinerama-devel libXft-devel make
Requires: terminus-fonts xorg-x11-xinit dmenu xsel wmname i3lock

%description
Custom DWM configuration packed to RPM package.

%prep
%setup -q

%clean
#make clean
rm -rf %{buildroot}

%build
make
make scripts

%install
#make install
rm -rf %{buildroot}
mkdir -p %{buildroot}/usr/local/bin
mkdir -p %{buildroot}/usr/local/share/man/man1
mkdir -p %{buildroot}/usr/share/xsessions
mkdir -p %{buildroot}/etc/systemd/user

install dwm %{buildroot}/usr/local/bin/dwm
chmod 755 %{buildroot}/usr/local/bin/dwm
install dwm.1 %{buildroot}/usr/local/share/man/man1/dwm.1
chmod 644 %{buildroot}/usr/local/share/man/man1/dwm.1

install scripts/dwm.desktop %{buildroot}/usr/share/xsessions/dwm.desktop
chmod 644 %{buildroot}/usr/share/xsessions/dwm.desktop
install scripts/dwm-panel.service %{buildroot}/etc/systemd/user/dwm-panel.service
chmod 644 %{buildroot}/etc/systemd/user/dwm-panel.service
install scripts/dwm-loader %{buildroot}/usr/local/bin/dwm-loader
chmod 755 %{buildroot}/usr/local/bin/dwm-loader

install scripts/dwm-panel %{buildroot}/usr/local/bin/dwm-panel
chmod 755 %{buildroot}/usr/local/bin/dwm-panel

# Helpers
install scripts/dwm-menu %{buildroot}/usr/local/bin/dwm-menu
install scripts/dwm-switch-keyboard %{buildroot}/usr/local/bin/dwm-switch-keyboard
install scripts/dwm-open-browser %{buildroot}/usr/local/bin/dwm-open-browser

chmod 755 %{buildroot}/usr/local/bin/dwm-{menu,switch-keyboard,open-browser}

%files
%doc /usr/local/share/man/man1/dwm.1
%config /usr/local/bin/dwm-loader
/usr/share/xsessions/dwm.desktop
/usr/local/bin/dwm
/usr/local/bin/dwm-panel
/etc/systemd/user/dwm-panel.service
/usr/local/bin/dwm-menu
/usr/local/bin/dwm-switch-keyboard
/usr/local/bin/dwm-open-browser

%changelog
* Thu Sep 28 2015 Frantisek Kolacek <fkolacek@redhat.com> 1.0-1
--First repack
