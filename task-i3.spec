%global debug_package %{nil}

%global commit b0739e99d6fd28269b70977cdeac4d6722b8f5b2
%global shortcommit %(c=%{commit}; echo ${c:0:7})
%global bumpver 1

Name:		task-i3
Version:	0~%{bumpver}.git%{shortcommit}
Release:	2
Source0:	https://github.com/klejdiLOL/task-i3/archive/refs/heads/main.zip
#https://github.com/vuatech/i3-Dotfiles-OM-personal_only-/archive/%{commit}/%{name}-%{shortcommit}.tar.gz
Summary:	i3 configuration's required packages 'n DIRs
URL:		https://github.com/klejdiLOL/task-i3
License:	GPL
Group:		test

Requires: i3-gaps
Requires: polybar
Requires: rofi
Requires: kitty
Requires: conky
Requires: picom
Requires: feh
Requires: ranger
Requires: micro
Requires: dnfdrake
Requires: chromium
Requires: fonts-ttf-nerd-jetbrains-mono
Requires: python-autotiling
Requires: imagemagick
Requires: lxappearance
Requires: qt-theme-kvantum
Requires: networkmanager-applet
Requires: bc
Requires: pavucontrol-qt
Requires: i3lock-color
Requires: papirus-icon-theme
Requires: fonts-ttf-iosevka
Requires: fonts-ttf-liberation
Requires: arandr

%description
%summary.

%prep
%autosetup -n %{name}-main -p1

%install
install -d %{buildroot}%{_sysconfdir}/skel/.config/conky %{buildroot}%{_sysconfdir}/skel/.config/i3 %{buildroot}%{_sysconfdir}/skel/.config/i3lock-color/scripts %{buildroot}%{_sysconfdir}/skel/.config/kitty %{buildroot}%{_sysconfdir}/skel/.config/micro/colorschemes %{buildroot}%{_sysconfdir}/skel/.config/picom %{buildroot}%{_sysconfdir}/skel/.config/polybar/scripts/rofi %{buildroot}%{_sysconfdir}/skel/.config/rofi/rofi %{buildroot}%{_bindir}
install -d %{buildroot}%{_sysconfdir}/skel/.local/share/color-schemes %{buildroot}%{_sysconfdir}/skel/.local/share/fonts
install -Dm 775 .config/conky/conky-launch.sh %{buildroot}%{_sysconfdir}/skel/.config/conky/
install -Dm 775 .config/conky/conky.conf %{buildroot}%{_sysconfdir}/skel/.config/conky/
install -Dm 775 .config/i3/config %{buildroot}%{_sysconfdir}/skel/.config/i3/
install -Dm 775 .config/i3lock-color/scripts/lockscreen.sh %{buildroot}%{_sysconfdir}/skel/.config/i3lock-color/scripts/
install -Dm 775 .config/kitty/kitty.conf %{buildroot}%{_sysconfdir}/skel/.config/kitty/
install -Dm 775 .config/micro/info-settings.json-file.txt %{buildroot}%{_sysconfdir}/skel/.config/micro/
install -Dm 775 .config/micro/settings.json %{buildroot}%{_sysconfdir}/skel/.config/micro/
install -Dm 775 .config/micro/colorschemes/om-dark.micro %{buildroot}%{_sysconfdir}/skel/.config/micro/colorschemes
install -Dm 775 .config/picom/picom.conf %{buildroot}%{_sysconfdir}/skel/.config/picom/


install -Dm 775 .config/polybar/colors.ini %{buildroot}%{_sysconfdir}/skel/.config/polybar/
install -Dm 775 .config/polybar/config.ini %{buildroot}%{_sysconfdir}/skel/.config/polybar/
install -Dm 775 .config/polybar/launch.sh %{buildroot}%{_sysconfdir}/skel/.config/polybar/
install -Dm 775 .config/polybar/modules.ini %{buildroot}%{_sysconfdir}/skel/.config/polybar/
install -Dm 775 .config/polybar/extra_modules.ini %{buildroot}%{_sysconfdir}/skel/.config/polybar/
install -Dm 775 .config/polybar/scripts/launcher.sh %{buildroot}%{_sysconfdir}/skel/.config/polybar/scripts/
install -Dm 775 .config/polybar/scripts/powermenu.sh %{buildroot}%{_sysconfdir}/skel/.config/polybar/scripts/
install -Dm 775 .config/polybar/scripts/rofi/colors.rasi %{buildroot}%{_sysconfdir}/skel/.config/polybar/scripts/rofi/
install -Dm 775 .config/polybar/scripts/rofi/confirm.rasi %{buildroot}%{_sysconfdir}/skel/.config/polybar/scripts/rofi/
install -Dm 775 .config/polybar/scripts/rofi/launcher.rasi %{buildroot}%{_sysconfdir}/skel/.config/polybar/scripts/rofi/
install -Dm 775 .config/polybar/scripts/rofi/message.rasi %{buildroot}%{_sysconfdir}/skel/.config/polybar/scripts/rofi/
install -Dm 775 .config/polybar/scripts/rofi/networkmenu.rasi %{buildroot}%{_sysconfdir}/skel/.config/polybar/scripts/rofi/
install -Dm 775 .config/polybar/scripts/rofi/powermenu.rasi %{buildroot}%{_sysconfdir}/skel/.config/polybar/scripts/rofi/
install -Dm 775 .config/polybar/scripts/rofi/styles.rasi %{buildroot}%{_sysconfdir}/skel/.config/polybar/scripts/rofi/
install -Dm 775 install-i3-theme %{buildroot}%{_bindir}/

install -Dm 775 install-i3-theme %{buildroot}%{_bindir}/

install -Dm 775 .local/share/color-schemes/OMDark.colors %{buildroot}%{_sysconfdir}/skel/.local/share/color-schemes/
install -Dm 775 .local/share/fonts/OMLogosFont.ttf %{buildroot}%{_sysconfdir}/skel/.local/share/fonts
install -Dm 775 .local/share/fonts/feather.ttf %{buildroot}%{_sysconfdir}/skel/.local/share/fonts

%post
echo "To complete setup, run:"
echo "  install-i3-theme"

%files
%dir %{_sysconfdir}/skel/.config
%dir %{_sysconfdir}/skel/.local/share
%{_bindir}/install-i3-theme
%{_sysconfdir}/skel/.config/conky
%{_sysconfdir}/skel/.config/i3
%{_sysconfdir}/skel/.config/i3lock-color
%{_sysconfdir}/skel/.config/kitty
%{_sysconfdir}/skel/.config/micro
%{_sysconfdir}/skel/.config/picom
%{_sysconfdir}/skel/.config/polybar
%{_sysconfdir}/skel/.config/rofi
%{_sysconfdir}/skel/.local/share/color-schemes
%{_sysconfdir}/skel/.local/share/fonts

