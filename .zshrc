# enable colors
autoload -U colors && colors

# disable vi mode
bindkey -e

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.cache/zsh/history"
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE

# aliases
alias grep="grep --color=auto"
alias cls="clear"
alias glint="golangci-lint run --no-config"
alias ls="ls -hF --color=auto --group-directories-first"
alias pev="pyenv version"

# MacOS specific aliases (i.e. don't use these when on a linux system via ssh)
if [[ "$(uname)" = "Darwin" ]]; then
    alias ls="exa --group-directories-first"
fi

# completion
# see: https://github.com/Phantas0s/.dotfiles/blob/master/zsh/completion.zsh
# https://thevaluable.dev/zsh-completion-guide-examples/
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# prompt
# autoload -U promptinit; promptinit
# prompt pure

zmodload zsh/complist
bindkey -M menuselect 'h' backward-char
bindkey -M menuselect 'k' up-line-or-history
bindkey -M menuselect 'j' down-line-or-history
bindkey -M menuselect 'l' forward-char

autoload -Uz compinit; compinit
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

# history search
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey '^k' history-beginning-search-backward-end 
bindkey '^j' history-beginning-search-forward-end 

# back/forward word bindings
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^B" backward-word
bindkey "^F" forward-word

[ -f "$ZDOTDIR/.fzf.zsh" ] && source "$ZDOTDIR/.fzf.zsh"

# Antibody static plugins
source $ZDOTDIR/.zsh_plugins.sh

# FZF
export FZF_DEFAULT_COMMAND='fd --type f'

# GRUVBOX COLORS
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--layout=reverse --inline-info
--color fg:#ebdbb2,bg:#1d2021,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
--color info:#76a065,prompt:#bdae93,spinner:#fabd2f,pointer:#76a065,marker:#fe8019,header:#665c54'
# SUBSTRATA COLORS
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#  --color=fg:#b5b4c9,bg:#191c25,hl:#8296b0
#  --color=fg+:#f0ecfe,bg+:#272935,hl+:#a0b9d8
#  --color=info:#659ea2,prompt:#cf8164,pointer:#fe9f7c
#  --color=marker:#7dc2c7,spinner:#cf8164,header:#87afaf'
# NORD COLORS
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#     --color=fg:#e5e9f0,bg:#2e3440,hl:#81a1c1
#     --color=fg+:#e5e9f0,bg+:#2e3440,hl+:#81a1c1
#     --color=info:#ebcb8b,prompt:#bf616a,pointer:#b48ead
#     --color=marker:#a3be8c,spinner:#b48ead,header:#a3be8c'
# ONEDARK COLORS
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
# --color=dark
# --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
# --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef'

# gcloud
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

# Starship prompt
eval "$(starship init zsh)"
