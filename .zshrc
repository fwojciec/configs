# enable colors
autoload -U colors && colors

# enable vi mode
bindkey -v
bindkey "^?" backward-delete-char
KEYTIMEOUT=1

# History in cache directory:
HISTFILE=~/.local/share/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE

# aliases
alias cls="clear"

# MacOS specific aliases (i.e. don't use these when on a linux system via ssh)
if [[ "$(uname)" = "Darwin" ]]; then
    alias ls="exa --group-directories-first"
fi

# history search
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "^k" history-beginning-search-backward-end 
bindkey "^j" history-beginning-search-forward-end 

# fzf
[ -f "$ZDOTDIR/.fzf.zsh" ] && source "$ZDOTDIR/.fzf.zsh"

# completion
# see: https://github.com/Phantas0s/.dotfiles/blob/master/zsh/completion.zsh
# https://thevaluable.dev/zsh-completion-guide-examples/
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

zmodload zsh/complist
autoload -U compinit; compinit

bindkey -M menuselect 'h' backward-char
bindkey -M menuselect 'k' up-line-or-history
bindkey -M menuselect 'j' down-line-or-history
bindkey -M menuselect 'l' forward-char

_comp_options+=(globdots)   # With hidden files

# setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.config/zsh/.zcompcache"
zstyle ':completion:*' complete true

zle -C alias-expension complete-word _generic
zstyle ':completion:alias-expension:*' completer _expand_alias

zstyle ':completion:*' menu select
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification # sort completions based on modification date

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' keep-prefix true
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

# Antibody static plugins
source $ZDOTDIR/.zsh_plugins.sh

# FZF
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' 
	--color=fg:#c0caf5,bg:#24283b,hl:#bb9af7
	--color=fg+:#c0caf5,bg+:#24283b,hl+:#7dcfff
	--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff 
	--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a'

# gcloud
if [ -f '/Users/filip/code/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/filip/code/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/filip/code/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/filip/code/google-cloud-sdk/completion.zsh.inc'; fi

# Starship prompt
eval "$(starship init zsh)"

# direnv
eval "$(direnv hook zsh)"
