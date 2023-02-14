#!/usr/bin/env bash

tmux_cht_language=~/Repos/dotfiles/scripts/bin/.tmux-cht-language
tmux_cht_command=~/Repos/dotfiles/scripts/bin/.tmux-cht-command

selected=$(cat $tmux_cht_language $tmux_cht_command | fzf)

if [[ -z $selected ]]; then
	exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" $tmux_cht_language; then
	query=$(echo $query | tr ' ' '+')
	tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
	tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
