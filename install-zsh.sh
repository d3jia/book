#!/usr/bin/env bash
set -Eeuo pipefail

# Fast-ish, non-interactive setup for: zsh + oh-my-zsh + powerlevel10k + eza (Debian/WSL)
# Notes:
# - This modifies: ~/.zshrc (backs it up if present)
# - It tries APT first; if APT eza isn't available, it falls back to cargo install (installs cargo).
# - Fonts must be configured in Windows Terminal separately (Nerd Font), otherwise icons may look wrong.

export DEBIAN_FRONTEND=noninteractive

log() { printf "\n[%s] %s\n" "$(date +'%F %T')" "$*"; }
have() { command -v "$1" >/dev/null 2>&1; }

log "Refreshing sudo timestamp (may prompt once)..."
sudo -v

log "APT update/upgrade (can be slow on corporate networks)..."
sudo apt-get update -y
sudo apt-get upgrade -y

log "Installing base packages: zsh git curl unzip (and ca-certificates)..."
sudo apt-get install -y --no-install-recommends \
  zsh git curl unzip ca-certificates

log "Setting zsh as default shell for user '$USER'..."
if have zsh; then
  chsh -s "$(command -v zsh)" "$USER" || true
else
  log "ERROR: zsh not found after install."
  exit 1
fi

log "Installing Oh My Zsh (keeps existing ~/.zshrc if present)..."
export RUNZSH=no
export KEEP_ZSHRC=yes
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  log "Oh My Zsh already present at ~/.oh-my-zsh, skipping."
fi

log "Backing up ~/.zshrc (if it exists)..."
if [ -f "$HOME/.zshrc" ]; then
  cp -a "$HOME/.zshrc" "$HOME/.zshrc.bak.$(date +%Y%m%d%H%M%S)"
fi

log "Installing Powerlevel10k..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
P10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
  log "powerlevel10k already present at $P10K_DIR, skipping."
fi

log "Installing useful zsh plugins: autosuggestions + syntax-highlighting..."
AS_DIR="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
SH_DIR="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

if [ ! -d "$AS_DIR" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$AS_DIR"
else
  log "zsh-autosuggestions already present, skipping."
fi

if [ ! -d "$SH_DIR" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SH_DIR"
else
  log "zsh-syntax-highlighting already present, skipping."
fi

log "Ensuring ~/.zshrc uses P10K and enables plugins + eza aliases..."
# Ensure ZSH is set (Oh My Zsh expects this)
if ! grep -qE '^export ZSH=' "$HOME/.zshrc" 2>/dev/null; then
  # If ~/.zshrc somehow doesn't exist, seed it from template
  if [ ! -f "$HOME/.zshrc" ] && [ -f "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" ]; then
    cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc"
  fi
fi

# Theme: set/replace ZSH_THEME line
if grep -qE '^[[:space:]]*ZSH_THEME=' "$HOME/.zshrc"; then
  sed -i 's|^[[:space:]]*ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$HOME/.zshrc"
else
  printf '\nZSH_THEME="powerlevel10k/powerlevel10k"\n' >> "$HOME/.zshrc"
fi

# Plugins: replace plugins=(...) line if present, otherwise append
if grep -qE '^[[:space:]]*plugins=\(' "$HOME/.zshrc"; then
  sed -i 's|^[[:space:]]*plugins=(.*|plugins=(git zsh-autosuggestions zsh-syntax-highlighting)|' "$HOME/.zshrc"
else
  printf '\nplugins=(git zsh-autosuggestions zsh-syntax-highlighting)\n' >> "$HOME/.zshrc"
fi

# eza aliases (only add once)
if ! grep -q 'alias ll=.*eza' "$HOME/.zshrc" 2>/dev/null; then
  cat >> "$HOME/.zshrc" <<'EOF'

# --- eza aliases ---
alias ls='eza --group-directories-first'
alias ll='eza -lah --group-directories-first'
alias lt='eza --tree --group-directories-first'
EOF
fi

log "Installing eza..."
if sudo apt-get install -y --no-install-recommends eza; then
  log "Installed eza via apt."
else
  log "APT couldn't install eza (package missing or repo issue). Falling back to cargo install..."
  sudo apt-get install -y --no-install-recommends cargo
  if ! have cargo; then
    log "ERROR: cargo not available after install."
    exit 1
  fi
  cargo install eza

  # Ensure cargo bin path in zshrc (only add once)
  if ! grep -q 'export PATH="$HOME/.cargo/bin:$PATH"' "$HOME/.zshrc" 2>/dev/null; then
    printf '\nexport PATH="$HOME/.cargo/bin:$PATH"\n' >> "$HOME/.zshrc"
  fi
fi

log "Done."
cat <<'MSG'

Next steps:
1) Close and reopen your Debian tab in Windows Terminal (so default shell change takes effect).
2) Set a Nerd Font in Windows Terminal (Settings -> Debian profile -> Appearance -> Font face),
   e.g. "MesloLGS NF", otherwise Powerlevel10k icons may look wrong.
3) Start zsh and run:  p10k configure

MSG
