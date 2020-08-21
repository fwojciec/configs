# Keybindings
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

# Path
# COREUTILS_PATH=/usr/local/opt/coreutils/libexec/gnubin
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Custom configuration
ZSH_CUSTOM=$HOME/configs/.oh_my_zsh_custom

# ZSH theme
# ZSH_THEME="spaceship"
ZSH_THEME=""
DEFAULT_USER="filip"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose fzf golang pyenv gcloud)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

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
alias glint="golangci-lint run"
alias ls="ls -hF --color=auto --group-directories-first"
alias ssh="TERM=screen-256color ssh"
alias tmux="tmux -u"
# alias vim="nvim"
if [[ `uname` = "Darwin" ]]; then
	alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
	alias ctags="`brew --prefix`/bin/ctags"
	alias ls="gls -hF --color=auto --group-directories-first"
fi

# GoLang configuration
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Disables shared history
# unsetopt share_history

# Edit line in vim with ctrl-v:
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color fg:#ebdbb2,bg:#1d2021,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
--color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54'

# rust cargo
export PATH="$HOME/.cargo/bin:$PATH"

# pyenv
if [ -d "$HOME/.pyenv" ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	export PYENV_VIRTUALENV_DISABLE_PROMPT=1
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

# Java
export JAVA_HOME=$(/usr/libexec/java_home)

# Source local customizations
. ~/.zshrc_local

# Starship prompt
eval "$(starship init zsh)"
