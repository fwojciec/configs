# Keybindings
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

# Path
# COREUTILS_PATH=/usr/local/opt/coreutils/libexec/gnubin
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.rvm/bin:$HOME/.local/bin

# Path to your oh-my-zsh installation.
export ZSH=/Users/filip/.oh-my-zsh

# Custom configuration
ZSH_CUSTOM=$HOME/configs/.oh_my_zsh_custom

# ZSH theme
ZSH_THEME="spaceship"
DEFAULT_USER="filip"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

alias cp="cp -v"
alias grep="grep --color=auto"
alias ls="gls -hF --color=auto --group-directories-first"
alias mv="mv -v"
alias rm="rm -v"
alias cls="clear"
alias e="nvim"
alias glint="golangci-lint run"
alias ctags="`brew --prefix`/bin/ctags"
if [[ `uname` = "Darwin" ]]; then
    alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
fi

# Load local Django fairlendar variables
# if [[ -a ~/.fairlendar_vars ]]; then
#     source ~/.fairlendar_vars
# fi

# GoLang configuration
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Disables shared history
unsetopt share_history

# Haskell ghcup
source $HOME/.ghcup/env
