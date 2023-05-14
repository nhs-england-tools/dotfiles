#!/bin/sh

set -e

softwareupdate --all --install --force ||:
xcode-select --install 2> /dev/null ||:
which mas > /dev/null 2>&1 || brew install mas
sudo xcodebuild -license accept ||:; mas list | grep Xcode || ( mas install $(mas search Xcode | head -n 1 | awk '{ print $1 }') && mas upgrade $(mas list | grep Xcode | awk '{ print $1 }') ) ||:
[ $(SYSTEM_ARCH_NAME) == arm64 ] && sudo softwareupdate --install-rosetta --agree-to-license ||:
brew update
brew upgrade ||:
brew tap buo/cask-upgrade
brew cu --all --yes ||:
