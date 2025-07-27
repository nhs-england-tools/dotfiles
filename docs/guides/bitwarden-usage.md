# Bitwarden Usage

- [Bitwarden Usage](#bitwarden-usage)
  - [Overview](#overview)
  - [Configuration](#configuration)
    - [Setup](#setup)
    - [Prerequisites](#prerequisites)
    - [Test](#test)

## Overview

This project uses the [Bitwarden](https://bitwarden.com/) as its password manager to help you securely store important information such as your name, email address, and Git signing key.

> [!TIP] What is Bitwarden?
> Bitwarden is a secure password manager. It stores your passwords and other sensitive information in an encrypted digital vault, which you can access from anywhere.

The Bitwarden CLI (Command Line Interface) is a tool that lets you access your Bitwarden vault from the command line. The first time you install these dotfiles, the Bitwarden CLI will also be installed automatically. After that, every time you run the dotfiles setup, it will use Bitwarden to retrieve any sensitive or personal information that's needed, and you'll be prompted to log in to Bitwarden if you aren't already.

> [!TIP] What is the Bitwarden CLI?
> The CLI is a command-line tool (run in your terminal) that lets scripts or automated tools access the information you've stored in Bitwarden. In this project, it's used to securely fetch your details (like your name, email, and signing key) during setup, so you don't have to manually type them in every time.

## Configuration

### Setup

The automation in this project uses a configuration template file called `.chezmoi.toml.tmpl`. During the setup, this file is read and used to create your actual configuration file at `~/.config/chezmoi/chezmoi.toml`.

If the Bitwarden CLI is installed and you are logged in, the template will automatically fetch your information from your Bitwarden vault (such as your name, email, and Git signing key). If Bitwarden isn't set up, it will ask you for this information instead.

Here's a snippet of the template (for reference):

```toml
{{- if lookPath "bw" -}}
{{-   $dotfiles := (bitwarden "item" "dotfiles") -}}
{{-   $name = (print $dotfiles.identity.firstName " " $dotfiles.identity.lastName) -}}
{{-   $email = $dotfiles.identity.email -}}
{{-   $signingKey = (bitwardenFields "item" "dotfiles").git_signingkey.value -}}
{{- else -}}
{{-   $name = promptStringOnce . "dotfiles.name" "Git user name for the author/committer" -}}
{{-   $email = promptStringOnce . "dotfiles.email" "Git user email for the author/committer" -}}
{{-   $signingKey = promptStringOnce . "dotfiles.git_signingkey" "Git user signing key for the author/committer" -}}
{{- end -}}
```

In simple terms, if Bitwarden is set up, your details are filled in for you. If not, you'll be asked to enter them yourself.

### Prerequisites

Before you can use Bitwarden with this project, please follow these steps:

1. [Create a Bitwarden account](https://bitwarden.com/help/create-bitwarden-account/). Go to the Bitwarden website and sign up for a free account if you don't already have one.
1. [Log in to the Bitwarden web vault](https://vault.bitwarden.com/#/login). Visit the web vault and log in with your account.
1. [Create a new "Identity" item in Bitwarden](https://bitwarden.com/help/custom-fields/)
    - In your Bitwarden vault, click on "+ New" and select "Identity".
    - Set the "Item name" to `dotfiles`.
    - Fill in the following fields:
      - `First name`: Your first name
      - `Last name`: Your last name
      - `Username`: This can be anything unique to your computer, e.g. your computer name or your username
      - `Email`: Your email address
    - Add a custom field by clicking "+ Add filed" selecting field type as "Text" and field label as `git_signingkey`. Then enter your GPG signing key ID as its value (if you use signed Git commits).
1. Install the Bitwarden CLI:
    - Download and install the Bitwarden CLI for your operating system, done by default by dotfiles.
    - Or you can do this by running the following, which is the method used by this project:

      ```shell
      brew install bitwarden-cli  # For macOS, if you use Homebrew
      # or follow instructions for your operating system in the official docs
      ```

### Test

Now, let's test that everything is working correctly.

1. Log in to Bitwarden CLI. You'll need to use your Bitwarden API key found in the Bitwarden web vault under _"Settings > Security > Keys > View API Key"_:

    ```shell
    bw login --apikey
    ```

    This command will prompt you to enter your `client_id` and `client_secret`. After successful login, you can use the CLI to fetch items from your vault.

1. Fetch your `dotfiles` Identity item.

    Use the following command to get your information and check that it's set up correctly:

    ```shell
    bw get item dotfiles | jq
    ```

    You should see output similar to this showing your details and the custom field:

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

1. Sync with Bitwarden, if you make any changes.

    If you update anything in your vault online, you can refresh your local copy by running:

    ```shell
    bw sync
    ```

> [!NOTE]
> If you see any errors or cannot log in, double-check your Bitwarden credentials and make sure the CLI is installed and available in your system's PATH.

For more information and additional commands, see the [official Bitwarden CLI documentation](https://bitwarden.com/help/cli/).
