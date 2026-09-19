---
name: brew-add-package
description: Add an official Homebrew formula or cask, or a package from a third-party tap, to this repository's Ansible declarations, validate the changes, and prepare a focused commit following repository rules. Accept an exact package name (including its tap) or a GitHub URL with Homebrew instructions in README.md. Use for adding Homebrew packages to this dotfiles repository declaratively, rather than running brew install directly.
---

# Homebrew through Ansible in dotfiles

Deliver an Ansible declaration for the requested package in this repository, completed checks, and a prepared focused commit. Do not substitute a direct `brew install` or run provisioning unless the user separately requests applying the configuration.

## Context and package identification

1. Work from the root of the repository containing this skill (`.agents/skills/brew-add-package`). If the current directory is inside this checkout, locate its root with `git rev-parse --show-toplevel`. All paths below are relative to that root; do not use a fixed home-directory path or another checkout. Read the current `AGENTS.md`, `CONTRIBUTING.md`, and any nested instructions for affected files.
2. Inspect `git status --short` and both staged and unstaged diffs. Record the initial index state so unrelated changes remain intact during commit preparation.
3. Read `provisioning/roles/macbook/defaults/main.yml` and the tasks consuming its variables in `provisioning/roles/macbook/tasks/main.yml`. Before changing the schema, identify the tasks and templates that use it.
4. Resolve the package name from the input as described below. Do not modify declarations or the index until identification succeeds.
5. Confirm the exact package name and type: formula or cask. Use targeted `brew info --formula <name>` / `brew info --cask <name>` queries, adding `--json=v2` when useful, or current official Homebrew metadata and project instructions. If the package is already installed, verify its name, type, and source with `brew list` and `brew info`. Local installation is not a prerequisite for adding a declaration.
6. For a third-party package, confirm `owner/tap` and the fully qualified `owner/tap/package` name from the tap repository or project instructions. Do not guess the owner or substitute another source for the user's choice. If the metadata is ambiguous, ask about the specific ambiguity. Do not add a tap locally merely to read a definition available in its source repository.

For changed commands, consult local `brew help <command>`, the [Homebrew Manpage](https://docs.brew.sh/Manpage), and [Taps](https://docs.brew.sh/Taps).

## Input: package name or GitHub URL

- **Exact name:** use the supplied token, including `owner/tap/package` for a third-party package. Verify the type and source while preserving the specified tap. README instructions are not required for this input type.
- **GitHub URL:** open the specified repository's `README.md` and find its Homebrew installation instructions. For a URL identifying a branch or revision, read that version's README; for a repository URL, read the default branch's README. Extract the package name and tap from the instructions (`brew install` and, when present, `brew tap`), then confirm the type using flags and Homebrew metadata. If the instructions use a separate `brew tap owner/tap` followed by `brew install` with a short name, declare the fully qualified `owner/tap/package` name.
- **No Homebrew instructions in the README:** stop without modifying declarations, staging changes, or preparing a commit. Tell the user that no Homebrew installation instructions were found and link to the README checked. Do not guess a package name from the GitHub repository name or search for an alternative package or tap to bypass this condition.
- If the README is missing or inaccessible, stop and report the specific issue; do not describe an access failure as missing instructions. If the instructions offer several packages or variants and the request does not establish which one to use, clarify before making changes.

## Update the declaration

- Add formulae to `macbook_homebrew_packages`, casks to `macbook_homebrew_casks`, and third-party taps to `macbook_homebrew_taps`.
- For a third-party package, use the fully qualified `owner/tap/package` name and a separate tap entry. Check for both before adding anything to avoid duplicates. For official packages, retain the short names used by the repository.
- Preserve alphabetical order, two-space indentation, and the structure of neighboring entries. Both formulae and casks must have nonempty `name`, `description`, and `url` fields. If the requested package already has an entry, fill in missing required fields; do not fix unrelated package entries along the way.
- The preferred sources for `description` and `url` are the selected Homebrew package's own metadata: `desc` and `homepage` from `brew info --json=v2` or its Homebrew/tap definition. Map them to `description` and `url`, respectively. Do not replace available Homebrew metadata with text or links from a GitHub README. If a metadata field is missing, use verified information from the official project; if a required field cannot be filled reliably, report the blocker instead of preparing an incomplete declaration.
- Do not import the entire locally installed package list or transitive dependencies for a single request. Do not introduce a parallel Brewfile or change unrelated settings.
- If a tap requires a custom URL, check whether the current Ansible tasks support it; do not put a URL into a string list expecting tap names. Update the schema and its consuming tasks consistently only when necessary for the requested package.
- If the complete declaration already exists, report that no changes are needed; do not create an empty commit.

## Validation

Run from the repository root:

```sh
ANSIBLE_LOCAL_TEMP=/tmp ansible-playbook provisioning/main.yml --syntax-check
git diff --check -- provisioning/roles/macbook/defaults/main.yml
```

Check any other files changed for the task as well. Separately verify that the declaration YAML parses, the package is in the correct list, the added or completed entry has nonempty `name`, `description`, and `url` fields (for both formulae and casks), no new duplicate exists, and a fully qualified package has its tap declared. Dynamic `include_role` limits the main playbook's syntax-check coverage. Use an available YAML parser, such as Python from the Ansible environment, without installing dependencies for this simple check.

Review the final diff: only the requested package, required metadata, and tap. Distinguish pre-existing worktree issues from new ones. If validation is blocked, do not claim it passed or create a commit presented as validated. A syntax check does not prove installation: do not run the entire playbook or launch the application just to validate a declaration.

## Prepare the commit

After checks pass, prepare a focused commit following the current `CONTRIBUTING.md`:

- Use Conventional Commits: `<type>(<scope>): <summary>`, with a lowercase English summary in the imperative mood and no trailing period. Typical examples are `chore(homebrew): add <name> formula` and `chore(homebrew): add <name> cask`. Append `and tap` only when this commit actually adds a new tap entry, for example `chore(homebrew): add <name> cask and tap`; the same rule applies to formulae. If the tap is already declared, do not claim to add it in the commit message.
- If the index was initially empty, stage only your files or hunks. When a file also contains unrelated edits, stage selectively instead of adding the entire file.
- If the index already contains unrelated changes, preserve them unchanged. Prepare a separate patch containing only your edits and a commit message, explaining why you kept them separate from the current index. Do not unstage unrelated changes.
- Review the prepared diff, its scope, and whitespace (`git diff --cached --check` when the initial index was empty; for a separate patch, validate using an isolated index or working copy). Do not use `git add .` or `git commit -a`.
- “Prepare a commit” means preparing validated changes and a message. If the user explicitly asks to create the commit, do so without requesting permission again, keeping it isolated from unrelated staged changes. After creation, verify its exact contents with `git show --stat --oneline HEAD` and `git show --format=fuller HEAD`. Do not push unless requested.

In the final response, identify the added package, type, tap, declaration file, completed checks, and commit state: staged changes or a separate patch with a proposed message, or the hash of a created commit. Make clear that installation has only been declared in Ansible if the configuration was not applied.
