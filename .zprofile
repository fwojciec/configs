export ZDOTDIR=$HOME/.config/zsh
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin
export LANG=en_US.UTF-8
export EDITOR="/usr/local/bin/nvim"

# GoLang configuration
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# rust cargo
export PATH=$HOME/.cargo/bin:$PATH

# Java
export JAVA_HOME=$(/usr/libexec/java_home)

# Lazy load pyenv-virtualenv
export ZSH_PYENV_LAZY_VIRTUALENV=true
