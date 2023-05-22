#!/bin/bash

set -e

# Install developer tools on macOS
#
# Usage:
#   $ source ./functions.sh
#   $ ./03-install-developer-tools.macos.sh
#
# Options:
#   REINSTALL=true  # Attempts to reinstall the packages, default is `false`
#   VERBOSE=true    # Show all the executed commands, default is `false`

# ==============================================================================

function main {

  config-zsh
  config-git
  install-apps
}

function config-zsh {

  # Use zsh managed by Homebrew
  cat /etc/shells | grep $(brew --prefix)/bin/zsh > /dev/null 2>&1 || sudo sh -c "echo $(brew --prefix)/bin/zsh >> /etc/shells"
  chsh -s $(brew --prefix)/bin/zsh

  # Install Oh-My-ZSH
  if (is-arg-true "$REINSTALL") then
    rm -rf "$HOME/.oh-my-zsh"
  fi
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended ||:
  # if -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" then
  #   (
  #     cd "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
  #     git pull
  #   )
  # else
  #   git clone https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ||:
  # fi
}

function config-git {

  mkdir -p ~/.gnupg
  sed -i '/^pinentry-program/d' ~/.gnupg/gpg-agent.conf 2>/dev/null ||:
  echo "pinentry-program $(whereis -q pinentry)" >> ~/.gnupg/gpg-agent.conf
  sed -i '/^default-cache-ttl/d' ~/.gnupg/gpg-agent.conf
  echo "default-cache-ttl 10800" >> ~/.gnupg/gpg-agent.conf
  sed -i '/^max-cache-ttl/d' ~/.gnupg/gpg-agent.conf
  echo "max-cache-ttl 10800" >> ~/.gnupg/gpg-agent.conf
  gpgconf --kill gpg-agent
}

function install-apps {

  # Customise brew execution
  HOMEBREW_NO_AUTO_UPDATE=1
  is-arg-true "$REINSTALL" && install="reinstall --force" || install="install"

  # Install developer apps
  brew $install \
    chezmoi \
    drawio \
    gh \
    iterm2 \
    obsidian \
    visual-studio-code \
    ||:
  brew $install --cask \
    docker \
    ||:
}

# ==============================================================================

is-arg-true "$VERBOSE" && set -x

main $*

exit 0
