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
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
