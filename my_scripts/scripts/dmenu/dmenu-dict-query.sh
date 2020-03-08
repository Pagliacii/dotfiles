prompt="⚙ DictQuery: "
font="TerminessTTF Nerd Font Mono:style=Bold:pixelsize=32"
foreground="#b7e8fb"
background="#2f343f"
selforeground="#2f343f"
selbackground="#64aeef"

echo "" | dmenu -i -p "$prompt" -h 48 \
    -fn "$font" -nf "$foreground" -nb "$background" -sf "$selforeground" -sb "$selbackground" | \
    xargs -I '{}' goldendict '{}' > /dev/null 2>&1
