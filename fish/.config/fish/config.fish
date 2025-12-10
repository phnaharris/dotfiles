if status --is-interactive
	if ! set -q TMUX
        tmux attach-session -t "$USER" || tmux new-session -s "$USER"
	end
end

theme_gruvbox dark hard

# ignore greeting
set -g fish_greeting

setenv EDITOR nvim

abbr -a g git
# abbr -a gah 'git stash; and git pull --rebase; and git stash pop'

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
fish_add_path $HOME/bin
fish_add_path $HOME/bin/dev
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/share/nvim/mason/bin

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
