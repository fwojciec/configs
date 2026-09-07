# ~/.zprofile — login shell: PATH and environment.
# Everything here is visible to non-interactive tools and LLM agents.
# Keep interactive-only config (prompt, keybindings, completion) in ~/.zshrc.

export LANG=en_US.UTF-8
export EDITOR="/opt/homebrew/bin/nvim"
export JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home
export BUN_INSTALL="$HOME/.bun"

# PATH, highest priority first. Later lines prepend, so the last line wins.
export PATH="$PATH:$HOME/.docker/bin"
export PATH="/opt/homebrew/share/google-cloud-sdk/bin:$PATH"
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Secrets live outside version control.
[[ -f ~/.secrets ]] && source ~/.secrets

# brier sops operator key (runbook: First-time handoff PR O3).
# Note: invokes 1Password, which can hang an unattended agent that runs sops.
export SOPS_AGE_KEY_CMD='op read --account my.1password.com "op://Private/brier-sops-age/password"'
