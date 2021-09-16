# enable colors
autoload -U colors && colors

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_CACHE_HOME/zsh/history"

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

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M menuselect '^xg' clear-screen
bindkey -M menuselect '^xi' vi-insert                      # Insert
bindkey -M menuselect '^xh' accept-and-hold                # Hold
bindkey -M menuselect '^xn' accept-and-infer-next-history  # Next
bindkey -M menuselect '^xu' undo                           # Undo

autoload -Uz compinit; compinit
_comp_options+=(globdots)   # With hidden files

setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' complete true

zle -C alias-expension complete-word _generic
bindkey '^A' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

zstyle ':completion:*' menu select
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification

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

# autoload bashcompinit
# bashcompinit

# vim mode plugin overwrites keybindings, so this is to ensure these are set after vim plugin init
function zvm_config() {
    ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE
}
function zvm_after_init() {
    # history search
    autoload -U up-line-or-beginning-search
    autoload -U down-line-or-beginning-search
    zle -N up-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey '^k' up-line-or-beginning-search
    bindkey '^j' down-line-or-beginning-search
    bindkey '^[[A' up-line-or-beginning-search # Up
    bindkey '^[[B' down-line-or-beginning-search # Down
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}

# Antibody static plugins
source $ZDOTDIR/.zsh_plugins.sh

# FZF
export FZF_DEFAULT_COMMAND='fd --type f'
# GRUVBOX COLORS
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--layout=reverse --inline-info
--color fg:#ebdbb2,bg:#1d2021,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
--color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54'
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

# Starship prompt
eval "$(starship init zsh)"
