#!/bin/sh -e

# Project installation script
#
# Usage:
#   $ [options] /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/make-ops-tools/dotfiles/main/install.sh)"
#
# Options:
#   BRANCH_NAME=other-branch-than-main      # Default is `main`
#   INSTALL_DIR=other-dir-than-install-dir  # Default is `~/.local/share/chezmoi`
#   CLONE_REPO=false                        # Default is `true`
#   VERBOSE=true                            # Default is `false`

# ==============================================================================

SCRIPT_DIR=$([ -n "${BASH_SOURCE[0]}" ] && cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd || dirname "$(readlink -f "$0")")

ORG_NAME=${ORG_NAME:-${USER_NAME:-"make-ops-tools"}}
REPO_NAME=${REPO_NAME:-"dotfiles"}
PROJECT_NAME=$ORG_NAME-$REPO_NAME

BRANCH_NAME=${BRANCH_NAME:-"main"}
INSTALL_DIR=${INSTALL_DIR:-~/.local/share/chezmoi}
CLONE_REPO=${CLONE_REPO:-true}

CMD_NAME=$REPO_NAME

# ==============================================================================

function main() {

  cd $SCRIPT_DIR

  clone || download
  check && install
  finish
}

function clone() {

  if (is_arg_false "$CLONE_REPO" || ! is_arg_true "$CLONE_REPO") then
    return 1
  fi

  if ! [ -d "$INSTALL_DIR/.git" ]; then
    mkdir -p "$INSTALL_DIR"
    cd "$INSTALL_DIR"
    git clone https://github.com/$ORG_NAME/$REPO_NAME.git .
  else
    cd "$INSTALL_DIR"
    git pull --all
  fi
  git checkout "$BRANCH_NAME"
}

function download() {

  curl -L \
    "https://github.com/$ORG_NAME/$REPO_NAME/tarball/$BRANCH_NAME?$(date +%s)" \
    -o /tmp/$PROJECT_NAME.tar.gz
  tar -zxf /tmp/$PROJECT_NAME.tar.gz -C /tmp
  rm -rf /tmp/$PROJECT_NAME.tar.gz
  rm -rf $INSTALL_DIR
  mkdir -p $(dirname $INSTALL_DIR)
  mv /tmp/$PROJECT_NAME-* "$INSTALL_DIR"
  cd "$INSTALL_DIR"
}

# ==============================================================================

function check() {

  present=$(tput setaf 64; printf present;tput sgr0)
  missing=$(tput setaf 196; printf missing;tput sgr0)

  printf "\nPrerequisites:\n"

  # Check bash
  [ -x /bin/bash ] && value=$present || value=$missing
  printf "bash [%s]\n" "$value"
  # Check git
  which git > /dev/null 2>&1 && value=$present || value=$missing
  printf "git [%s]\n" "$value"
  # Check make
  (make --version 2> /dev/null | grep -i "gnu make" | grep -Eq '[4]\.[0-9]+') && value=$present || value=$missing
  printf "make [%s]\n" "$value"
  # Check docker
  which docker > /dev/null 2>&1 && value=$present || value=$missing
  printf "docker [%s]\n" "$value"
  # Check chezmoi
  which chezmoi > /dev/null 2>&1 && value=$present || value=$missing
  printf "chezmoi [%s]\n" "$value"

  printf "\n"
}

function install() {

  mkdir -p ~/bin
  ln -sf \
    $INSTALL_DIR/scripts/$CMD_NAME.sh \
    ~/bin/$CMD_NAME
}

function finish() {

  printf "Project directory %s\n" "$INSTALL_DIR"
  printf "Executable %s\n" "~/bin/$CMD_NAME"
  printf "Add to your PATH the ~/bin directory, i.e. PATH=\"~/bin:\$PATH\"\n"
}

# ==============================================================================

function is_arg_true() {

  if [[ "$1" =~ ^(true|yes|y|on|1|TRUE|YES|Y|ON)$ ]]; then
    return 0
  else
    return 1
  fi
}

function is_arg_false() {

  if [[ "$1" =~ ^(false|no|n|off|0|FALSE|NO|N|OFF)$ ]]; then
    return 0
  else
    return 1
  fi
}

# ==============================================================================

is_arg_true "$VERBOSE" && set -x
main
