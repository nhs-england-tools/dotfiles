#!/bin/bash

set -e

# Install corporate apps on macOS
#
# Usage:
#   $ source ./commons.sh
#   $ ./50-install-corporate-apps.macos.sh
#
# Options:
#   REINSTALL=true  # Attempts to reinstall the packages, default is `false`
#   VERBOSE=true    # Show all the executed commands, default is `false`

# ==============================================================================

function main {

  # Customise brew execution
  export HOMEBREW_NO_AUTO_UPDATE=1
  is-arg-true "$REINSTALL" && export install="reinstall --force" || export install="install"

  install
}

function install {

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
