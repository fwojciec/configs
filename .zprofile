export ZDOTDIR=$HOME/.config/zsh
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin
export LANG=en_US.UTF-8
export EDITOR="/usr/local/bin/nvim"

# GoLang configuration
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# rust cargo
export PATH=$HOME/.cargo/bin:$PATH

# dotnet
export PATH=$HOME/.dotnet:$PATH

# Java
export JAVA_HOME=$(/usr/libexec/java_home)
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home

# Lazy load pyenv-virtualenv
export ZSH_PYENV_LAZY_VIRTUALENV=true
export PYENV_VIRTUALENV_DISABLE_PROMPT=true

# Lazy load nvm
# export NVM_COMPLETION=false
# export NVM_LAZY_LOAD=true

# neovim path
# export PATH=$HOME/temp/neovim/build/bin:$PATH

# DynamoDB local
# export DDBLOCAL_LIB=$HOME/.ddblocal/DynamoDBLocal_lib
# export DDBLOCAL_JAR=$HOME/.ddblocal/DynamoDBLocal.jar

# Haskell
source $HOME/.ghcup/env
export PATH="/opt/homebrew/opt/llvm@12/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm@12/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm@12/include"

# Rust
export PATH=$HOME/.cargo/bin:$PATH

# Homebrew
export PATH=/opt/homebrew/bin:$PATH

# Ocaml
[[ ! -r $HOME/.opam/opam-init/init.zsh ]] || source $HOME/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Rancher desktop
export PATH="/Users/filip/.rd/bin:$PATH"
