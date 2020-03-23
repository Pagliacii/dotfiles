# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/pagliacii/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
theme="spaceship"
[ "$theme" = "powerlevel9k/powerlevel9k" ] && [ -f "$HOME/.config/powerlevel9k/config" ] && source $HOME/.config/powerlevel9k/config
ZSH_THEME="$theme"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    # autojump
    colored-man-pages
    emoji
    fzf-tab
    git
    python
    vscode
    wakatime
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# History command configurations
HISTSIZE=10000000
SAVEHIST=10000000
setopt HIST_IGNORE_ALL_DUPS # ignore duplicated commands history list
setopt SHARE_HISTORY        # share command history data

autoload -Uz zcalc          # load the zcalc, q for quit

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias reload="source ~/.zshrc && clear"
alias zshconfig="vim ~/.zshrc"
alias ls="$(which lsd)"
alias cat="$(which bat)"
alias less="$(which bat)"
alias nano="$(which kibi)"
alias hexdump="$(which hexyl)"
alias lc="$(which licensor)"
alias http-server="$(which miniserve) -c ArchLinux"
alias vi="$(which vim)"

# export GPG_TTY="$(tty)"
# export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
# gpgconf --launch gpg-agent

# if [ -f "${HOME}/.gpg-agent-info" ]; then
# 	source "${HOME}/.gpg-agent-info"
# 	export GPG_AGENT_INFO
# 	export SSH_AUTH_SOCK
# 	export SSH_AGENT_PIG
# else
# 	eval $( gpg-agent --daemon --write-env-file ~/.gpg-agent-info )
# fi

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$GOROOT/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# FZF Options
export FZF_DEFAULT_COMMAND='rg --files --no-messages --no-ignore-vcs --hidden --follow --glob "!{node_modules,.git,.cache}"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (highlight -O ansi -l {} || coderay {} || rougify {} || bat {} || cat {}) 2> /dev/null | head -500" --bind "ctrl-n:preview-down,ctrl-p:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up"'
export FZF_TMUX_HEIGHT='80%'
export FZF_COMPLETION_TRIGGER='**'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Ranger
alias ra=$(which ranger)
export RANGER_LOAD_DEFAULT_RC=FALSE

# Rust
# export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup

export VISUAL="$(which vim)"
export EDITOR=$VISUAL

# node.js
source /usr/share/nvm/init-nvm.sh

fpath=(~/.zsh.d/ $fpath)
fpath+=~/.zfunc
compinit

# pipenv
eval "$(pipenv --completion)"
# thefuck
eval $(thefuck --alias)
# starship
eval "$(starship init zsh)"