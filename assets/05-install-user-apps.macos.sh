#!/bin/sh

set -e

# Install user apps on macOS
#
# Usage:
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
  install="install"
  if (is_arg_true "$REINSTALL") then
    install="reinstall --force"
  fi

  # Install user apps
  brew $install --cask \
    alt-tab \
    appcleaner \
    bitwarden \
    dozer \
    google-drive \
    keepingyouawake \
    rectangle \
    ||:
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
