#!/bin/sh

set -e

# Install base packages on macOS
#
# Usage:
#   $ ./02-install-base-packages.macos.sh
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

  # Install packages for consistent GNU/Linux-like CLI experience on macOS
  brew $install \
    ack \
    autoconf \
    bash \
    binutils \
    coreutils \
    curl \
    diffutils \
    findutils \
    gawk \
    git \
    git-crypt \
    git-secrets \
    gnu-sed \
    gnu-tar \
    gnu-which \
    gnutls \
    gpg \
    grep \
    gzip \
    jc \
    jq \
    less \
    make \
    openssl \
    readline \
    ripgrep \
    screen \
    tree \
    watch \
    wdiff \
    wget \
    xq \
    xz \
    yq \
    zip \
    zlib \
    zsh \
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
