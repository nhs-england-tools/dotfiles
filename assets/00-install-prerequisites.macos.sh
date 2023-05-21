#!/bin/sh

set -e

# Install prerequisites on macOS
#
# Usage:
#   $ ./00-install-prerequisites.macos.sh
#
# Options:
#   VERBOSE=true  # Show all the executed commands, default is `false`

# ==============================================================================

function main {

  install
}

function install {

  # Install Xcode Command Line Tools or print the path of the active developer directory
  xcode-select -p > /dev/null >&2
  # Install the Homebrew package manager
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Make sure Homebrew packages are owned by the current user
  sudo chown -R $(id -u):admin $(brew --prefix)/*
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
