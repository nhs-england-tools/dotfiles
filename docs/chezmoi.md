# chezmoi

- [chezmoi](#chezmoi)
  - [Setup your password manager](#setup-your-password-manager)
  - [Apply changes from the local repository](#apply-changes-from-the-local-repository)
  - [Show cached configuration data](#show-cached-configuration-data)
  - [Test a template code snippet](#test-a-template-code-snippet)

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

## Apply changes from the local repository

```shell
chezmoi cd
pwd # should be ~/.local/share/chezmoi
chezmoi apply --init
```

## Show cached configuration data

```shell
chezmoi data | jq
cat ~/.config/chezmoi/chezmoi.toml
```

## Test a template code snippet

```shell
chezmoi execute-template '{{ (bitwarden "item" "dotfiles").identity.firstName }} {{ (bitwarden "item" "dotfiles").identity.lastName }}'
```
