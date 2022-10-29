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

# Install softwares
function install_alacritty { # DONEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
	if [ "$(is_installed alacritty)" == "0" ]; then
		sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
		git clone https://github.com/alacritty/alacritty.git
		cargo build --release
		cd alacritty
		sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
		sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
		sudo desktop-file-install extra/linux/Alacritty.desktop
		sudo update-desktop-database
		cd ..
		rm -r ../alacritty
	fi
}

function install_neovim { # DONEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
	if [ "$(is_installed nvim)" == "0" ]; then
		echo "Neovim not found! Please install neovim first!"
		return
	fi
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	sudo apt install ripgrep -y
	sudo apt install xsel -y # install clipboard tool for neovim
	npm install -g @fsouza/prettierd
}

function install_dracula { # DONEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
	mkdir -p ~/.local/share/nvim/site/pack/themes/start
	cd ~/.local/share/nvim/site/pack/themes/start
	git clone https://github.com/dracula/vim.git dracula >/dev/null
}

function install_programminglanguage {
	if [ "$(is_installed ruby)" == "0" ]; then
		echo "Installing ruby"
		sudo apt install ruby-full -y
		sudo gem install jekyll bundler -y
	fi
	if [ "$(is_installed rustup)" == "0" ]; then
		echo "Installing rust"
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
		source $HOME/.cargo/env
		rustup update
	fi
	if [ "$(is_installed go)" == "0" ]; then
		echo "Installing golang"
		sudo apt install golang -y
	fi
	if [ "$(is_installed nvm)" == "0" ]; then # Cannot detect if nvm was installed or not
		echo "Installing nvm"
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
		nvm install node
		npm install -g yarn -y
		npm install -g gulp -y
	fi
}

function install_tmux { # DONEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
	if [ "$(is_installed tmux)" == "0" ]; then
		echo "Installing tmux"
		sudo apt install tmux -y
		echo "Installing tpm"
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
		source ~/.tmux.conf
		gem install tmuxinator
	fi
}

function install_tools { # DONEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
	sudo apt install build-essential zlib1g-dev -y
	sudo apt install aptitude -y
	sudo apt install snapd
	sudo snap install telegram-desktop
	sudo snap install discord
	sudo snap install skype
	echo $'\n'"Installing postman"
	sudo snap install postman
	echo $'\n'"Installing vscode"
	sudo apt install code
	echo $'\n'"Holding vscode"
	sudo apt-mark hold code
	# echo $'\n'"Installing latex" # cài sau cùng dùm cái, cài phải hơn 3 tiếng
	# sudo apt-get install texlive-full -y
}

function install_zsh { # DONEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
	echo "Removing old zsh files"
	sudo rm -r ~/.zshrc*
	sudo rm -r ~/.oh-my-zsh*
	echo "Installing new ZSH"
	if [ "$(is_installed zsh)" == "0" ]; then
		echo "Installing zsh"
		sudo apt install zsh -y
	fi
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	echo $'OhMyZsh plugin\n'
	echo $'Downloading zsh-syntax-highlighting zsh-autosuggestions\n'
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

function backup {
	mkdir -p .config
	sudo cp -r ~/.config/alacritty ./.config
	sudo cp -r ~/.config/nvim ./.config
	sudo cp .zshrc ./.zshrc
	sudo cp .tmux.conf ./.tmux.conf
}

function link_dotfiles {
	echo "Linking dotfiles"

	rm ~/.zshrc
	rm ~/.tmux.conf
	rm ~/.aliasrc
	rm -rf ~/.config/alacritty
	rm -rf ~/.config/nvim
	rm -rf ~/.config/awesome

	ln -s $(pwd)/.zshrc ~/.zshrc
	ln -s $(pwd)/.tmux.conf ~/.tmux.conf
	ln -s $(pwd)/.aliasrc ~/.aliasrc
	ln -s $(pwd)/.config/alacritty/ ~/.config/alacritty
	ln -s $(pwd)/.config/nvim/ ~/.config/nvim
	ln -s $(pwd)/.config/awesome/ ~/.config/awesome
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
		install_dracula
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
