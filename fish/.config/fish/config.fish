if status --is-interactive
	if ! set -q TMUX
        tmux attach-session -t "$USER" || tmux new-session -s "$USER"
	end
end

# Universal Variables
# A universal variable is a variable whose value is shared across all instances
# of fish, now and in the future – even after a reboot.

setenv EDITOR nvim
setenv BROWSER brave
setenv TERMINAL alacritty
setenv FILEMANAGER thunar

setenv GTK_IM_MODULE fcitx
setenv QT_IM_MODULE fcitx
setenv XMODIFIERS @im=fcitx
setenv QT_QPA_PLATFORM wayland
setenv MOZ_ENABLE_WAYLAND 1

setenv XDG_CURRENT_DESKTOP sway
setenv XDG_SESSION_TYPE wayland
setenv XDG_SESSION_DESKTOP sway

# Rust specific
# env = CARGO_TARGET_DIR, $HOME/cargo-target
setenv CARGO_INCREMENTAL 1
setenv RUST_BACKTRACE 1

setenv ANDROID_HOME $HOME/Android/Sdk
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools

# Some other variables
# ignore greeting
set -g fish_greeting

# Programs
abbr -a g git
abbr -a c cargo
abbr -a o xdg-open
abbr -a t tmux
abbr -a tmx tmuxinator
# Commands
abbr -a update-grub 'grub-mkconfig -o /boot/grub/grub.cfg'
abbr -a aurman 'paru -Slq | fzf --multi --preview \'paru -Si {1}\' | xargs -ro paru -S'
abbr -a sa 'source $(which active-venv)'
abbr -a up 'sudo pacman -Syu --noconfirm && paru -Sua --noconfirm'
abbr -a cleanup 'pacman -Qtdq | sudo pacman -Rnsc -'
abbr -a scheduler 'echo \'notify-send "your message"\' | at 10.20 pm'

abbr -a gah 'git stash; and git pull --rebase; and git stash pop'

if command -v eza > /dev/null
	abbr -a l 'eza -lah'
	abbr -a ls 'eza'
	abbr -a ll 'eza -lh'
	abbr -a la 'eza -lAh'
else
	abbr -a l 'ls -lah'
	abbr -a ls 'ls'
	abbr -a ll 'ls -lh'
	abbr -a la 'ls -lAh'
end

# Evaluate packages manager
[ -x "$(command -v mise)" ]; and eval "$(mise activate)"; or true

# Modifying path
fish_add_path $HOME
fish_add_path $HOME/data/repos/dotfiles/scripts/*
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/share/nvim/mason/bin
fish_add_path $HOME/.local/share/solana/install/active_release/bin
fish_add_path /data/repos/phnaharris/scripts/baricon

# pnpm
fish_add_path $HOME/.local/share/pnpm
set -gx PNPM_HOME "/home/phnaharris/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# jonhoo
# Fish git prompt
# set __fish_git_prompt_show_informative_status 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showcolorhints 'yes'
set __fish_git_prompt_showstashstate 'yes'
# set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

function fish_prompt
	set_color brblack
	echo -n "["(date "+%H:%M")"] "
	set_color --bold yellow; echo -n (whoami)
	set_color normal; echo -n "@"
	set_color --bold blue; echo -n (hostnamectl hostname)
	set_color normal

    echo -n ' '
    set_color magenta; echo -n (prompt_pwd --full-length-dirs=5 --dir-length=1)
	set_color green; printf '%s ' (__fish_git_prompt)
	set_color red; echo -n '$ '
end

fish_add_path -a /home/phnaharris/.foundry/bin

export PATH="$PATH:/home/phnaharris/.sp1/bin"
export GPG_TTY=$(tty)

export PATH="$PATH:/home/phnaharris/.soundness/bin"
