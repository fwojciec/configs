# ~/.zshrc — interactive shell only. PATH and env live in ~/.zprofile.
# Rule: never alias over a standard command (ls, cat, grep...). Agents replay
# these aliases and expect the real tools.

BREW=/opt/homebrew

# vi mode
bindkey -v
bindkey "^?" backward-delete-char
KEYTIMEOUT=1

# history
HISTFILE=~/.local/share/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_SPACE HIST_IGNORE_DUPS HIST_REDUCE_BLANKS
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "^k" history-beginning-search-backward-end
bindkey "^j" history-beginning-search-forward-end

# aliases (new names only, see rule above)
alias ll="eza -l --group-directories-first"
alias la="eza -la --group-directories-first"
alias cls="clear"
alias gst="git status"
alias gaa="git add --all"
alias gc="git commit"
alias gpm="git checkout main && git pull"
alias gemini='NODE_OPTIONS="--disable-warning=DEP0040" gemini'

# directory stack
setopt AUTO_PUSHD PUSHD_SILENT

# completion
FPATH="$BREW/share/zsh/site-functions:${FPATH}"
zmodload zsh/complist
autoload -U compinit; compinit
_comp_options+=(globdots)
setopt AUTO_LIST COMPLETE_IN_WORD
bindkey -M menuselect 'h' backward-char
bindkey -M menuselect 'k' up-line-or-history
bindkey -M menuselect 'j' down-line-or-history
bindkey -M menuselect 'l' forward-char
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.config/zsh/.zcompcache"
zstyle ':completion:*' complete true
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors 'ma=0;30;47'
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' group-name ''
zstyle ':completion:*' keep-prefix true
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
zle -C alias-expansion complete-word _generic
zstyle ':completion:alias-expansion:*' completer _expand_alias
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
[ -f "$BREW/share/google-cloud-sdk/completion.zsh.inc" ] && source "$BREW/share/google-cloud-sdk/completion.zsh.inc"

# edit command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

# fzf (gruvbox-material colors)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#d4be98,bg:#1d2021,hl:#7daea3
    --color=fg+:#ddc7a1,bg+:#282828,hl+:#89b482
    --color=info:#a9b665,prompt:#ea6962,pointer:#d3869b
    --color=marker:#d8a657,spinner:#e78a4e,header:#e78a4e'

# prompt, cd, tool versions, per-directory env
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
command -v mise >/dev/null && eval "$(mise activate zsh)"
eval "$(direnv hook zsh)"

# syntax highlighting & autosuggestions (must come last)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#808080'
source $BREW/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $BREW/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=cyan'

# extract archives
extract() {
  [[ -f "$1" ]] || { echo "no such file: $1"; return 1; }
  case "$1" in
    *.tar.bz2) tar xjf "$1" ;;
    *.tar.gz)  tar xzf "$1" ;;
    *.tar.xz)  tar xJf "$1" ;;
    *.zip)     unzip "$1" ;;
    *.gz)      gunzip "$1" ;;
    *.7z)      7z x "$1" ;;
    *) echo "Unknown archive format" ;;
  esac
}
