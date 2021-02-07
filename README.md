## Dotfiles

Here are some configuration files of my Linux environment. Link to home directory by [GNU Stow](https://www.gnu.org/software/stow/).

### Usage

```shell
$ git clone --recurse-submodules https://github.com/Pagliacii/dotfiles
$ cd dotfiles
# link all
$ stow
# or link some config, e.g. vim
$ stow vim
```

### Install Oh my zsh

```shell
# Make sure you have curl (or wget) and git installed
# Install homebrew
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Install starship, thefuck and autojump
$ brew install starship thefuck autojump
# Use any way you like to install ZSH
# Install Oh My ZSH
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$ rm ~/.zshrc
$ git clone --recurse-submodules https://github.com/Pagliacii/dotfiles
# or
# $ git clone https://github.com/Pagliacii/dotfiles
# $ cd dotfiles
# $ git submodule update --init
$ cd dotfiles
$ stow zsh
$ stow starship
$ source ~/.zshrc
```

### Install Doom Emacs

```shell
# Make sure you have emacs installed
$ git clone --recurse-submodules https://github.com/Pagliacii/dotfiles
$ cd dotfiles
# link
$ stow doom-emacs
# install Doom Emacs
$ ~/.emacs.d/bin/doom install
# check installation
$ ~/.emacs.d/bin/doom doctor
# fix warnings showing up to improve your Doom Emacs running environment
# add `~/.emacs.d/bin` to your PATH envvar
$ echo 'export PATH="$HOME/.emacs.d/bin:$PATH"' >> ~/.zshrc
$ source ~/.zshrc
# download some fonts to ~/.local/share/fonts and run command below
$ fc-cache -vf ~/.local/share/fonts
```

