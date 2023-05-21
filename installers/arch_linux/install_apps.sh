sudo pacman -Sy opera firefox docker docker-compose wezterm helix flatpak ufw \
  libreoffice-fresh vlc neofetch reflector gimp krita kdenlive 

sudo reflector --verbose --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
yay -Sy zoom discord spotify dbeaver steam preload timeshift

git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
cd ~

sudo pacman -Sy
sudo ufw enable
sudo ufw status verbose
sudo systemctl enable ufw.service
sudo systemctl enable preload && sudo systemctl start preload
sudo snap install todoist

