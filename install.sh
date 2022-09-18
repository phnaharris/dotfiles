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
}

function install_dracula {
  mkdir -p ~/.local/share/nvim/site/pack/themes/start
  cd ~/.local/share/nvim/site/pack/themes/start
  git clone https://github.com/dracula/vim.git dracula
}

function install_programminglanguage {
  if [ "(is_installed ruby)" == "0" ]; then
    echo "Installing ruby"
    sudo apt install ruby-full -y
  fi
  if [ "(is_installed rustup)" == "0" ]; then
    echo "Installing rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup update
    source $HOME/.cargo/env
  fi
  if [ "(is_installed go)" == "0" ]; then
    echo "Installing golang"
    sudo apt install golang -y
  fi
}

function install_tmux {
  if [ "(is_installed tmux)" == "0" ]; then
    echo "Installing tmux"
    sudo apt install tmux -y
    echo "Installing tpm"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    tmux source ~/.tmux.conf
  fi
}

function install_tools { true; }

function install_zsh { true; }

function backup {
    mkdir -p .config
    sudo cp -r ~/.config/alacritty ./.config
    sudo cp -r ~/.config/nvim ./.config
}

backup
