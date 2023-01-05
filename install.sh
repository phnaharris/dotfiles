#!/bin/bash

# Utils
function is_installed {
	# set to 1 initially
	local return_=1
	# set to 0 if not found
	type $1 >/dev/null 2>&1 || { local return_=0; }
	# return
	echo "$return_"
}

function install_tmux { # DONEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
	if [ "$(is_installed tmux)" == "0" ]; then
		echo "Installing tmux"
		apt install tmux -y
		echo "Installing tpm"
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
		source ~/.tmux.conf
		gem install tmuxinator
	fi
}

function install_tools { # DONEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
	apt install build-essential zlib1g-dev -y
	apt install aptitude -y
	apt install snapd
	apt install tlp tlp-rdw
	# snap install telegram-desktop
	# snap install discord
	# snap install skype
	# echo $'\n'"Installing postman"
	# snap install postman
	# echo $'\n'"Installing vscode"
	# apt install code
	# echo $'\n'"Holding vscode"
	# apt-mark hold code
	# echo $'\n'"Installing latex" # cài sau cùng dùm cái, cài phải hơn 3 tiếng
	# apt-get install texlive-full -y
}

function install_zsh { # DONEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
	echo "Removing old zsh files"
	rm -r ~/.zshrc*
	echo "Installing new ZSH"
	if [ "$(is_installed zsh)" == "0" ]; then
		echo "Installing zsh"
		apt install zsh -y
	fi

	# Bye oh-my-zsh, I will continue with zap
	sh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.sh)
}

function backup {
	mkdir -p .config
	cp -r ~/.config/alacritty ./.config
	cp -r ~/.config/nvim ./.config
	cp .zshrc ./.zshrc
	cp .tmux.conf ./.tmux.conf
}

function link_dotfiles {
	echo "Linking dotfiles"

	rm ~/.zshrc
	rm ~/.czrc
	rm ~/.tmux.conf
	rm ~/.aliasrc
	rm ~/.gitconfig
	rm -rf ~/.config/alacritty
	rm -rf ~/.config/nvim
	rm -rf ~/.config/zsh
	rm -rf ~/.config/tmux
	rm -rf ~/.config/i3
	rm -rf ~/.config/i3status
	rm -rf ~/.config/rofi
	rm -rf ~/.config/picom
	rm -rf ~/.config/xmonad
	rm -rf ~/.config/xmobar
	rm -rf ~/.config/fcitx5
	rm -rf ~/.config/hypr
	rm -rf ~/.config/waybar

	ln -s $(pwd)/.zshrc ~/.zshrc
	ln -s $(pwd)/.czrc ~/.czrc
	ln -s $(pwd)/.tmux.conf ~/.tmux.conf
	ln -s $(pwd)/.gitconfig ~/.gitconfig
	ln -s $(pwd)/.aliasrc ~/.aliasrc
	ln -s $(pwd)/.config/alacritty/ ~/.config/alacritty
	ln -s $(pwd)/.config/nvim/ ~/.config/nvim
	ln -s $(pwd)/.config/zsh/ ~/.config/zsh
	ln -s $(pwd)/.config/tmux/ ~/.config/tmux
	ln -s $(pwd)/.config/i3/ ~/.config/i3
	ln -s $(pwd)/.config/i3status/ ~/.config/i3status
	ln -s $(pwd)/.config/rofi/ ~/.config/rofi
	ln -s $(pwd)/.config/picom/ ~/.config/picom
	ln -s $(pwd)/.config/xmonad/ ~/.config/xmonad
	ln -s $(pwd)/.config/xmobar/ ~/.config/xmobar
	ln -s $(pwd)/.config/fcitx5/ ~/.config/fcitx5
	ln -s $(pwd)/.config/hypr/ ~/.config/hypr
	ln -s $(pwd)/.config/waybar/ ~/.config/waybar
}

while test $# -gt 0; do
	case "$1" in
	--help)
		echo "Help"
		exit
		;;
	--install_alacritty)
		install_alacritty
		exit
		;;
	--install_neovim)
		install_neovim
		exit
		;;
	--install_dracula)
		install_dracula
		exit
		;;
	--install_programminglanguage)
		install_programminglanguage
		exit
		;;
	--install_tmux)
		install_tmux
		exit
		;;
	--install_tools)
		install_tools
		exit
		;;
	--install_zsh)
		install_zsh
		exit
		;;
	--backup)
		backup
		exit
		;;
	--linux)
		install_tools
		install_zsh
		install_programminglanguage
		install_alacritty
		install_tmux
		install_neovim
		exit
		;;
	--dotfiles)
		link_dotfiles
		exit
		;;
	esac
	shift
done
link_dotfiles
