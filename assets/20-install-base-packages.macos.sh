#!/bin/bash

set -e

# Install base packages on macOS
#
# Usage:
#   $ source ./commons.sh
#   $ ./20-install-base-packages.macos.sh
#
# Options:
#   REINSTALL=true  # Attempts to reinstall the packages, default is `false`
#   VERBOSE=true    # Show all the executed commands, default is `false`

# ==============================================================================

function main {

  # Customise brew execution
  export HOMEBREW_NO_AUTO_UPDATE=1
  is-arg-true "$REINSTALL" && export install="reinstall --force" || export install="install"

  install
}

function install {

  # Install packages for consistent GNU/Linux-like CLI experience on macOS
  brew $install \
    ack \
    autoconf \
    bash \
    binutils \
    coreutils \
    ctop \
    curl \
    diff-so-fancy \
    diffutils \
    dive \
    findutils \
    gawk \
    git \
    git-crypt \
    git-secrets \
    gnu-getopt \
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
    neovim \
    openssl \
    pinentry-mac \
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

is-arg-true "$VERBOSE" > /dev/null 2>&1 && set -x

main $*

exit 0
