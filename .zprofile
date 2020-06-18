export LC_ALL=en_US.UTF-8

# WSL hack
if [[ "$(umask)" = "000" ]]; then
    umask 022
fi

export PATH="$HOME/.cargo/bin:$PATH"
