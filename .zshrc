# Keybindings
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

# Path
# COREUTILS_PATH=/usr/local/opt/coreutils/libexec/gnubin
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.rvm/bin:$HOME/.local/bin

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Custom configuration
ZSH_CUSTOM=$HOME/configs/.oh_my_zsh_custom

# ZSH theme
ZSH_THEME="spaceship"
DEFAULT_USER="filip"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-machine docker-compose fzf go)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

alias cp="cp -v"
alias grep="grep --color=auto"
alias mv="mv -v"
alias rm="rm -v"
alias cls="clear"
alias e="nvim"
alias glint="golangci-lint run"
alias ls="ls -hF --color=auto --group-directories-first"
if [[ `uname` = "Darwin" ]]; then
	alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
	alias ctags="`brew --prefix`/bin/ctags"
	alias ls="gls -hF --color=auto --group-directories-first"
fi
if [[ `uname` = "Linux" ]]; then
	alias pgstart="sudo service postgresql start"
	alias pgrun="sudo -u postgres psql"
fi


# GoLang configuration
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Disables shared history
unsetopt share_history

# Haskell ghcup
if [ -f "$HOME/.ghcup/env" ]; then
	source $HOME/.ghcup/env
fi

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^z' edit-command-line

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--color=bg+:#3B4252,bg:#2E3440,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1,marker:#81A1C1,fg+:#D8DEE9,prompt:#81A1C1,hl+:#81A1C1"

# autocompletion initialization
autoload -Uz compinit; compinit
fpath+=${ZDOTDIR:-~}/.zsh_functions
