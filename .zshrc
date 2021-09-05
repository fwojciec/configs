# enable colors
autoload -U colors && colors

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

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

autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zmodload zsh/complist
compinit
_comp_options+=(globdots)
# autoload bashcompinit
# bashcompinit

# Antibody static plugins
source $ZDOTDIR/.zsh_plugins.sh

# keybindings and stuff
bindkey -v
export KEYTIMEOUT=1

# restore backspace functionality
bindkey "^?" backward-delete-char

# history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^k' up-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search # Up
bindkey '^[[B' down-line-or-beginning-search # Down

# enable bracket word objects in vi mode
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
	for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
		bindkey -M $m $c select-bracketed
	done
done

# enable quote word objects in vi mode
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
	for c in {a,i}{\',\",\`}; do
		bindkey -M $m $c select-quoted
	done
done

# Edit line in vim with ctrl-v:
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
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

# Rust
source $HOME/.cargo/env

# Starship prompt
eval "$(starship init zsh)"
