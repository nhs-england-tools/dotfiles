#!/bin/bash

set -e

# Install developer tools on Ubuntu
#
# Usage:
#   $ source ./commons.sh
#   $ ./30-install-developer-tools.ubuntu.sh
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

is-arg-true "$VERBOSE" > /dev/null 2>&1 && set -x

main $*

exit 0
