#!/bin/bash

set -e

# Install base packages on macOS
#
# Usage:
#   $ source ./functions.sh
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
  is-arg-true "$REINSTALL" && install="reinstall --force" || install="install"

  # Install packages for consistent GNU/Linux-like CLI experience on macOS
  brew $install \
    ack \
    autoconf \
    bash \
    binutils \
    coreutils \
    curl \
    diff-so-fancy \
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
    tmux \
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

# ==============================================================================

is-arg-true "$VERBOSE" && set -x

main $*

exit 0
