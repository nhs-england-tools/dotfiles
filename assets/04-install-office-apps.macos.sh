#!/bin/sh

set -e

# Install office apps on macOS
#
# Usage:
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
  if (is_arg_true "$REINSTALL") then
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
