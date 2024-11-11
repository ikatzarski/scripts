#!/bin/bash -eu

log() {
  local message="$1"
  local func_name="${FUNCNAME[1]}"
  local date="$(date "+%F %T")"
  echo "=> [$date] [$func_name]: $message"
}

install_core_tools() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  log "Core tools installed."
}

install_dev_tools() {
  brew install --cask warp
  brew install --cask visual-studio-code
  brew install --cask docker
  brew install git
  brew install watch
  brew install jq
  brew install yq
  brew install bat
  brew install btop
  log "Dev tools installed."
}

install_languages() {
  brew install go
  brew install pyenv
  brew install pyenv-virtualenv
  log "Languages installed."
}

install_platform_tools() {
  brew install warrensbox/tap/tfswitch
  brew install terraform-docs
  brew install checkov
  brew install awscli
  brew install kind
  brew install kubectl
  brew install helm
  brew tap hashicorp/tap
  brew install hashicorp/tap/hashicorp-vagrant
  brew install hashicorp/tap/packer
  brew install --cask virtualbox
  log "Platform tools installed."
}

install_other_tools() {
  brew install --cask google-chrome
  brew install --cask slack
  log "Other tools installed."
}

configure_vim() {
  local vimrc_file="$HOME/.vimrc"

  touch "$vimrc_file"
  echo 'syntax on
  color desert
  set number
  set relativenumber
  set hlsearch
  set tabstop=2' >"$vimrc_file"
  log "Vim configured."
}

configure_ssh() {
  local ssh_folder="$HOME/.ssh"
  local git_username="Ivan Katzarski"
  local git_email="10603133+ikatzarski@users.noreply.github.com"

  mkdir -p "$ssh_folder"
  ssh-keygen -t ed25519 -f "$ssh_folder"/github_id_ed25519 -N '' -C "$git_email"
  eval "$(ssh-agent -s)"
  touch "$ssh_folder"/config
  echo 'Host github.com
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/github_id_ed25519' >"$ssh_folder"/config
  ssh-add --apple-use-keychain "$ssh_folder"/github_id_ed25519
  git config --global user.name "$git_username"
  git config --global user.email "$git_email"
  log "SSH configured."
}

configure_new_system() {
  install_core_tools
  install_dev_tools
  install_languages
  install_platform_tools
  install_other_tools
  configure_vim
  configure_ssh
  log "New system configured."
}

install_all_tools() {
  install_dev_tools
  install_languages
  install_platform_tools
  install_other_tools
  log "All tools installed."
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
