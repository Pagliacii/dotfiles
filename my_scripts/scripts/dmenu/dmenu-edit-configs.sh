#!/usr/bin/env bash
# Dmenu script for editing some of my more frequently edited config files.

declare options=("autostart
awesome
awesome_theme
bash
feed
kitty
sxhkd
variety
vim
xinitrc
xmodmap
xprofile
xresources
zsh
quit")

font="TerminessTTF Nerd Font Mono:style=Bold:pixelsize=32"
foreground="#b7e8fb"
background="#2f343f"
selforeground="#2f343f"
selbackground="#64aeef"
choice=$(echo -e "${options[@]}" | dmenu -i -p '⚙ Configs' -h 48 \
    -fn "$font" -nf "$foreground" -nb "$background" -sf "$selforeground" -sb "$selbackground")
terminal="$(which kitty)"

case "$choice" in
    quit)
        echo "Program terminated." && exit 1
    ;;
    autostart)
        choice="$HOME/.config/awesome/autorun.sh"
    ;;
    awesome)
        choice="$HOME/.config/awesome/rc.lua"
    ;;
    awesome_theme)
        choice="$HOME/.config/awesome/themes/powerarrow-jh/theme.lua"
    ;;
    bash)
        choice="$HOME/.bashrc"
    ;;
    feed)
        choice="$HOME/.config/newsboat/urls"
    ;;
    kitty)
        choice="$HOME/.config/kitty/kitty.conf"
    ;;
    sxhkd)
        choice="$HOME/.config/sxhkd/sxhkdrc"
    ;;
    variety)
        choice="$HOME/.config/variety/variety.conf"
    ;;
    vim)
        choice="$HOME/.vim/vimrc"
    ;;
    xinitrc)
        choice="$HOME/.xinitrc"
    ;;
    xmodmap)
        choice="$HOME/.Xmodmap"
    ;;
    xprofile)
        choice="$HOME/.xprofile"
    ;;
    xresources)
        choice="$HOME/.Xresources"
    ;;
    zsh)
        choice="$HOME/.zshrc"
    ;;
    *)
        exit 1
    ;;
esac
source /usr/share/nvm/init-nvm.sh && $terminal -e ${EDITOR:-vim} "$choice"
