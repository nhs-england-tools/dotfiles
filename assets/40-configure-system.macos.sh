#!/bin/bash

set -e

# Configure system macOS
#
# Usage:
#   $ source ./commons.sh
#   $ ./40-configure-system.macos.sh
#
# Options:
#   VERBOSE=true  # Show all the executed commands, default is `false`

# ==============================================================================

function main {

  configure
}

function configure {

  # TODO: This has to be tested
  # defaults write -g com.apple.trackpad.scaling -int 3
  # defaults write -g InitialKeyRepeat -int 15
  # defaults write -g KeyRepeat -int 2
  :
}

# ==============================================================================

is-arg-true "$VERBOSE" && set -x

main $*

exit 0
