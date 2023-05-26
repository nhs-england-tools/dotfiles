#!/bin/bash

set -e

# Install user apps on macOS
#
# Usage:
#   $ source ./commons.sh
#   $ ./05-install-user-apps.macos.sh
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

  # Install developer apps
  brew $install \
    alt-tab \
    appcleaner \
    dozer \
    google-drive \
    keepingyouawake \
    rectangle \
    ||:
}

# ==============================================================================

is-arg-true "$VERBOSE" && set -x

main $*

exit 0
