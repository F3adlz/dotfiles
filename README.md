# Provisioning
```sh
ansible-playbook ~/.dotfiles/provisioning/main.yml
```
# Dotfiles
## Requirements
* Antidote (zsh plugin manager)
## Description
 * Atuin is used for command history and synchronization alongside standard ZSH
 shell history

## Zsh configuration

Zsh reads `~/.zshenv` first. This file exports
`ZDOTDIR="$HOME/.config/zsh"`, so the remaining startup files are installed
under `~/.config/zsh`:

| Startup file | Location |
|--------------|----------|
| `.zshenv` | `~/.zshenv` |
| `.zprofile` | `~/.config/zsh/.zprofile` |
| `.zshrc` | `~/.config/zsh/.zshrc` |

Machine-specific environment variables can be placed in `~/.zshenv.local`.
This local file is sourced by `.zshenv` and is not managed by this repository.

## Usage
[dotbot](https://github.com/anishathalye/dotbot)

# OS X
https://holmberg.io/moving-word-by-word-in-iterm/
https://stackoverflow.com/a/71337138
https://github.com/junegunn/fzf/issues/164
