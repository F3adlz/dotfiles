# Contributing

## Commit messages

Use Conventional Commits while keeping the repository's existing concise,
imperative style:

```text
<type>(<scope>): <summary>
```

- Write the summary in English, lowercase, imperative mood, without a trailing
  period.
- Use a scope when it makes the affected area clearer, for example `zsh`,
  `ansible`, `git`, or `docs`.
- Keep each commit focused on one logical change.
- Add a body when the motivation or a non-obvious migration needs explanation.
- Mark breaking changes with `!` before the colon and add a
  `BREAKING CHANGE: <description>` footer.

Common types:

- `feat`: add user-visible functionality.
- `fix`: correct broken behavior.
- `docs`: change documentation only.
- `refactor`: restructure code without changing behavior.
- `test`: add or update tests.
- `perf`: improve performance.
- `build`: change dependencies or build tooling.
- `ci`: change continuous integration.
- `chore`: perform repository maintenance not covered above.

Examples:

```text
fix(zsh): align startup files with ZDOTDIR
feat(ansible): add custom DNS resolver role
docs: document bootstrap workflow
```
