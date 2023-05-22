#!/bin/bash

set -e

# Install office apps on macOS
#
# Usage:
#   $ source "$HOME/.functions"
#   $ ./04-install-office-apps.macos.sh
#
# Options:
#   REINSTALL=true  # Attempts to reinstall the packages, default is `false`
#   VERBOSE=true    # Show all the executed commands, default is `false`

# ==============================================================================

function main {

  install
}

function install {

  # Customise brew execution
  HOMEBREW_NO_AUTO_UPDATE=1
  install="install"
  if (is-arg-true "$REINSTALL") then
    install="reinstall --force"
  fi

  # Install office apps
  brew $install --cask \
    avast-security \
    microsoft-office \
    microsoft-teams \
    slack \
    zoom \
    ||:
}

# ==============================================================================

is-arg-true "$VERBOSE" && set -x

main $*

exit 0
