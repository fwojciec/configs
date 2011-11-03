# Source .profile and .bashrc if they exist
[[ -f "$HOME/.profile" ]] && . $HOME/.profile
[[ -f "$HOME/.bashrc" ]] && . $HOME/.bashrc

# Load RVM function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
