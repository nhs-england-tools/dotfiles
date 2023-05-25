#!/bin/bash

set -e

# Install corporate apps on Ubuntu
#
# Usage:
#   $ source ./commons.sh
#   $ ./04-install-corporate-apps.ubuntu.sh
#
# Options:
#   REINSTALL=true  # Attempts to reinstall the packages, default is `false`
#   VERBOSE=true    # Show all the executed commands, default is `false`

# ==============================================================================

function main {

  install
}

function install {

  :
}

# ==============================================================================

is-arg-true "$VERBOSE" && set -x

main $*

exit 0
