#!/bin/bash

set -e

# Install base packages on Ubuntu
#
# Usage:
#   $ source ./commons.sh
#   $ ./02-install-base-packages.ubuntu.sh
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
