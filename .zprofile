export LC_ALL=en_US.UTF-8

# WSL hack
if [[ "$(umask)" = "000" ]]; then
    umask 022
fi

# rust cargo
export PATH="$HOME/.cargo/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
