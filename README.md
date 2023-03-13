# dotfiles

Dotfiles are configuration files on `*NIX` systems and are used to customise the behaviour and appearance of common applications, command-line tools and shell. They can contain various predefined settings, functions, aliases, environment variables and other configurations that affect how programs behave and interact with the system.

The aim of such a setup is to ensure predictable and consistent behaviour across environments and workstations as well as to improve the engineering efficiency which results in better [Developer Experience (DX)](https://www.thoughtworks.com/en-gb/insights/blog/why-you-should-invest-good-developer-experience-today), allowing to implement mature developer workflows that integrate well with an [Internal Developer Platform (IDP)](https://www.thoughtworks.com/en-gb/insights/blog/devops/better-developer-platforms-key-better-digital-products).

Here is _[Your unofficial guide to dotfiles on GitHub](https://dotfiles.github.io/)_

## Table of Contents

- [dotfiles](#dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
    - [Archive your current dotfiles configuration](#archive-your-current-dotfiles-configuration)
    - [Apply new configuration from this repository](#apply-new-configuration-from-this-repository)
  - [Usage](#usage)
    - [Common flow to add and track a new file](#common-flow-to-add-and-track-a-new-file)
    - [Store changes in your own GitHub repository](#store-changes-in-your-own-github-repository)
  - [Architecture](#architecture)
    - [Diagrams](#diagrams)
    - [Configuration](#configuration)
  - [Contributing](#contributing)
    - [Currently supported features](#currently-supported-features)
    - [Resources](#resources)
  - [Contacts](#contacts)
  - [Licence](#licence)

## Installation

This `dotfiles` repository is configured and managed by the `chezmoi` project. [chezmoi](https://www.chezmoi.io/), pronounced _/ʃeɪ mwa/ (shay-moi)_ is currently the [most complete and most hackable](https://www.chezmoi.io/comparison-table/) dotfiles manager out there. Please, follow the [installation guide](https://www.chezmoi.io/install/#one-line-package-install) specific to your operating system before proceeding.

### Archive your current dotfiles configuration

Prior to applying any changes to your home directory, create a backup of your current configuration. This command creates an archive file in the temporary directory that can be used later to restore the configuration, if needed.

```shell
chezmoi archive --output=/tmp/dotfiles.tar.gz
```

### Apply new configuration from this repository

The following instruction clones [\$GITHUB_ORG/dotfiles](https://github.com/make-ops-tools/dotfiles) repository into the `~/.local/share/chezmoi` directory and next, applies changes accordingly to your home directory `~/`. During the setup it prompts you to provide configuration options like Git committer name and email address, etc.

```shell
chezmoi init --apply $GITHUB_ORG # "make-ops-tools"
```

## Usage

### Common flow to add and track a new file

```shell
chezmoi add ~/.bashrc
chezmoi edit ~/.bashrc
chezmoi diff
chezmoi apply -v
chezmoi cd
git add .
git commit -S -m "Add .bashrc"
```

### Store changes in your own GitHub repository

First, create a [new dotfiles repository](https://github.com/new), then add the remote origin to it and push your preferred changes. By doing so, it will give you better experience and more customisation options to extend the functionality making it your own.

```shell
git remote add origin https://github.com/$YOUR_GITHUB_USERNAME/dotfiles.git
git branch -M main
git push -u origin main
```

## Architecture

### Diagrams

**TODO**: _The C4 model is a simple and intuitive way to create software architecture diagrams that are clear, consistent, scalable and most importantly collaborative. This should result in documenting all the system interfaces, external dependencies and integration points._

### Configuration

**TODO**: _Most of the projects are built with customisability and extendability in mind. At a minimum, this can be achieved by implementing a service level configuration options and settings. The intention of this section is to show how this can be used. If the system processes data, you could mention here for example how the input is prepared for testing - anonymised, synthetic or live data._

## Contributing

### Currently supported features

- Cross-platform support for GitHub Codespaces, macOS, Ubutnu, Windows WSL and Alpine Docker for CI/CD
- File content templating for user customisation
- Git
  - Commit signing
  - Essential `.gitconfig` setup
  - OS-specific `.gitignore` rules
  - Common `.gitattributes` rules

### Resources

More than a decade old [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles) project is an inspiration and the main source of well established practices and features that have been borrowed for the purpose of improving Developer Experience in NHS England as an revamped version to fit into the organisation strategy.

## Contacts

- [Dan Stefaniuk](https://github.com/stefaniuk)

## Licence

> The [LICENCE](./LICENCE) file will need to be updated with the correct year and owner

Unless stated otherwise, the codebase is released under the MIT License. This covers both the codebase and any sample code in the documentation.

Any HTML or Markdown documentation is [© Crown Copyright](https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/) and available under the terms of the [Open Government Licence v3.0](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).
