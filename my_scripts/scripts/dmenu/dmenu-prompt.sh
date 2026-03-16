#!/usr/bin/env bash

function usage() {
    echo "Usage: $0 <prompt string> <command>"
}

if [ $# -ne 2 ]; then
    usage && exit 1
fi

prompt="⚙ $1"
cmd="$2"
font="TerminessTTF Nerd Font Mono:style=Bold:pixelsize=32"
foreground="#b7e8fb"
background="#2f343f"
selforeground="#2f343f"
selbackground="#64aeef"

declare options=("yes
no")
choice=$(echo -e "${options[@]}" | dmenu -i -p "$prompt" -h 48 \
    -fn "$font" -nf "$foreground" -nb "$background" -sf "$selforeground" -sb "$selbackground")

case "$choice" in
    no)
        echo "Program terminated." && exit 1
        ;;
    yes)
        exec $cmd
        ;;
esac
