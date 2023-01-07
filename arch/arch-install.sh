# check internet connection
ping google.com
# if cannot ping
pacman -S networkmanager
systemctl start NetworkManager
systemctl enable NetworkManager
nmtui

pacman -S tlp tlp-rdw
systemctl enable tlp.service

# create user
useradd -m -g wheel phnaharris
passwd phnaharris
# install vi if not have
pacman -S vi
visudo
# uncomment the line below
# %wheel ALL=(ALL) ALL

# pacman package
pacman -S xorg-server xorg-xinit
pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings git
# i3
pacman -S i3-gaps i3status i3lock rofi alacritty
# xmonad
pacman -S xmonad xmonad-contrib xmobar
# browser
pacman -S firefox
# file manager
pacman -S nautilus
# for wallpaper
pacman -S nitrogen
# for pdf
pacman -S zathura
# for term
pacman -S tmux zsh git
chsh -s "$(which zsh)"
# for audio
pacman -S pulseaudio pavucontrol
# for unikey
# pacman -S fcitx5 fcitx5-qt fcitx5-gtk fcitx5-unikey kcm-fcitx5

pacman -S unzip htop lm_sensors neofetch man curl wget
pacman -S neovim fzf ripgrep fd
pacman -S go

pacman -S telegram-desktop
