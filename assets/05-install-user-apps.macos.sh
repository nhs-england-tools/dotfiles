#!/bin/bash

set -e

# Install user apps on macOS
#
# Usage:
#   $ source ./functions.sh
#   $ ./05-install-user-apps.macos.sh
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
  is-arg-true "$REINSTALL" && install="reinstall --force" || install="install"

  # Install user apps
  brew $install --cask \
    alt-tab \
    appcleaner \
    dozer \
    google-drive \
    keepingyouawake \
    rectangle \
    ||:
  # TODO: Move that section away as this is too opinionated
  brew $install --cask \
    dcommander \
    enpass \
    istat-menus \
    nordvpn \
    raindropio \
    tripmode \
    vlc \
    wifi-explorer \
    ||:
}

# ==============================================================================

is-arg-true "$VERBOSE" && set -x

main $*

exit 0
