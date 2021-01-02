# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/$(whoami)/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
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
# DISABLE_MAGIC_FUNCTIONS="true"

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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    alias-finder
    autojump
    branch
    brew
    cargo
    colored-man-pages
    colorize
    command-not-found
    common-aliases
    cp
    emacs
    emoji
    encode64
    extract
    fancy-ctrl-z
    fd
    fzf-tab
    git
    git-auto-fetch
    gitignore
    golang
    httpie
    npm
    pip
    pipenv
    poetry
    pyenv
    python
    ripgrep
    rust
    rustup
    safe-paste
    systemd
    thefuck
    ubuntu
    ufw
    urltools
    yarn
    zsh_reload
    zsh-autosuggestions
    zsh-nvm
    zsh-syntax-highlighting
    zsh-wakatime
)

# Plugins configuration
ZSH_COLORIZE_TOOL=pygmentize
ZSH_COLORIZE_STYLE="monokai"

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
[ -f /home/linuxbrew/.linuxbrew/etc/profile.d/autojump.sh ] && . /home/linuxbrew/.linuxbrew/etc/profile.d/autojump.sh

if command -v pyenv 1> /dev/null 2>&1; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

source $ZSH/oh-my-zsh.sh

# User configuration

# History command configurations
HISTSIZE=10000000
SAVEHIST=10000000
## ignore duplicated commands history list
setopt HIST_IGNORE_ALL_DUPS
## share command history data
setopt SHARE_HISTORY

# Load the zcalc, q for quit
autoload -Uz zcalc

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
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Custom environment variables
export PYENV_ROOT="$HOME/.pyenv"
export RUSTUP_DIST_SERVER=https://mirrors.tuna.tsinghua.edu.cn/rustup
export RANGER_LOAD_DEFAULT_RC=false
export GOPATH="$HOME/go"

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

eval "$($(brew --prefix)/bin/starship init zsh)"

# FZF configurations
export FZF_DEFAULT_COMMAND='rg --files --no-messages --no-ignore-vcs --hidden --follow --glob "!{node_modules,.git,.cache,.vscode-server}"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (highlight -O ansi -l {} 2> /dev/null || coderay {} || rougify {} || bat --theme=ansi-dark --color=always {} || cat {}) 2> /dev/null | head -500" --bind "ctrl-n:preview-down,ctrl-p:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up"'
export FZF_ALT_C_OPTS='--preview "tree -C {} | head -200" --bind "ctrl-n:preview-down,ctrl-p:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up"'
export FZF_TMUX_HEIGHT='80%'
export FZF_COMPLETION_TRIGGER='**'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Editor
export EDITOR="vim"
export VISUAL='emacsclient -c -n -a ""'

# Custom aliases
alias checkemacs="ps aux | rg -i emacs"
alias fd="$(brew --prefix)/bin/fd"
alias hexdump="hexyl"
alias killemacs="emacsclient -e '(save-buffers-kill-emacs)'"
alias lc="licensor"
alias ra="ranger"
## using lsd to replace the default ls
alias ls="$(brew --prefix)/bin/lsd"
alias l="ls -alFh"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"
## improve git
alias gcof='git checkout $(git branch | fzf)'
alias code-changes="git log --format=format: --name-only | egrep -v '^$' | sort | uniq -c | sort -rg | head -10"

eval $(thefuck --alias)

# Custom functions
function c() {
    curl -ks cht\.sh/$(
        curl -ks cht\.sh/:list |\
            IFS=+ fzf --preview 'curl -ks cht.sh/{}' -q "$*" \
            --bind "ctrl-n:preview-down,ctrl-p:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up")
}
