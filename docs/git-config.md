# Git Config

## Table of contents

- [Git Config](#git-config)
  - [Table of contents](#table-of-contents)
  - [Configuration](#configuration)
  - [Signing commits](#signing-commits)
    - [Troubleshooting](#troubleshooting)
  - [Additional useful settings and commands](#additional-useful-settings-and-commands)

## Configuration

<!-- markdownlint-disable-next-line no-inline-html -->
The commands below will configure your Git command-line client globally. Please, update your username (<span style="color:red">Your Name</span>) and email address (<span style="color:red">youremail@domain</span>) in the code snippet below prior to executing it.

This configuration is to support trunk-based development and git linear history.

```shell
git config user.name "Your Name" # Use your full name here
git config user.email "youremail@domain" # Use your email address here
git config branch.autosetupmerge false
git config branch.autosetuprebase always
git config commit.gpgsign true
git config core.autocrlf input
git config core.filemode true
git config core.hidedotfiles false
git config core.ignorecase false
git config credential.helper cache
git config pull.rebase true
git config push.default current
git config push.followTags true
git config rebase.autoStash true
git config remote.origin.prune true
```

This is already set in the [`dot_gitconfig.tmpl`](https://github.com/make-ops-tools/dotfiles/blob/main/dot_gitconfig.tmpl) file, that is used as a template to create `~/.gitconfig`.

More information on the git settings can be found in the [Git Reference documentation](https://git-scm.com/docs).

## Signing commits

Signing Git commits is a good practice and ensures the correct web of trust has been established for the distributed version control management.

<!-- markdownlint-disable-next-line no-inline-html -->
If you do not have it already generate a new pair of GPG keys. Please, change the passphrase (<span style="color:red">pleaseChooseYourKeyPassphrase</span>) below and save it in your password manager.

```shell
USER_NAME="Your Name"
USER_EMAIL="your.name@email"
file=$(echo $USER_EMAIL | sed "s/[^[:alpha:]]/-/g")

mkdir -p "$HOME/.gnupg"
chmod 0700 "$HOME/.gnupg"
cd "$HOME/.gnupg"
cat > "$file.gpg-key.script" <<EOF
  %echo Generating a GPG key
  Key-Type: ECDSA
  Key-Curve: nistp256
  Subkey-Type: ECDH
  Subkey-Curve: nistp256
  Name-Real: $USER_NAME
  Name-Email: $USER_EMAIL
  Expire-Date: 0
  Passphrase: pleaseChooseYourKeyPassphrase
  %commit
  %echo done
EOF
gpg --batch --generate-key "$file.gpg-key.script"
rm "$file.gpg-key.script"
# or do it manually by running `gpg --full-gen-key`
```

Make note of the ID and save the keys.

```shell
gpg --list-secret-keys --keyid-format LONG $USER_EMAIL
```

You should see a similar output to this

```shell
sec   nistp256/AAAAAAAAAAAAAAAA 2023-01-01 [SCA]
      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
uid                 [ultimate] Your Name <your.name@email>
ssb   nistp256/BBBBBBBBBBBBBBBB 2023-01-01 [E]
```

Export your keys.

```shell
ID=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
gpg --armor --export $ID > $file.gpg-key.pub
gpg --armor --export-secret-keys $ID > $file.gpg-key
```

Import already existing private key.

```shell
gpg --import $file.gpg-key
```

Remove keys from the GPG agent if no longer needed.

```shell
gpg --delete-secret-keys $ID
gpg --delete-keys $ID
```

Configure Git to use the new key.

```shell
git config user.signingkey $ID
```

Upload the public key to your GitHub profile into the [GPG keys](https://github.com/settings/keys) section. After doing so, please make sure your email address appears as verified against the commits pushed to the remote.

```shell
cat $file.gpg-key.pub
```

### Troubleshooting

If you receive the error message "error: gpg failed to sign the data", make sure you added `export GPG_TTY=$(tty)` to your `~/.zshrc` or other file that is sourced by it, like `~/.exports` and restarted your terminal.

```shell
sed -i '/^export GPG_TTY/d' ~/.exports
echo export GPG_TTY=\$\(tty\) >> ~/.exports
```

## Additional useful settings and commands

Configure caching git commit signature passphrase for 3 hours

```shell
source ~/.zshrc
mkdir -p ~/.gnupg
sed -i '/^pinentry-program/d' ~/.gnupg/gpg-agent.conf 2>/dev/null ||:
echo "pinentry-program $(whereis -q pinentry)" >> ~/.gnupg/gpg-agent.conf
sed -i '/^default-cache-ttl/d' ~/.gnupg/gpg-agent.conf
echo "default-cache-ttl 10800" >> ~/.gnupg/gpg-agent.conf
sed -i '/^max-cache-ttl/d' ~/.gnupg/gpg-agent.conf
echo "max-cache-ttl 10800" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
```

Please, see the [`assets/03-install-developer-tools.macos.sh`](https://github.com/make-ops-tools/dotfiles/blob/main/assets/03-install-developer-tools.macos.sh) file, as this section is part of the automated configuration.

Authenticate to GitHub and set up your authorisation token

```shell
$ gh auth login
? What account do you want to log into? GitHub.com
? What is your preferred protocol for Git operations? HTTPS
? Authenticate Git with your GitHub credentials? No
? How would you like to authenticate GitHub CLI? Paste an authentication token
Tip: you can generate a Personal Access Token here https://github.com/settings/tokens
The minimum required scopes are 'repo', 'read:org'.
? Paste your authentication token: github_pat_**********************************************************************************
- gh config set -h github.com git_protocol https
✓ Configured git protocol
✓ Logged in as your-github-handle
```

Add your changes, create a signed commit, update from and push to remote

```shell
git add .
git commit -S -m "This is a signed commit message"
git pull
git push
```
