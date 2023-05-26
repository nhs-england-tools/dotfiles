#!/bin/bash

set -e

# Meet prerequisites on macOS
#
# Usage:
#   $ source ./commons.sh
#   $ ./00-prerequisites.macos.sh
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
  # Accept Xcode licence
  sudo xcodebuild -license accept ||:
  # Install the Homebrew package manager
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# ==============================================================================

is-arg-true "$VERBOSE" && set -x

main $*

exit 0
