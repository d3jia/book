#!/usr/bin/env bash
set -euo pipefail

####################################
#
# Version: v1.1.0
# Last Modified: 17 Jan 2026
# Installation CMD: curl -fsSL https://gist.githubusercontent.com/d3jia/05e4b54d0231297f78bd1b8293f44421/raw/dj-zsh-aliases-install.sh | bash
# Description: DJ's Zsh modules for core system, eza, kubectl/kubecolor, terraform, and completions.
#
####################################

ZSH_DIR="${HOME}/.zsh"

CORE_FILE="${ZSH_DIR}/20-aliases.core.zsh"
EZA_FILE="${ZSH_DIR}/25-aliases.eza.zsh"
FUNCS_FILE="${ZSH_DIR}/30-functions.nav.zsh"
TF_FILE="${ZSH_DIR}/40-aliases.tf.zsh"
K8S_FILE="${ZSH_DIR}/50-aliases.k8s.zsh"
COMP_FILE="${ZSH_DIR}/90-completions.k8s.zsh"

mkdir -p "${ZSH_DIR}"

# ---- Core Mac System Related Alias ----
cat > "${CORE_FILE}" <<'EOF'
# ---- Core Mac System Related Alias ----
alias c='bat --paging=never --style=plain'
alias v='vim'

EOF

# ---- EZA / Listing + Navigation ----
cat > "${EZA_FILE}" <<'EOF'
# ---- EZA / Listing + Navigation ----

# If l was previously an alias, remove it so we can define a function safely
unalias l 2>/dev/null

# l = 3-section view: normal dirs -> normal files -> dotfiles
l() {
  # 📁: folders
  printf "📁: "
  if eza --icons --grid --group-directories-first --only-dirs --ignore-glob='.*' >/dev/null 2>&1; then
    if [[ -n "$(eza --only-dirs --ignore-glob='.*' 2>/dev/null)" ]]; then
      eza --icons --grid --group-directories-first --only-dirs --ignore-glob='.*'
    else
      echo "- No Folders -"
    fi
  else
    echo "- No Folders -"
  fi

  # 📎: files
  printf "📎: "
  if [[ -n "$(eza --only-files --ignore-glob='.*' 2>/dev/null)" ]]; then
    eza --icons --grid --only-files --ignore-glob='.*'
  else
    echo "- No Files -"
  fi

  # 👻: hidden only (dotfiles + dotdirs), excluding . and ..
  setopt localoptions null_glob

  local -a h_all
  h_all=(.[^.]*)

  printf "👻: "
  if (( ${#h_all} )); then
    # -d forces "list entries only" (prevents dir expansion like ".git:")
    eza --icons --grid --color=always -d -- ${h_all[@]}
  else
    echo "- No Hidden Files/Folders -"
  fi
}

alias ll="eza --icons --long --header -a"
alias lll="eza --icons --long --header -Ta"

# Go back 1 directory (auto-run l due to cd())
alias cdd='cd ..'

cd() {
  builtin cd "$@" && l
}

mkdir() {
  command mkdir "$@" && cd "$@"
}

EOF




# ---- Terraform Related Alias ----
cat > "${TF_FILE}" <<'EOF'
# ---- Terraform Related Alias ----
alias t='terraform'
alias tf='terraform'

# ---- Apply / Destroy ----
alias tfa='terraform apply'
alias 'tfa!'='terraform apply -auto-approve'
alias tfap='terraform apply -parallelism=1'

alias tfd='terraform destroy'
alias 'tfd!'='terraform destroy -auto-approve'
alias tfdp='terraform destroy -parallelism=1'

# ---- Init ----
alias tfi='terraform init'
alias tf1='terraform init'
alias tfir='terraform init -reconfigure'
alias tfiu='terraform init -upgrade'
alias tfiur='terraform init -upgrade -reconfigure'

# ---- Plan / Validate / Test ----
alias tfp='terraform plan'
alias tfq='terraform plan'
alias tfv='terraform validate'
alias tft='terraform test'

# ---- Format ----
alias tff='terraform fmt'
alias tffr='terraform fmt -recursive'

# ---- Output / Console ----
alias tfo='terraform output'
alias tf0='terraform output'
alias tfc='terraform console'

# ---- State / Show / Graph / Import ----
alias tfs='terraform state'
alias tfsh='terraform show'
alias tfg='terraform graph'
alias tfim='terraform import'

# ---- Workspace ----
alias tfw='terraform workspace'
alias tfwl='terraform workspace list'
alias tfws='terraform workspace select'

# ---- Terraform Workflows (functions so args work) ----
tf1q()  { terraform init && terraform plan "$@"; }
tf1qa() { terraform fmt && terraform init && terraform plan && terraform apply "$@"; }

EOF


# ---- Kubectl / Kubecolor Aliases + Flags ----
cat > "${K8S_FILE}" <<'EOF'
# ---- Kubectl Related Alias ----
alias kd='kubectl describe'
alias kgs='kubectl get svc'
alias kgp='kubectl get pod'
alias kgn='kubectl get nodes -o wide'
alias kga='kubectl get all -A'
alias kgc='kubectl config get-contexts'
alias kcc='kubectl config current-context'
alias kuc='kubectl config use-context'

# ---- kubectl -> kubecolor ----
alias kubectl="kubecolor"
alias k="kubecolor"

# ---- Common kubectl flags (NOT exported) ----
now='--force --grace-period=0'
dry='--dry-run=client -o yaml'

EOF

# ---- Completions (must run after compinit in ~/.zshrc) ----
cat > "${COMP_FILE}" <<'EOF'
# ---- Completions: kubectl ----
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

EOF

echo "✔ DJ Zsh modules installed to: ${ZSH_DIR}"
echo
echo "Reminder: ensure your ~/.zshrc includes the module loader (you add this once):"
echo
echo '  for f in ~/.zsh/*.zsh; do'
echo '    [ -r "$f" ] && source "$f"'
echo '  done'
echo
echo "Then run: "
echo "source ~/.zshrc"
