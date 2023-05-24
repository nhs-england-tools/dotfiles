#!/bin/bash

set -e

# Install dotfiles
#
# Usage:
#   $ ./install.sh
#
# Options:
#   BRANCH_NAME=other-branch-than-main  # Default is `main`
#   REINSTALL=true                      # Attempts to reinstall the packages, default is `false`
#   VERBOSE=true                        # Show all the executed commands, default is `false`

# ==============================================================================

function main() {

  [ -z "$SYSTEM_DIST" ] && eval $(source "$HOME/.local/bin/detect-operating-system.sh")

  install-prerequisites
  install-dotfiles
}

function install-prerequisites {

  # TODO: install bitwarden, bitwarden-cli, chezmoi
  :
}

function get-dotfiles-configuration {

  # TODO: bw-cli
  :
}

function install-dotfiles {

  # TODO: sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_ORG # "make-ops-tools"
  :
}

function get-script-from {

  # TODO: curl & wget
  :
}

function is-arg-true() {

  if [[ "$1" =~ ^(true|yes|y|on|1|TRUE|YES|Y|ON)$ ]]; then
    return 0
  else
    return 1
  fi
}

# ==============================================================================

is-arg-true "$VERBOSE" && set -x

main $*

exit 0
