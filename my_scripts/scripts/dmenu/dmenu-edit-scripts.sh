#!/usr/bin/env bash
# Dmenu script for editing all dmenu scripts.

declare scripts=("edit-configs
edit-scripts
reddio
surfraw
sysmon
trading
prompt
quit")

font="TerminessTTF Nerd Font Mono:style=Bold:pixelsize=32"
foreground="#b7e8fb"
background="#2f343f"
selforeground="#2f343f"
selbackground="#64aeef"
script=$(echo -e "${scripts[@]}" | dmenu -i -p '⚙ Dmenu Scripts' -h 48 \
    -fn "$font" -nf "$foreground" -nb "$background" -sf "$selforeground" -sb "$selbackground")
terminal="$(which kitty)"

case "$script" in
    quit)
        echo "Program terminated." && exit 1
        ;;
    edit-configs| \
    edit-scripts| \
    reddio| \
    surfraw| \
    sysmon| \
    trading| \
    prompt)
        script="$HOME/scripts/dmenu/dmenu-${script}.sh"
        ;;
    *)
        exit 1
        ;;
esac
source /usr/share/nvm/init-nvm.sh && $terminal -e ${EDITOR:-vim} "$script"
