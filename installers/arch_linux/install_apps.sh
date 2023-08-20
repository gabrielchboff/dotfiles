sudo pacman -Sy firefox docker docker-compose konsole helix flatpak ufw \
	libreoffice-fresh vlc neofetch reflector gimp krita kdenlive tmux dolphin kdewallet kdeconnect

sudo reflector --verbose --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
yay -Sy zoom discord spotify dbeaver steam preload timeshift teams-for-linux brave-bin

flatpak install flathub md.obsidian.Obsidian
flatpak install flathub com.visualstudio.code
flatpak install flathub com.obsproject.Studio

sudo pacman -Sy
sudo ufw enable
sudo ufw status verbose
sudo systemctl enable ufw.service
sudo systemctl enable preload && sudo systemctl start preload
