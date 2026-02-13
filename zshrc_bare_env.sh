#!/usr/bin/env bash

# ====================================================================================================
# Description: This Gist is meant to be used in Remote BARE env to improved UX. (E.g. Killercoda, KodeKloud)
# Command to Install: 
# 
# curl -fsSL https://tinyurl.com/D3JiaBashrc | bash && source ~/.bashrc
#
# ====================================================================================================
# Last Modified: 19 Jan 2026
# ====================================================================================================

# =========================
# Bashrc Config → ~/.bashrc
# =========================
cat << 'EOF' >> ~/.bashrc

alias kd='kubectl describe'
alias kgs='kubectl get svc'
alias kgp='kubectl get pod'
alias kgn='kubectl get nodes -o wide'
alias kga='kubectl get all -A'
alias kgc='kubectl config get-contexts'
alias kcc='kubectl config current-context'
alias kuc='kubectl config use-context'
export now='--force --grace-period=0'
export do='--dry-run=client -o yaml'

alias ka='kubectl apply'
alias kaf='kubectl apply -f'
alias ke='kubectl edit'
alias kdel='kubectl delete'
alias krm='kubectl delete'

alias kl='kubectl logs'
alias klf='kubectl logs -f'        # Follow logs
alias kex='kubectl exec -it'       # Interactive execute
alias kg='kubectl get'

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
