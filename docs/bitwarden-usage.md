# Bitwarden Usage

- [Bitwarden Usage](#bitwarden-usage)
  - [Setup your password manager](#setup-your-password-manager)

## Setup your password manager

```shell
bw login
bw unlock # if your session has expired
export BW_SESSION="[session]"
bw list items
```

```json
[
  {
    "object": "item",
    "id": "00000000-0000-0000-0000-000000000000",
    "name": "dotfiles",
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
    }
  }
]
```

```shell
bw sync
bw get item "dotfiles"
```
