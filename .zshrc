# enable colors
autoload -U colors && colors

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# aliases
alias cp="cp -v"
alias grep="grep --color=auto"
alias mv="mv -v"
alias rm="rm -v"
alias cls="clear"
alias glint="golangci-lint run --no-config"
alias ls="ls -hF --color=auto --group-directories-first"
alias ssh="TERM=screen-256color ssh"
alias tmux="tmux -u"

# Mac-only aliases
if [[ `uname` = "Darwin" ]]; then
	alias ls="gls -hF --color=auto --group-directories-first"
fi

# Edit line in vim with ctrl-v:
autoload edit-command-line; zle -N edit-command-line
bindkey '^v' edit-command-line

# Autocompletion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Antibody static plugins
source $ZDOTDIR/.zsh_plugins.sh

# Local settings
if [ -f $ZDOTDIR/.zshrc_local ]; then
    source $ZDOTDIR/.zshrc_local
fi

# Fix some keybindings
# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

bindkey -e
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
bindkey -M emacs "${terminfo[khome]}" beginning-of-line
bindkey -M emacs "${terminfo[kend]}"  end-of-line

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color fg:#ebdbb2,bg:#1d2021,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
--color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54'


# Starship prompt
eval "$(starship init zsh)"
