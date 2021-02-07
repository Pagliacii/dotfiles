# Dotfiles

Here are some configuration files of my Linux environment. Link to home directory by [GNU Stow](https://www.gnu.org/software/stow/).

## Usage

```shell
$ git clone --recurse-submodules https://github.com/Pagliacii/dotfiles
$ cd dotfiles
# link all
$ stow
# or link some config, e.g. vim
$ stow vim
```

## Install Oh My Zsh

```shell
# Make sure you have curl (or wget) and git installed
# Install homebrew
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Install starship, thefuck and autojump
$ brew install starship thefuck autojump
# Use any way you like to install Zsh
# Install Oh My Zsh
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

## Prepare Python Dev Env

```shell
# Install pyenv and pyenv-virtualenv
$ brew install pyenv pyenv-virtualenv
# Install Python build dependencies before attempting to install a new Python version. See pyenv docs
# Install the specific version of Python, replace <version> with the actual version
$ pyenv install <version>
# You can list all supported versions by `pyenv install --list`
# Install the Python dev package like: python3-dev

# link pip to replace the pypi source
$ cd dotfiles && stow pip

# Install poetry
$ curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
# If the last step was stuck at downloading the poetry package, you can download the package manually
# See https://github.com/python-poetry/poetry/releases for more details.
# And run commands below to install it manually
$ wget https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py
$ python get-poetry.py --file /path/to/poetry-<version>-<platform>.tar.gz
# Verify
$ poetry --version
# Enable tab completion for Oh My Zsh
$ md $ZSH_CUSTOM/plugins/poetry
$ poetry completions zsh > $ZSH_CUSTOM/plugins/poetry/_poetry

# Install IPython
$ pip install ipython
# Install pipx
$ brew install pipx
$ pipx ensurepath
$ pipx completions
```

## Install Doom Emacs

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

## Install useful tools

```shell
# Install fzf via homebrew or any way you like
$ brew install fzf
# To install useful key bindings and fuzzy completion
$ $(brew --prefix)/opt/fzf/install
# Install bat
$ brew install bat
# Install ripgrep
$ brew install ripgrep
# Install fd
$ brew install fd
# Install hyperfine
$ brew install hyperfine
# Install hexyl
$ brew install hexyl
# Install lsd
$ brew install lsd
# Install pygments for colorize
$ brew install pygments
```

