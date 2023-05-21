#!/bin/sh

set -e

# Update all packages on macOS
#
# Usage:
#   $ ./01-update-all-packages.macos.sh
#
# Options:
#   VERBOSE=true  # Show all the executed commands, default is `false`

# ==============================================================================

function main {

  install
}

function install {

  # Install all available software updates
  softwareupdate --all --install --force ||:
  # Install Xcode Command Line Tools, this command will open a dialog for installation to commence as a separate process
  xcode-select --install 2> /dev/null ||:; [ -d "/Applications/Xcode.app/Contents/Developer" ] && sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer ||:
  # Install a command line interface for the Mac App Store
  which mas > /dev/null 2>&1 || brew install mas
  # Install Xcode
  sudo xcodebuild -license accept ||:; mas list | grep Xcode || ( mas install $(mas search Xcode | head -n 1 | awk '{ print $1 }') && mas upgrade $(mas list | grep Xcode | awk '{ print $1 }') ) ||:
  # Install Rosetta 2 on Apple Silicon
  [ "$SYSTEM_ARCH_NAME" == arm64 ] && sudo softwareupdate --install-rosetta --agree-to-license ||:
  # Update Homebrew
  brew update
  # Upgrade Homebrew's packages
  brew upgrade ||:
  # Install Homebrew taps
  brew tap homebrew/cask-versions # Install a tap to additional app versions for Homebrew Cask
  brew tap homebrew/cask-fonts # Install a tap to additional font versions for Homebrew Cask
  brew tap blendle/blendle # Install a tap to apps and tools not yet submitted to Homebrew Core
  brew tap buo/cask-upgrade # Install a command-line tool for upgrading apps installed by Homebrew Cask
  # Upgrade all Homebrew Cask apps
  brew cu --all --yes ||:
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
