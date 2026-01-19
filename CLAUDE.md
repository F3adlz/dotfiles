# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository managing development environment configurations for macOS and Arch Linux systems. Uses a two-tier architecture: Dotbot for symlink management and Ansible for system provisioning.

## Commands

### Install dotfiles (symlinks)
```sh
./install
```

### Provision system with Ansible
```sh
ansible-playbook ~/.dotfiles/provisioning/main.yml
```

### Run specific Ansible tags (Arch Linux only)
```sh
ansible-playbook ~/.dotfiles/provisioning/main.yml --tags=installing
ansible-playbook ~/.dotfiles/provisioning/main.yml --tags=configuration
```

## Architecture

### Dotbot Layer
- Entry point: `./install` script
- Configuration: `install.conf.yaml`
- Creates symlinks from this repo to home directory locations (git, vim, zsh, bat configs)
- Uses `dotbot-ifplatform` plugin for OS-specific actions

### Ansible Layer
- Main playbook: `provisioning/main.yml`
- OS detection via `ansible_facts['os_family']` and `ansible_facts['system']`
- **Unix common**: `unix_common` role (applies to Linux and macOS - manages /etc/hosts)
- **macOS**: Uses `macbook` role (Homebrew packages/casks, iTerm2 config, custom DNS resolvers)
- **Arch Linux**: Uses `installation` + `configuration` roles (pacman, AUR, systemd)

### Ansible Roles
- `macos_domain_custom_dns`: Configures per-domain DNS resolvers in `/etc/resolver/` (macOS only)
  - Creates resolver files for specific domains with custom nameservers
  - Automatically removes resolver files for domains not in configuration
  - Validates that each domain has at least one nameserver
  - See: https://vninja.net/2020/02/06/macos-custom-dns-resolvers/

### Key Configuration Locations
| Config | Source in Repo | Symlink Target |
|--------|----------------|----------------|
| Git | `git/.gitconfig`, `git/.gitignore` | `~/.gitconfig`, `~/.gitignore` |
| Vim | `dotfiles/vim/.vimrc`, `dotfiles/vim/.ideavimrc` | `~/.vimrc`, `~/.ideavimrc` |
| ZSH | `zsh/zshrc`, `zsh/zshenv` | `~/.zshrc`, `~/.zshenv` |
| ZSH plugins | `dotfiles/zsh/plugins/.zsh_plugins.txt` | `~/.config/zsh/.zsh_plugins.txt` |
| Aliases | `dotfiles/zsh/zsh-custom/aliases.zsh` | `~/.config/zsh/.zsh-custom/aliases.zsh` |
| Bat | `configs/bat/config` | `~/.config/bat/config` |
| Terraform | `terraformrc` | `~/.terraformrc` |

### Package Management & Host Variables
- **macOS packages**: `provisioning/roles/macbook/defaults/main.yml` (Homebrew casks/packages)
- **Arch packages**: `provisioning/host_vars/localhost/installation.yml` (pacman + AUR)
- **Unix common settings**: `provisioning/host_vars/localhost/common.yml` (/etc/hosts entries)
- **macOS settings**: `provisioning/host_vars/localhost/macos.yml` (custom DNS resolvers per domain)

## Shell Environment

- ZSH with Antidote plugin manager
- Atuin for command history synchronization
- Modern CLI replacements: bat (cat), eza (ls), fd (find), ripgrep (grep), zoxide (cd), delta (git diff)

## Code Style

- Ansible: 2-space indentation (`tabstop=2 softtabstop=2 shiftwidth=2 expandtab`)
- YAML files follow Ansible best practices
