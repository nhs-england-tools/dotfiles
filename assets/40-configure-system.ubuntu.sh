#!/bin/bash

set -e

# Configure system Ubuntu
#
# Usage:
#   $ source ./commons.sh
#   $ ./40-configure-system.ubuntu.sh
#
# Options:
#   VERBOSE=true  # Show all the executed commands, default is `false`

# ==============================================================================

function main {

  configure
}

function configure {

  :
}

# ==============================================================================

is-arg-true "$VERBOSE" && set -x

main $*

exit 0
