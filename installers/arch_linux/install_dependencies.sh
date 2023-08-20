sudo pacman -Syu
sudo pacman -Sy plasma plasma-wayland-session kde-applications sddm

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
sudo pacman -Sy --needed base-devel git python3 python-lsp-server clang \
	unzip xdg-user-dirs pacman-contrib bluez blueman bluez-utils

sudo pacman -Sy enchant mythes-en ttf-liberation \
	hunspell-en_US ttf-bitstream-vera pkgstats adobe-source-sans-pro-fonts \
	gst-plugins-good ttf-droid ttf-dejavu aspell-en icedtea-web gst-libav ttf-ubuntu-font-family \
	ttf-anonymous-pro \
	jre8-openjdk jdk-openjdk languagetool libmythes p7zip unrar tar rsync \
	htop exfat-utils fuse-exfat ntfs-3g flac jasper aria2 intel-ucode go

sudo pacman -Sy linux-lts linux-lts-headers
sudo pacman -Sy linux-hardened linux-hardened-headers
sudo pacman -Sy linux-zen linux-zen-headers

sudo systemctl enable paccache.timer

git clone https://aur.archlinux.org/yay-git.git
cd yay
makepkg -si
yay -Syu
xdg-user-dirs-update
sudo modprobe btusb
sudo systemctl enable bluetooth && sudo systemctl start bluetooth
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo systemctl enable sddm.service
sudo systemctl start sddm.service
