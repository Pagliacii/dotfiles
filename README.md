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

### Install Doom Emacs

```shell
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
```

