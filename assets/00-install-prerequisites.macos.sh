#!/bin/sh

set -e

# Install Xcode Command Line Tools
xcode-select -p > /dev/null 2>&1
# Install the package manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
