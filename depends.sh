#!/bin/sh

#needed depends
sudo pacman -S kitty dmenu xorg xorg-xinit feh xcompmgr flatpak git wget curl flameshot telegram-desktop steam discord pavucontrol nwg-look

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
yay -S zen-browser-bin tokyonight-gtk-theme

echo "Done!"
# blya budet smeshno esli ne zarabotaet

