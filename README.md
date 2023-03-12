# dotfiles

_[Your unofficial guide to dotfiles on GitHub](https://dotfiles.github.io/)_

## Table of Contents

- [dotfiles](#dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Features](#features)
  - [Licence](#licence)

## Installation

This `dotfiles` repository is configured and managed by the [chezmoi](https://www.chezmoi.io/) project.

```shell
GITHUB_ORG=make-ops-tools
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_ORG
```

## Features

- `.gitignore` OS-specific files
- Cross-platform support for macOS, Linux and Windows

## Licence

> The [LICENCE](./LICENCE) file will need to be updated with the correct year and owner

Unless stated otherwise, the codebase is released under the MIT License. This covers both the codebase and any sample code in the documentation.

Any HTML or Markdown documentation is [© Crown Copyright](https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/) and available under the terms of the [Open Government Licence v3.0](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/).
