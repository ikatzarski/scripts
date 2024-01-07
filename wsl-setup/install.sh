#!/bin/bash -e

install_oh_my_zsh() {
  # oh-my-zsh
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    # prerequisites
    sudo apt install -y zsh
    sudo chsh -s $(which zsh)

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    echo "=> OH-MY-ZSH already installed"
  fi
}

install_dev_tools() {
  # git
  sudo add-apt-repository -y ppa:git-core/ppa
  sudo apt update
  sudo apt install -y git

  # jq
  sudo apt install -y jq

  # yq
  if [ ! -e "/usr/bin/yq" ]; then
    local VERSION=v4.40.5
    local BINARY=yq_linux_amd64
    sudo wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY} -O /usr/bin/yq
    sudo chmod +x /usr/bin/yq
  else
    echo "=> yq already installed"
  fi

  # docker
  if [ ! -e "/etc/apt/keyrings/docker.gpg" ]; then
    # Add Docker's official GPG key:
    sudo apt install ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
      sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
    sudo apt update
  else
    echo "=> docker apt repo already added"
  fi

  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  sudo usermod -aG docker $USER
}

install_languages() {
  # go
  if [ ! -d "/usr/local/go/bin" ]; then
    local VERSION=1.21.5
    curl -OL https://golang.org/dl/go${VERSION}.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${VERSION}.linux-amd64.tar.gz
    rm go${VERSION}.linux-amd64.tar.gz
    echo '
# GO path
export PATH=$PATH:/usr/local/go/bin' >>$HOME/.zshrc
  else
    echo "=> go already installed"
  fi
}

install_platform_tools() {
  # tfswitch
  curl -L https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | sudo bash

  # terraform-docs
  if [ ! -e "/usr/bin/terraform-docs" ]; then
    local VERSION=v0.17.0
    curl -sSLo ./terraform-docs.tar.gz https://terraform-docs.io/dl/${VERSION}/terraform-docs-${VERSION}-$(uname)-amd64.tar.gz
    tar -xzf terraform-docs.tar.gz
    chmod +x terraform-docs
    sudo mv terraform-docs /usr/bin/terraform-docs
    rm terraform-docs.tar.gz
  else
    echo "=> terraform-docs already installed"
  fi

  # kind
  if [ ! -e "/usr/local/bin/kind" ]; then
    local VERSION=v0.20.0
    [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/${VERSION}/kind-linux-amd64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
  else
    echo "=> kind already installed"
  fi

  # kubectl
  if [ ! -e "/usr/local/bin/kubectl" ]; then
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
  else
    echo "=> kubectl already installed"
  fi

  # helm
  if [ ! -e "/usr/local/bin/helm" ]; then
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    rm get_helm.sh
  else
    echo "=> helm already installed"
  fi
}

configure_vim() {
  touch $HOME/.vimrc
  echo 'syntax on
color desert
set number
set relativenumber
set hlsearch
set tabstop=2' >$HOME/.vimrc
}

configure_ssh() {
  if [ ! -e "$HOME/.ssh/github_id_ed25519" ]; then
    ssh-keygen -t ed25519 -f $HOME/.ssh/github_id_ed25519 -N '' -C "10603133+ikatzarski@users.noreply.github.com"
    eval "$(ssh-agent -s)"
    touch $HOME/.ssh/config
    echo 'Host github.com
  HostName github.com
  IdentityFile ~/.ssh/github_id_ed25519' >$HOME/.ssh/config
    git config --global user.name "Ivan Katzarski"
    git config --global user.email "10603133+ikatzarski@users.noreply.github.com"
  else
    echo "=> git ssh key already created"
  fi
}

configure_new_system() {
  sudo apt update

  install_oh_my_zsh
  install_dev_tools
  install_languages
  install_platform_tools
  configure_vim
  configure_ssh
}

install_all_tools() {
  sudo apt update

  install_dev_tools
  install_languages
  install_platform_tools
}

print_help() {
  echo "Usage:"
  echo "  ./$(basename "$0") [-n|a|v|s|h]" >&2
  echo "Options:"
  echo "  -n    Install all tools and configure SSH and VIM on a new system."
  echo "  -a    Install all tools. Use on an already configured system."
  echo "  -v    Configure VIM."
  echo "  -s    Configure SSH."
  echo "  -h    Print help."
}

run() {
  while getopts "navsh" OPTION; do
    case "$OPTION" in
    n) configure_new_system ;;
    a) install_all_tools ;;
    v) configure_vim ;;
    s) configure_ssh ;;
    h) print_help ;;
    ?) print_help && exit 1 ;;
    esac
  done
}

run "$@"
