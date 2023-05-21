#!/bin/sh

set -e

# Install developer apps on macOS
#
# Usage:
#   $ ./03-install-developer-apps.macos.sh
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
  if (is_arg_true "$REINSTALL") then
    install="reinstall --force"
  fi

  # Install developer apps
  brew $install \
    docker \
    drawio \
    iterm2 \
    obsidian \
    visual-studio-code \
    ||:
  brew $install --cask \
    docker \
    ||:
}

function is_arg_true() {

  if [[ "$1" =~ ^(true|yes|y|on|1|TRUE|YES|Y|ON)$ ]]; then
    return 0
  else
    return 1
  fi
}

# ==============================================================================

is_arg_true "$VERBOSE" && set -x

main $*

exit 0
