#!/bin/bash

install_core_tools() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_dev_tools() {
  brew install --cask iterm2
  brew install --cask visual-studio-code
  brew install --cask docker
  brew install git
}

install_languages() {
  brew install go
  brew install rustup-init
  brew install pyenv
  brew install nvm && mkdir -p ~/.nvm
  curl -s "https://get.sdkman.io" | bash
}

install_platform_tools() {
  brew install warrensbox/tap/tfswitch
  brew install awscli
  brew install azure-cli
}

install_other_tools() {
  brew install --cask google-chrome
  brew install --cask firefox
  brew install --cask slack
  brew install --cask spotify
}

configure_vim() {
  touch $HOME/.vimrc &&
    echo 'syntax on
  color desert
  set number
  set relativenumber
  set hlsearch
  set tabstop=2' >$HOME/.vimrc
}

configure_ssh() {
  ssh-keygen -t ed25519 -f $HOME/.ssh/github_id_ed25519 -N '' -C "10603133+ikatzarski@users.noreply.github.com"
  eval "$(ssh-agent -s)"
  mkdir -p $HOME/.ssh && touch $HOME/.ssh/config &&
    echo 'Host *.github.com
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/github_id_ed25519' >$HOME/.ssh/config
  ssh-add --apple-use-keychain $HOME/.ssh/github_id_ed25519
  pbcopy <~/.ssh/github_id_ed25519.pub
  git config --global user.name "Ivan Katzarski"
  git config --global user.email "10603133+ikatzarski@users.noreply.github.com"
}

configure_new_system() {
  install_core_tools
  install_dev_tools
  install_languages
  install_platform_tools
  install_other_tools
  configure_vim
  configure_ssh
}

install_all_tools() {
  install_dev_tools
  install_languages
  install_platform_tools
  install_other_tools
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
  # shift "$(($OPTIND - 1))"
}

run "$@"
