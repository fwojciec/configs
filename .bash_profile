# Source .profile and .bashrc if they exist
[[ -f "$HOME/.profile" ]] && . $HOME/.profile
[[ -f "$HOME/.bashrc" ]] && . $HOME/.bashrc

# Load RVM function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Keychain
if [[ -x /usr/bin/keychain || -x $HOME/bin/keychain ]]; then
  [[ -f ${HOME}/.ssh/id_dsa ]] && keychain -q --nolock ${HOME}/.ssh/id_dsa
  [[ -f ${HOME}/.ssh/id_rsa ]] && keychain -q --nolock ${HOME}/.ssh/id_rsa
  . "${HOME}/.keychain/${HOSTNAME}-sh" > /dev/null
fi

# Loads bash_completion in OSX
if [ $(uname) == "Darwin" ]; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

export PATH=/usr/local/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/filip/.rvm/bin

if [ -d $HOME/bin ]; then
    export PATH=$HOME/bin:$PATH
fi

# Pyenv configuration
# if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Iterm2 shell integration enable
# test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
