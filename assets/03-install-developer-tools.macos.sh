#!/bin/bash

set -e

# Install developer tools on macOS
#
# Usage:
#   $ source ./commons.sh
#   $ ./03-install-developer-tools.macos.sh
#
# Options:
#   REINSTALL=true  # Attempts to reinstall the packages, default is `false`
#   VERBOSE=true    # Show all the executed commands, default is `false`

# ==============================================================================

function main {

  # Customise brew execution
  export HOMEBREW_NO_AUTO_UPDATE=1
  is-arg-true "$REINSTALL" && export install="reinstall --force" || export install="install"

  config-zsh
  config-git
  install-tools-and-apps

  tech-terraform-install
  tech-terraform-configure
  tech-python-install
  tech-python-configure
  tech-nodejs-install
  tech-nodejs-configure
  tech-golang-install
  tech-golang-configure
  tech-java-install
  tech-java-configure
}

function config-zsh {

  # Use zsh managed by Homebrew
  cat /etc/shells | grep $(brew --prefix)/bin/zsh > /dev/null 2>&1 || sudo sh -c "echo $(brew --prefix)/bin/zsh >> /etc/shells"
  chsh -s $(brew --prefix)/bin/zsh
}

function config-git {

  mkdir -p "$HOME/.gnupg"
  sed -i '/^pinentry-program/d' "$HOME/.gnupg/gpg-agent.conf" 2>/dev/null ||:
  echo "pinentry-program $(whereis -q pinentry-mac)" >> "$HOME/.gnupg/gpg-agent.conf"
  sed -i '/^default-cache-ttl/d' "$HOME/.gnupg/gpg-agent.conf"
  echo "default-cache-ttl 10800" >> "$HOME/.gnupg/gpg-agent.conf"
  sed -i '/^max-cache-ttl/d' "$HOME/.gnupg/gpg-agent.conf"
  echo "max-cache-ttl 10800" >> "$HOME/.gnupg/gpg-agent.conf"
  gpgconf --kill gpg-agent
}

function install-tools-and-apps {

  # Install developer apps
  brew $install \
    aws-vault \
    awscli \
    bitwarden-cli \
    chezmoi \
    drawio \
    gh \
    iterm2 \
    kubernetes-cli \
    obsidian \
    visual-studio-code \
    ||:
  brew $install --cask \
    bitwarden \
    brave-browser \
    docker \
    firefox \
    font-hack-nerd-font \
    google-chrome \
    ||:

  # Install vscode extensions
  is-arg-true "$REINSTALL" && vs_ext_force="--force" || vs_ext_force=""
  for file in $(cat "${CHEZMOI_SOURCE_DIR:-$(chezmoi source-path)}/.vscode/extensions.json" | jq '.recommendations[]' --raw-output); do
    code $vs_ext_force --install-extension $file ||:
  done
  # Install iterm theme
  defaults import \
    com.googlecode.iterm2 \
    "${CHEZMOI_SOURCE_DIR:-$(chezmoi source-path)}/assets/iterm2/settings.xml"

  # Install asdf, SEE: https://asdf-vm.com/
  if [ -d "$HOME/.asdf" ]; then
    (
      cd "$HOME/.asdf"
      git pull
    )
  else
    git clone --depth=1 https://github.com/asdf-vm/asdf.git "$HOME/.asdf" ||:
  fi
  asdf plugin update --all
}

function tech-terraform-install() {

  asdf plugin add terraform ||:
  asdf install terraform latest
  asdf global terraform latest
}

function tech-terraform-configure() {

  # SEE: https://github.com/asdf-community/asdf-hashicorp

  # TODO: Install dev tools for terraform
  # brew $install \
  #   warrensbox/tap/tfswitch
  :
}

function tech-python-install() {

  asdf plugin add python ||:
  asdf install python latest
  asdf global python latest
}

function tech-python-configure() {

  # SEE: https://github.com/asdf-community/asdf-python

  asdf plugin add poetry ||:
  asdf install poetry latest
  asdf global poetry latest

  python -m ensurepip
  python -m pip install --upgrade pip

  # TODO: Install dev tools for python
  # brew $install \
  #   pyenv \
  #   pyenv-virtualenv \
  #   python \
  #   virtualenv \
  #   ||:
  # python -m pip install \
  #   bandit \
  #   black \
  #   bpython \
  #   coverage \
  #   flake8 \
  #   mypy \
  #   prospector \
  #   pycodestyle \
  #   pylama \
  #   pylint \
  #   pytest
}

function tech-nodejs-install() {

  asdf plugin add nodejs ||:
  asdf install nodejs latest
  asdf global nodejs latest
}

function tech-nodejs-configure() {

  asdf plugin add yarn ||:
  asdf install yarn latest
  asdf global yarn latest
}

function tech-golang-install() {

  asdf plugin add golang ||:
  asdf install golang latest
  asdf global golang latest
}

function tech-golang-configure() {

  # SEE: https://github.com/kennyp/asdf-golang

  :
}

function tech-java-install() {

  asdf plugin add java ||:
  asdf install java latest:adoptopenjdk
  asdf global java latest:adoptopenjdk
}

function tech-java-configure() {

  # SEE: https://github.com/halcyon/asdf-java
  :
}

# ==============================================================================

is-arg-true "$VERBOSE" && set -x

main $*

exit 0
