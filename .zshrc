# Path
export PATH=$HOME/bin:/usr/local/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/filip/.rvm/bin

# Path to your oh-my-zsh installation.
export ZSH=/Users/filip/.oh-my-zsh

# Custom configuration
ZSH_CUSTOM=$HOME/configs/.oh_my_zsh_custom

# ZSH theme
ZSH_THEME="my-agnoster"
DEFAULT_USER="filip"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew django virtualenv)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

alias cp="cp -v"
alias grep="grep --color=auto"
alias ls="ls -hF --color=auto --group-directories-first"
alias mv="mv -v"
alias rm="rm -v"
alias cls="clear"

