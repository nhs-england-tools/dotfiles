# Bitwarden Usage

- [Bitwarden Usage](#bitwarden-usage)
  - [Overview](#overview)
  - [Configuration](#configuration)
    - [Prerequisites](#prerequisites)
    - [Test](#test)

## Overview

This project uses [Bitwarden CLI](https://bitwarden.com/help/cli/) as a default password manager to store its non-sensitive configuration data. It is installed the first time the dotfiles run.

## Configuration

### Prerequisites

- [Create your Bitwarden account](https://bitwarden.com/help/create-bitwarden-account/)
- [Login to the Bitwarden web vault](https://vault.bitwarden.com/#/login)
- [Create a new Identity item](https://bitwarden.com/help/custom-fields/) with the `Name` filed set to `dotfiles`
- Fill in the following fields
  - `First name`
  - `Last name`
  - `Username` - this can be your shortcode
  - `Email`
  - `git_signingkey` - this is a custom field to store your gpg Git commit signing key ID

### Test

Log in using the Bitwarden CLI and fetch the `dotfiles` Identity item

```shell
bw login
bw unlock # if your session has expired
export BW_SESSION="[session]"
bw get item dotfiles | jq
```
Tou should be presented with a similar output

```json
[
  {
    "object": "item",
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "dotfiles",
    ...
    "fields": [
      {
        "name": "git_signingkey",
        "value": "1234567890ABCDEF1234567890ABCDEF12345678"
      }
    ],
    "identity": {
      "firstName": "[your first name]",
      "lastName": "[your last name]",
      "email": "[your email]",
      "username": "[your username]"
    },
    ...
  }
]
```

To fetch any changes made using the online service, run the following command:

```shell
bw sync
```
