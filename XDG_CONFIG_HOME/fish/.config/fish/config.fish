theme_gruvbox dark hard

if status --is-interactive
	if ! set -q TMUX
        tmux attach-session -t "$USER" || tmux new-session -s "$USER"
	end
end

# Universal Variables
# A universal variable is a variable whose value is shared across all instances
# of fish, now and in the future – even after a reboot.
setenv EDITOR nvim
# setenv XDG_CONFIG_DIRS /etc/xdg
# setenv XDG_DATA_DIRS /usr/local/share:/usr/share
# setenv XDG_CONFIG_HOME $HOME/.config
# setenv XDG_CACHE_HOME $HOME/.cache
# setenv XDG_DATA_HOME $HOME/.cache
# setenv XDG_STATE_HOME $HOME/.local/state

# Some other variables
# ignore greeting
set -g fish_greeting

# Programs
abbr -a g git
abbr -a c cargo
abbr -a o xdg-open
abbr -a t tmux
abbr -a tmx tmuxinator
# VPN
abbr -a swd0 'sudo wg-quick down wg0'
abbr -a swu0 'sudo wg-quick up wg0'
abbr -a swd1 'sudo wg-quick down wg1'
abbr -a swu1 'sudo wg-quick up wg1'
# Commands
abbr -a update-grub 'grub-mkconfig -o /boot/grub/grub.cfg'
abbr -a aurman 'paru -Slq | fzf --multi --preview \'paru -Si {1}\' | xargs -ro paru -S'
abbr -a sa 'source $(which active-venv)'
abbr -a up 'sudo pacman -Syu --noconfirm && paru -Sua --noconfirm'
abbr -a cleanup 'pacman -Qtdq | sudo pacman -Rnsc -'
abbr -a scheduler 'echo \'notify-send "your message"\' | at 10.20 pm'

abbr -a gah 'git stash; and git pull --rebase; and git stash pop'

abbr -a dev1 'env PRIV=$(pass wallets/beowulf/dev-1@0x9e661c4fe9b0aec733840bdc76cc6a8bd68d6882)'
abbr -a dev2 'env PRIV=$(pass wallets/beowulf/dev-2@0x0c8f0c147d0e197f1d1ff25f472aca1d4cfdc019)'
abbr -a trading 'env PRIV=$(pass wallets/trading/metamask/trading@0xd1a41bfdb148a71c90e39aa1d3484634fffb53d9)'

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
set scripts_dir /data/repos/phnaharris-machos/scripts
fish_add_path $scripts_dir/*
fish_add_path $HOME/.cargo/bin
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
    set_color brgreen; echo -n (prompt_pwd --full-length-dirs=5 --dir-length=1)
	set_color green; printf '%s ' (__fish_git_prompt)
	set_color red; echo -n '$ '
end
