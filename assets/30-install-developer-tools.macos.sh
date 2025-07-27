#!/bin/bash

set -e

# Install developer tools on macOS
#
# Usage:
#   $ source ./commons.sh
#   $ ./30-install-developer-tools.macos.sh
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
    act \
    asdf \
    aws-vault \
    awscli \
    azure-cli \
    bitwarden-cli \
    chezmoi \
    drawio \
    gh \
    hadolint \
    iterm2 \
    kubernetes-cli \
    obsidian \
    shellcheck \
    visual-studio-code \
    ||:
  brew $install --cask \
    bitwarden \
    brave-browser \
    docker \
    firefox \
    font-hack-nerd-font \
    github \
    google-chrome \
    ||:

  # Update asdf plugins
  asdf plugin update --all

  # Install vscode extensions
  is-arg-true "$REINSTALL" && vs_ext_force="--force" || vs_ext_force=""
  for file in $(cat "${CHEZMOI_SOURCE_DIR:-$(chezmoi source-path)}/.vscode/extensions.json" | jq '.recommendations[]' --raw-output); do
    code $vs_ext_force --install-extension $file ||:
  done
  # Install iterm theme
  defaults import \
    com.googlecode.iterm2 \
    "${CHEZMOI_SOURCE_DIR:-$(chezmoi source-path)}/assets/iterm2/settings.xml"
}

function tech-terraform-install() {

  asdf plugin add terraform ||:
  asdf install terraform latest
  asdf set terraform latest --home
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
  asdf set python latest --home
}

function tech-python-configure() {

  :

  # asdf plugin add poetry ||:
  # asdf install poetry latest
  # asdf set poetry latest --home

  # python -m ensurepip
  # python -m pip install --upgrade pip
  # python -m pip install \
  #   jwt

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
  asdf set nodejs latest --home
}

function tech-nodejs-configure() {

  asdf plugin add yarn ||:
  asdf install yarn latest
  asdf set yarn latest --home
}

function tech-golang-install() {

  asdf plugin add golang ||:
  asdf install golang latest
  asdf set golang latest --home
}

function tech-golang-configure() {

  # SEE: https://github.com/kennyp/asdf-golang

  :
}

function tech-java-install() {

  asdf plugin add java ||:
  asdf install java latest:adoptopenjdk
  asdf set java latest:adoptopenjdk --home
}

function tech-java-configure() {

  # SEE: https://github.com/halcyon/asdf-java
  :
}

# ==============================================================================

is-arg-true "$VERBOSE" > /dev/null 2>&1 && set -x

main $*

exit 0
