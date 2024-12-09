# NHS England Tools - Dotfiles

[![CI/CD Pipeline](https://github.com/nhs-england-tools/dotfiles/actions/workflows/cicd-pipeline.yaml/badge.svg)](https://github.com/nhs-england-tools/dotfiles/actions/workflows/cicd-pipeline.yaml)

Dotfiles are configuration files on `*NIX` (including macOS, Windows WSL and Linux) systems and are used to customise the behaviour and appearance of common applications, command-line tools and shell. They can contain various predefined settings, functions, aliases, environment variables and other configurations that affect how programs behave and interact with the system.

The aim of such a setup is to ensure predictable and consistent behaviour across environments and workstations as well as to improve the engineering efficiency which results in better [Developer Experience (DX)](https://www.thoughtworks.com/en-gb/insights/blog/why-you-should-invest-good-developer-experience-today), allowing to implement mature developer workflows that integrate well with an [Internal Developer Platform (IDP)](https://www.thoughtworks.com/en-gb/insights/blog/devops/better-developer-platforms-key-better-digital-products).

Here is an _[Unofficial guide to dotfiles on GitHub](https://dotfiles.github.io/)_

## Table of Contents

- [NHS England Tools - Dotfiles](#nhs-england-tools---dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
    - [Archive your home directory](#archive-your-home-directory)
    - [Apply new configuration](#apply-new-configuration)
    - [Set up a password manager](#set-up-a-password-manager)
  - [Structure](#structure)
  - [Features](#features)
  - [Usage](#usage)
    - [Store changes in your own repository](#store-changes-in-your-own-repository)
  - [Resources](#resources)
  - [Contacts](#contacts)
  - [Licence](#licence)

## Installation

This dotfiles repository is configured and managed by the `chezmoi` project. [chezmoi](https://www.chezmoi.io/), pronounced _/ʃeɪ mwa/ (shay-moi)_ is currently the [most complete and most hackable](https://www.chezmoi.io/comparison-table/) dotfiles manager out there.

### Archive your home directory

Prior to applying any changes to your home directory, create a backup of your current configuration. This command creates an archive file in the temporary directory that can be used later to restore the configuration, if needed.

```shell
tar -czvf /tmp/home-directory-backup.tar.gz -C ~ .
```

You might be prompted by your terminal application to grant access permissions, allowing the process to access files in your home directory. However, if the above takes too long as it archives all the files in your home directory an alternative would be to use `chezmoi` to backup only the dotiles. Please, follow the [installation guide](https://www.chezmoi.io/install/#one-line-package-install) specific to your operating system before proceeding.

```shell
chezmoi archive --output=/tmp/dotfiles-backup.tar.gz
```

### Apply new configuration

The following instruction clones the [dotfiles](https://github.com/nhs-england-tools/dotfiles) repository into the `~/.local/share/chezmoi/` directory and next applies changes accordingly, to your home directory `~/`. During the setup it prompts you to provide configuration options like Git committer name and email address, etc.

```shell
bash -c "$(curl -fsLS get.chezmoi.io)" -- init --apply "nhs-england-tools"
```

You can find more information on how `chezmoi` works [here](./docs/guides/chezmoi-usage.md).

### Set up a password manager

To store some of the configuration options, `chezmoi` can use a password manager. Therefore, after the dotfiles installation, please follow the [Bitwarden setup](./docs/guides/bitwarden-usage.md) guide to improve the installation experience for any subsequent run.

## Structure

As an example, the following files are managed by this dotilfes project:

```shell
~ ($HOME)
│
├─── .aliases
├─── .bash_profile
├─── .bash_prompt
├─── .bashrc
├─── .exports
├─── .functions
├─── .gitattribute
├─── .gitconfig
├─── .gitignore
├─── .gitmessage
├─── [.macos|.ubuntu]
├─── .p10k.zsh
├─── .path
└─── .zshrc
```

Some mechanisms like installation of packages do not follow the declarative approach and use imperative scripts to apply changes. However, they are written in an idempotent way and run only when a change is detected.

This project can be customised and extended by creating a personal repository (a GitHub fork) for then to be keep building on top of it and making custom adjustments.

## Features

- Cross-platform support for macOS, Windows WSL, Linux and GitHub Codespaces
- File content templating for user customisation
- [GNU-compatible CLI tools](https://en.wikipedia.org/wiki/List_of_GNU_packages) to provide consistent experience for macOS users
- [Oh My Zsh](https://ohmyz.sh/) for managing shell configuration
- [Visual Studio Code](https://code.visualstudio.com/) as a default editor
- Git
  - Commit signing configuration
  - Essential `.gitconfig` setup
  - OS-specific `.gitignore` rules
  - Common `.gitattributes` rules

## Usage

### Store changes in your own repository

You may want to create your own fork of this dotfiles repository. Doing so will provide a better experience and more customisation options, extending the functionality and allowing you to personalise it. To incorporate changes from the original repository into your fork, you can use the following pattern:

```shell
# Prepare all the branches before rebasing
git remote add upstream https://github.com/nhs-england-tools/dotfiles.git
git remote -v
git fetch upstream
git checkout main

# Rebase your changes on top of `upstream/main`
git rebase upstream/main
# Resolve conflicts, if any

# Find the base commit from `upstream/main` and reset to that commit but keep the changes
git reset --soft $(git merge-base main upstream/main)

# Stage, commit and push all changes
git add .
git commit -S -m "Custom changes"
git push --force-with-lease
```

## Resources

The longstanding [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles) project, with its well-established practices and features, has served as an inspiration for improving the Developer Experience in NHS England. It has been adapted and revamped to align with the organisation's strategy.

## Contacts

- [Dan Stefaniuk](https://github.com/stefaniuk)

## Licence

> The [LICENCE.md](./LICENCE.md) file will need to be updated with the correct year and owner

Unless stated otherwise, the codebase is released under the MIT License. This covers both the codebase and any sample code in the documentation.

Any HTML or Markdown documentation is [© Crown Copyright](https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/) and available under the terms of the [Open Government Licence v3.0](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).
