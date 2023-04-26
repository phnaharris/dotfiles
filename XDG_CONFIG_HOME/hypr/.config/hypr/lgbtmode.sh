#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==2{print $2}')
if [ "$HYPRGAMEMODE" = 0 ]; then
	hyprctl --batch "\
        keyword animations:enabled 1;\
        keyword decoration:drop_shadow 1;\
        keyword decoration:blur 1;\
        keyword general:gaps_in 2;\
        keyword general:gaps_out 2;\
        keyword decoration:rounding 1"
	exit
fi
hyprctl reload
