#!/bin/sh

#needed depends
sudo pacman -S ttf-jetbrains-mono kitty dmenu xorg xorg-xinit feh xcompmgr flatpak git wget curl flameshot telegram-desktop steam discord pavucontrol nwg-look jdk8-openjdk jdk11-openjdk jdk17-openjdk jdk21-openjdk jdk-openjdk

#flatpaki 💀💀
flatpak install sober -y

#kopirka
git clone https://github.com/bakkeby/dwm-flexipatch.git .dwm
git clone https://aur.archlinux.org/yay.git

#yay nihuya ne yay eto blya hz kak opisar
cd yay
makepkg -si
cd
rm -rf yay

#paketiki net ne s geroinom
yay -S zen-browser-bin tokyonight-gtk-theme polymc mc 

#peremeshenie pidorov oy konfigov
mv .xinitrc ~/
mv patches.h ~/.dwm
mv config.h ~/.dwm
mkdir ~/.config/wlogout
mv layout ~/.config/wlogout/
mv info.sh ~/.dwm

#DLYA RABOTI SKRIPTA
sudo pacman -S xkb-switch      # Для определения раскладки клавиатуры
sudo pacman -S pipewire-pulse  # Для управления звуком (pactl)
sudo pacman -S coreutils       # Базовые утилиты (обычно уже установлен)
sudo pacman -S util-linux      # Для free и других утилит (обычно уже установлен)
sudo pacman -S procps-ng       # Для pgrep (обычно уже установлен)

echo "Done!"
# blya budet smeshno esli ne zarabotaet

