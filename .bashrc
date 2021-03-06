# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export CLICOLOR=1
export LSCOLORS=FxFxCxDxBxegedabagacad

# On OS X / homebrew makes coreutils use standard names
if [ $(uname) == "Darwin" ]; then
  PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/sbin:$PATH"
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
#  if [ -f /usr/local/bin/python3 ]; then
#      alias python='python3'
#      alias pip='pip3'
#  fi
fi

# Dircolors
eval `dircolors -b ~/.dircolors`

# Environmental variables
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export MANPAGER=less
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=10000
export HISTFILESIZE=MQ10000
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Bash completion
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi


# Aliases:
if [ -f ~/.bash_aliases_local ]; then
  . ~/.bash_aliases_local
fi
alias cp="cp -v"
alias grep="grep --color=auto"
alias ls="ls -hF --color=auto --group-directories-first"
alias mv="mv -v"
alias rm="rm -v"
alias cls="clear"

# Arch Linux specific
if [ -f /usr/bin/pacman ]; then
  alias pacman="sudo pacman"
fi

# Git prompt
if [ -f /usr/share/git/git-prompt.sh ]; then
  . /usr/share/git/git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="auto"

if [ -f "$(brew --prefix bash-git-prompt)/share/gitprompt.sh" ]; then
    GIT_PROMPT_THEME=Default
    source "$(brew --prefix bash-git-prompt)/share/gitprompt.sh"
fi


# Prompt
BOLD="\033[1m"
GREEN="\033[32m"
RESET="\033[0m"
BLUE="\033[34m"
RED="\033[31m"
YELLOW="\033[33m"
PINK="\033[35m"
LIGHT_GRAY="\[\033[0;37m\]"

function prompt_func() {
    if [ `/usr/bin/whoami` != "root" ]; then
        PS1="[${BOLD}${BLUE}\H${RESET}] ${GREEN}\w${RESET}${VIRTUAL_ENV:+$LIGHT_GRAY (`basename $VIRTUAL_ENV`)$RESET}${YELLOW}`__git_ps1`${RESET}\n> "
    else
        PS1="[${BOLD}${BLUE}\H${RESET}] ${RED}\w${RESET}${GP}\n> "
    fi
}

PROMPT_COMMAND=prompt_func

### Bash options
shopt -s cdspell
shopt -s histappend
shopt -s checkwinsize
complete -cf sudo
#set -o noclobber
set -o ignoreeof
#set -o nounset
shopt -s extglob
shopt -s cmdhist
shopt -s no_empty_cmd_completion
shopt -u promptvars
unset LESSCHARSET

#Extract
function x()
{
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)  tar xjf "$1"      ;;
            *.tar.gz)   tar xzf "$1"      ;;
            *.tar.Z)    tar xzf "$1"      ;;
            *.bz2)      bunzip2 "$1"      ;;
            *.rar)      unrar x "$1"      ;;
            *.gz)       gunzip "$1"       ;;
            *.jar)      unzip "$1"        ;;
            *.tar)      tar xf "$1"       ;;
            *.tbz2)     tar xjf "$1"      ;;
            *.tgz)      tar xzf "$1"      ;;
            *.zip)      unzip "$1"        ;;
            *.Z)        uncompress "$1"   ;;
            *.7z)       7z x "$1"         ;;
            *)          echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a file"
    fi
}

#Iterm 2 Shell integration

# if [ -f $HOME/.iterm2_shell_integration.`basename $SHELL` ]; then
# 	source ~/.iterm2_shell_integration.`basename $SHELL`
# fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
