#!/bin/bash

declare -a options=("htop
glances
gtop
iftop
iotop
iptraf-ng
nmon
s-tui
quit")

font="TerminessTTF Nerd Font Mono:style=Bold:pixelsize=32"
foreground="#b7e8fb"
background="#2f343f"
selforeground="#2f343f"
selbackground="#64aeef"
choice=$(echo -e "${options[@]}" | dmenu -l -i -p '⚙ System monitors' -h 48 \
    -fn "$font" -nf "$foreground" -nb "$background" -sf "$selforeground" -sb "$selbackground")
terminal=${TERMINAL:-$(which alacritty)}

case $choice in
	quit)
		echo "Program terminated." && exit 1
	;;
	htop| \
	glances| \
	gtop| \
	nmon| \
	s-tui)
        exec $terminal -e $choice
	;;
	iftop| \
	iotop| \
	iptraf-ng)
        exec $terminal -e pkexec $choice
	;;
	*)
		exit 1
	;;
esac

