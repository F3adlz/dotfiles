# AGENTS.md

This file provides guidance to coding agents working with code in this repository.

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
- **macOS**: Uses `macbook` role (Homebrew packages/casks, iTerm2 config, Touch ID for sudo, custom DNS resolvers)
- **Arch Linux**: Uses `installation` + `configuration` roles (pacman, AUR, systemd)

### Ansible Configuration
- `become_flags = -H` in `provisioning/ansible.cfg`: Removes default `-S` flag so that sudo uses PAM/Touch ID instead of stdin for authentication

### Ansible Migrations
- Migrations are temporary transitions from a previously managed state to the
  current configuration. They may concern packages, files, services, preferences,
  or other resources; keep them in the role that owns those resources.
- Put simple migrations in `provisioning/roles/<role>/tasks/migrations.yml`.
  Import that file explicitly from the role's `tasks/main.yml` with
  `ansible.builtin.import_tasks`, a generic name such as `Run migrations`, and
  the `migrations` tag. Run it after prerequisites and before tasks that depend
  on the migrated state. Do not create empty migration files for other roles.
- Migrations run during normal provisioning, without an opt-in flag or the
  `never` tag. Tags must not accidentally bypass required migration ordering.
  A tag on an imported task file does not make its parent dynamic `include_role`
  reachable with `--tags`; verify the full include chain before documenting a
  command to run migrations in isolation.
- Keep simple migrations inline. Move complex migrations into descriptively
  named `tasks/migrations/<name>.yml` files, imported explicitly from
  `migrations.yml` in dependency order; do not discover them with a glob.
- Each migration must be idempotent and safe to retry after interruption.
  Use actual resource state rather than a marker that merely records an attempt,
  and guard the migration with the configuration that requires it. Preserve user
  data and settings unless their removal is explicitly part of the requested change.
- Document each migration with `Added`, `Reason`, and `Remove after` comments.
  Include an issue or other source link when useful. Remove the migration and its
  imports only after all managed machines have transitioned and the old state is
  no longer supported; age alone is not sufficient. Remove empty migration files.
- Validate the containing role with a static role import or role-based syntax
  check, since the main playbook uses dynamic role includes. Check the applicable,
  skipped, and already-migrated cases where relevant. Distinguish syntax checks,
  check-mode predictions, and actual migration execution in reports.

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
| ZSH environment | `zsh/zshenv` | `~/.zshenv` |
| ZSH login profile | `dotfiles/zsh/zprofile` | `~/.config/zsh/.zprofile` |
| ZSH interactive config | `zsh/zshrc` | `~/.config/zsh/.zshrc` |
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
- `~/.zshenv` exports `ZDOTDIR=~/.config/zsh`; machine-specific environment variables belong in unmanaged `~/.zshenv.local`
- Atuin for command history synchronization
- Modern CLI replacements: bat (cat), eza (ls), fd (find), ripgrep (grep), zoxide (cd), delta (git diff)

## Code Style

- Ansible: 2-space indentation (`tabstop=2 softtabstop=2 shiftwidth=2 expandtab`)
- YAML files follow Ansible best practices
