#!/bin/bash

set -e

# Update all packages on Ubuntu
#
# Usage:
#   $ source ./functions.sh
#   $ ./01-update-all-packages.ubuntu.sh
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
