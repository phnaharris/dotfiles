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

pacman -S xorg-server xorg-xinit
pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings git
# i3
pacman -S i3-gaps i3status i3lock rofi alacritty
# browser
pacman -S firefox
# file manager
pacman -S nautilus
# for wallpaper
pacman -S nitrogen
# for term
pacman -S tmux zsh git
chsh -s "$(which zsh)"

pacman -S unzip
