#!/bin/sh

#needed depends
sudo pacman -S ly i3lock ttf-jetbrains-mono kitty dmenu xorg xorg-xinit feh xcompmgr flatpak git wget curl flameshot telegram-desktop steam discord pavucontrol nwg-look jdk8-openjdk jdk11-openjdk jdk17-openjdk jdk21-openjdk jdk-openjdk mpv

#flatpaki 💀💀
flatpak install sober -y

#kopirka
git clone https://github.com/bakkeby/dwm-flexipatch.git ~/.dwm
git clone https://aur.archlinux.org/yay.git

#yay nihuya ne yay eto blya hz kak opisar
cd yay
makepkg -si
cd ..
rm -rf yay

#paketiki net ne s geroinom
yay -S zen-browser-bin tokyonight-gtk-theme polymc mc 

#delaem raznie shtuki
chmod +x .xinitrc
chmod +x info.sh
chmod +x .fehbg
chmod +x .xcompmgr

#peremeshenie pidorov oy konfigov
mv .fehbg ~/
mv .xcompmgr ~/
mv .xinitrc ~/
mv patches.h ~/.dwm
mv config.h ~/.dwm
mkdir ~/.config/wlogout
mv layout ~/.config/wlogout/
mv info.sh ~/.dwm
mkdir ~/.wallpapers
mv uranus.jpg ~/.wallpapers/
mv uranus.png ~/.wallpapers/
mv startup.wav ~/.dwm/
mv logoff.wav ~/.dwm/

#DLYA RABOTI SKRIPTA
yay -S xkb-switch      # Для определения раскладки клавиатуры
sudo pacman -S pipewire-pulse  # Для управления звуком (pactl)
sudo pacman -S coreutils       # Базовые утилиты (обычно уже установлен)
sudo pacman -S util-linux      # Для free и других утилит (обычно уже установлен)
sudo pacman -S procps-ng       # Для pgrep (обычно уже установлен)

#drochim login manager
sudo systemctl enable ly

#ustanovka zapreta
sudo git clone https://github.com/Sergeydigl3/zapret-discord-youtube-linux.git /opt/zapret
cd /opt/zapret
sudo bash main_script.sh

echo "Done!"
# blya budet smeshno esli ne zarabotaet

