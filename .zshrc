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
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

# aliases
alias cls="clear"
alias gst="git status"
alias gaa="git add --all"
alias gc="git commit"
# alias argocd="argocd --grpc-web"

# MacOS specific aliases (i.e. don't use these when on a linux system via ssh)
if [[ "$(uname)" = "Darwin" ]]; then
    alias ls="eza --group-directories-first"
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
setopt AUTO_PUSHD           # Push dirs onto stack automatically
setopt PUSHD_SILENT         # Don't print dir stack after pushd/popd

zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.config/zsh/.zcompcache"
zstyle ':completion:*' complete true

zle -C alias-expension complete-word _generic
zstyle ':completion:alias-expension:*' completer _expand_alias

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors 'ma=0;30;47'
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification # sort completions based on modification date

# zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
# zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
# zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
# zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

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
# source $ZDOTDIR/.zsh_plugins.sh

# FZF
# tokyonight
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
# 	--color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7
# 	--color=fg+:#c0caf5,bg+:#1a1b26,hl+:#7dcfff
# 	--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff
# 	--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a'
# apprentice
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#     --color=fg:#bcbcbc,bg:#262626,hl:#5f87af
#     --color=fg+:#ececec,bg+:#1c1c1c,hl+:#87afd7
#     --color=info:#5f875f,prompt:#af5f5f,pointer:#5f875f
#     --color=marker:#87af87,spinner:#ff8700,header:#8787af'
# gruvbox-material
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#d4be98,bg:#1d2021,hl:#7daea3
    --color=fg+:#ddc7a1,bg+:#282828,hl+:#89b482
    --color=info:#a9b665,prompt:#ea6962,pointer:#d3869b
    --color=marker:#d8a657,spinner:#e78a4e,header:#e78a4e'

# gcloud
if [ -f "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc" ]; then . "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc" ]; then . "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"; fi

# Starship prompt
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# syntax highlighting & autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#808080'
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# disable underline on paths
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=cyan'

# direnv
eval "$(direnv hook zsh)"


alias claude="$HOME/.claude/local/claude"

# extract archives
extract() {
  if [[ -f "$1" ]]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.tar.xz)  tar xJf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.7z)      7z x "$1" ;;
      *) echo "Unknown archive format" ;;
    esac
  fi
}

# Added by Antigravity
export PATH="/Users/filip/.antigravity/antigravity/bin:$PATH"
