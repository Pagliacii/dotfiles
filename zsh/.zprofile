if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi

export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export QT_AUTO_SCREEN_SCALE_FACTOR=1

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$GOROOT/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
