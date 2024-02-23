sudo pacman -Sy docker docker-compose ufw\
    libreoffice-fresh vlc neofetch reflector \
    gimp krita kdenlive tmux stow


sudo reflector --verbose --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

yay -Sy zoom discord spotify-adblock-git steam preload timeshift brave-bin

sudo pacman -Sy
sudo ufw enable
sudo ufw status verbose
sudo systemctl enable ufw.service
sudo systemctl enable preload && sudo systemctl start preload
