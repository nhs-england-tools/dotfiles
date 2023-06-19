# Terminal Usage

- [Terminal Usage](#terminal-usage)
  - [TODO: Create documentation](#todo-create-documentation)

## TODO: Create documentation

- iTerm

Back up and restore iTerm configuration settings.

```shell
defaults export com.googlecode.iterm2 assets/iterm2/com.googlecode.iterm2.plist
plutil -convert xml1 -o assets/iterm2/com.googlecode.iterm2.xml assets/iterm2/com.googlecode.iterm2.plist
cp assets/iterm2/com.googlecode.iterm2.xml assets/iterm2/settings.xml
# Format `assets/iterm2/settings.xml` in vscode
defaults import com.googlecode.iterm2 assets/iterm2/settings.xml
```

- Oh-My-Zsh
- Powerlevel10k
