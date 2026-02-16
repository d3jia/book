#!/usr/bin/env bash

# ====================================================================================================
# Description: This Gist is meant to be used in Remote BARE env to improved UX. (E.g. Killercoda, KodeKloud)
# Command to Install: 
# 
# curl -fsSL https://tinyurl.com/D3JiaBashrc | bash && source ~/.bashrc
#
# ====================================================================================================
# Last Modified: 16 Feb 2026
# ====================================================================================================

# =========================
# Bashrc Config → ~/.bashrc
# =========================
cat << 'EOF' >> ~/.bashrc

# Git ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit -m'
alias gca='git commit --amend --no-edit'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gds='git diff --staged'

# Git Logs ~ Cheatsheet: https://dev.to/ansdb/10-helpful-flags-to-use-with-git-log-command-1l3k
alias gl='git log'
alias gla='git log --all'
alias glo='git log --oneline'
alias glp='git log --patch'
alias glm='git log --merge'

# Git Log (One-Line) // 1. The "Perfect one-liner" View  ---  Lists Basics (hash + message + author + date) w/ the --pretty=format flag.
alias g1='git log --graph --pretty=format:'%C(auto)%h%Creset -%C(auto)%d%Creset %s %C(green)(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit'

# Git Log (Files) // 2. The "What Changed" View  ---  This lists just the filenames. It’s perfect for a quick "what did I actually touch?" check. 
alias glf="git log --graph --pretty=format:'%C(yellow)%h%Creset -%C(red)%d%Creset %s %C(green)(%cr) %C(bold blue)<%an>%Creset' --name-only"

# Git Log (Stats) // 3. The "Impact" View (--stat)  ---  This is the gold standard for DevOps. It shows the filenames plus a "histogram" of insertions and deletions (e.g., main.tf | 14 +++---). 
alias g1s="git log --graph --pretty=format:'%C(yellow)%h%Creset -%C(red)%d%Creset %s %C(green)(%cr) %C(bold blue)<%an>%Creset' --stat"


# Kubernetes ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias kd='kubectl describe'
alias kgs='kubectl get svc'
alias kgsa='kubectl get svc -A'
alias kgp='kubectl get pod'
alias kgpa='kubectl get pod -A'
alias kgn='kubectl get nodes -o wide'
alias kga='kubectl get all -A'
alias kgc='kubectl config get-contexts'
alias kcc='kubectl config current-context'
alias kuc='kubectl config use-context'
export now='--force --grace-period=0'
export do='--dry-run=client -o yaml'

alias ka='kubectl apply -f'
alias kaf='kubectl apply -f'
alias kde='kubectl delete -f'
alias kdf='kubectl delete -f'
alias krm='kubectl delete -f'
alias ke='kubectl edit'

alias kl='kubectl logs'
alias klf='kubectl logs -f'        # Follow logs
alias kex='kubectl exec -it'       # Interactive execute
alias kg='kubectl get'


# Terraform ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
alias t='terraform'
alias tf='terraform'
alias tfi='terraform init'
alias tf1='terraform init'
alias tfp='terraform plan'
alias tfq='terraform plan'
alias tfa='terraform apply'

alias tf1q='terraform init && terraform plan'
alias tfqa='terraform plan && terraform apply'
alias tf1qa='terraform fmt && terraform init && terraform plan && terraform apply'
alias tfa!='terraform apply -auto-approve'
alias tf1qa!='terraform init && terraform plan && terraform apply -auto-approve'
alias tfipa!='terraform init && terraform plan && terraform apply -auto-approve'

alias tfv='terraform validate'
alias tft='terraform test'
alias tfs='terraform show'
alias tfst='terraform state'
alias tfg='terraform graph'
alias tfo='terraform output'
alias tf0='terraform output'
alias tfc='terraform console'
alias tfd='terraform destroy'
alias tff='terraform fmt'
alias tfim='terraform import'

alias tfws='terraform workspace'
alias tfwsl='terraform workspace list'
alias tfwss='terraform workspace show'
alias tfwsn='terraform workspace new'
alias tfwse='terraform workspace select'
alias tfwsd='terraform workspace delete'

alias tfsl='terraform state list'
alias tfs1='terraform state list'

alias v='vim'
alias c='cat'

function cd {
  builtin cd "$@" && la
}
EOF


# =========================
# Vim config → ~/.vimrc
# =========================
cat << 'EOF' >> ~/.vimrc
set nocompatible
set encoding=utf-8
set hidden
set history=1000
set backspace=indent,eol,start
set clipboard=unnamedplus
set number
set relativenumber
set cursorline
set cursorcolumn
set showcmd
set showmode
set nowrap
set signcolumn=yes
set colorcolumn=100
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smartindent
set shell=/bin/bash
set shellcmdflag=-ic
filetype plugin indent on
syntax on
EOF
