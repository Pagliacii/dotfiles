#!/usr/bin/env bash
# Dmenu script for launching surfaw, a command line search utility.

function call_dmenu() {
    declare -a inputs
    while IFS= read -r data; do
        inputs+=("${data}")
    done
    font="TerminessTTF Nerd Font Mono:style=Bold:pixelsize=32"
    foreground="#b7e8fb"
    background="#2f343f"
    selforeground="#2f343f"
    selbackground="#64aeef"
    prompt="⚙ ${1:-"dmenu"}"
    printf '%s\n' "${inputs[@]}" | dmenu -i -p "$prompt" \
        -fn "$font" \
        -nf "$foreground" -nb "$background" \
        -sf "$selforeground" -sb "$selbackground"
}

while [ -z "$engine" ]; do
engine=$(sr -elvi | gawk '{if (NR!=1) { print $1 }}' | call_dmenu "Search via") || exit
done

while [ -z "$query" ]; do
query=$(echo "" | call_dmenu "Searching $engine") || exit
done

urxvt -e sr "$engine" "$query"
