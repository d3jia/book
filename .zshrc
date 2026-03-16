# ---- Zsh completion init (must be early) ----
autoload -Uz compinit
compinit

# ---- Python ---- 
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
alias py=python3
alias python=python3

VZ() { vim ~/.zshrc }
SZ() { source ~/.zshrc }
VV() { vim ~/.vimrc }

# ---- DJ Alias Modules Loader ----   ← ADD HERE
for f in ~/.zsh/*.zsh; do
  [ -r "$f" ] && source "$f"
done
unset f

TFGB(){ f="graph_$(date '+%d%b%Y').html"; terraform graph | terraform-graph-beautifier > "$f" && open "$f"; }

# ---- Starship ----
# Git branch / Exit codes/  Python version / Terraform context/  Kube context / Fast startup / Clean config
eval "$(starship init zsh)"

# Created by `pipx` on 2026-01-17 12:16:19
export PATH="$PATH:/Users/dejiawang/.local/bin"
