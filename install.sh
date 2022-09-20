#!/bin/bash

# Utils
function is_installed {
  # set to 1 initially
  local return_=1
  # set to 0 if not found
  type $1 >/dev/null 2>&1 || { local return_=0;  }
  # return
  echo "$return_"
}

# Install softwares
function install_neovim {
  if [ "(is_installed nvim)" == "0" ]; then
    echo "Neovim not found! Please install neovim first!"
    return
  fi
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  sudo apt install ripgrep -y
  npm install -g @fsouza/prettierd
}

function install_dracula {
  mkdir -p ~/.local/share/nvim/site/pack/themes/start
  cd ~/.local/share/nvim/site/pack/themes/start
  git clone https://github.com/dracula/vim.git dracula
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

function install_tmux {
  if [ "$(is_installed tmux)" == "0" ]; then
    echo "Installing tmux"
    sudo apt install tmux -y
    echo "Installing tpm"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    source ~/.tmux.conf
  fi
}

function install_tools { 
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

function install_zsh { 
  local current_date=$(date +%s)
  sudo apt install zsh -y
  if [ -d ~/.oh-my-zsh ]; then
    echo "oh-my-zsh is installed"
  else
    echo "oh-my-zsh is not installed"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
  echo $'OhMyZsh plugin\n'
  echo $'Downloading zsh-syntax-highlighting zsh-autosuggestions\n'
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

function backup {
  mkdir -p .config
  sudo cp -r ~/.config/alacritty ./.config
  sudo cp -r ~/.config/nvim ./.config
}

# -- while test $# -gt 0; do 
# --   case "$1" in
# --     --help)
# --       echo "Help"
# --       exit
# --       ;;
# --     --macos)
# --       install_macos
# --       backup
# --       link_dotfiles
# --       zsh
# --       source ~/.zshrc
# --       exit
# --       ;;
# --     --backup)
# --       backup
# --       exit
# --       ;;
# --     --dotfiles)
# --       link_dotfiles
# --       exit
# --       ;;
# --   esac
# -- 
# --   shift
# -- done
# install_programminglanguage
install_tmux
