sudo pacman -Syu
sudo pacman -Sy --needed base-devel git python3 python-lsp-server clang \
	unzip xdg-user-dirs pacman-contrib bluez blueman bluez-utils curl
sudo pacman -Sy enchant mythes-en ttf-liberation \
    hunspell-en_US ttf-bitstream-vera pkgstats adobe-source-sans-pro-fonts \
    gst-plugins-good ttf-droid ttf-dejavu aspell-en icedtea-web gst-libav ttf-ubuntu-font-family\
    ttf-anonymous-pro zsh zsh-autosuggestions zsh-syntax-highlighting \
    jre8-openjdk jdk-openjdk languagetool libmythes p7zip unrar tar rsync \
    htop exfat-utils fuse-exfat ntfs-3g flac jasper \
    aria2 intel-ucode go polybar

git clone https://aur.archlinux.org/yay-git.git
cd yay
makepkg -si
yay -Syu

yay -S bspwm sxhkd rofi kitty picom-ibhagwan-git calcurse todotxt \
    feh jq dunst betterlockscreen brightnessctl playerctl maim \
    xclip imagemagick nerd-fonts-noto-sans-mono-extended thunar \
    ranger

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/l3ib/nitrogen.git
cd nitrogen
autoreconf -fi
./configure
make
sudo make install


curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

mkdir -p ~/Documents/git-lab && git clone --depth=1 https://github.com/zoddDev/dotfiles.git ~/Documents/git-lab/dotfiles && cd ~/Documents/git-lab/dotfiles


chmod +x ./setup.sh
./setup.sh all pink-nord-alternative

