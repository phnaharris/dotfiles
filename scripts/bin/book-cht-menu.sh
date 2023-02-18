#!/usr/bin/env bash

book=/DATA/PERSONAL/Book

[ -f $book ] && readarray -t folders <$book

selected=$(find $book -iname '*.pdf' | wofi --dmenu)
selected=$(echo $selected | tr ' ' '\ ')

if [[ -z $selected ]]; then
	exit 0
fi

zathura --fork $selected
exit 0
