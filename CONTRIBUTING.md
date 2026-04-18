# Contributing

## Commit Hygiene

- Keep one idea per commit when practical.
- Use a branch name that describes the change. `codex/...` is the default branch prefix.
- Write commit messages that name the synced surface and the reason for the change.
- Call out any public-safety impact in the commit body when relevant, especially if the change touches hooks, cross-machine instructions, or anything that could accidentally leak local state.
- Avoid vague subjects like `misc`, `updates`, or `fix stuff`.

## PR Hygiene

- Open a pull request instead of merging straight to `main`.
- Keep the PR description explicit about which shared root surfaces changed and why they belong in a public repo.
- Mention whether consuming machines need to rerun `bin/install --user` because a top-level linked entry was added, removed, or renamed.
- Update `agents/README.md`, `hooks/README.md`, or `skills/README.md` in the same change whenever the corresponding top-level runtime entries change.
- Request Codex Security review before merge.
- Open the PR from a branch in this repository when you want the `Arm Auto-merge` workflow to request squash auto-merge automatically.
- Keep [`docs/repo-settings.md`](docs/repo-settings.md) in sync with the actual GitHub branch-protection and auto-merge configuration.

## Required Check

- Run `scripts/check-public-safety.sh` before pushing.
