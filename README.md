# codex-goodies

`codex-goodies` is the public source of truth for the Codex surfaces that are safe and useful to share across machines.

The repo root is the shared surface. Dotfiles links the reviewed root runtime files and directories into `~/.codex` on machines that opt in, while the rest of `~/.codex` stays machine-local.

## What Syncs

- `AGENTS.md`
- `hooks.json`
- `agents/*.toml`
- `hooks/*` except `hooks/README.md`
- `skills/*`

The top-level README files inside `agents/`, `hooks/`, and `skills/` are for humans browsing the repo. They should explain the current surface clearly, but dotfiles does not link them into `~/.codex`.

## What Stays Repo-Local

- `README.md`
- `CONTRIBUTING.md`
- `docs/`
- `scripts/`
- `.github/`
- the directory index READMEs under `agents/`, `hooks/`, and `skills/`

## What Stays Local

- `~/.codex/auth.json`
- `~/.codex/automations/`
- `~/.codex/memories/`
- `~/.codex/sessions/` and `~/.codex/archived_sessions/`
- `~/.codex/generated_images/`
- `~/.codex/*.sqlite*`
- cache, logs, rollout indexes, and other runtime state

## Workflow

1. Edit the shared root-level surfaces directly.
2. If you changed files inside an existing linked skill, hook, or agent, the live `~/.codex` surface updates immediately through the symlink.
3. If you add, remove, or rename a top-level entry under `skills/`, `agents/`, or `hooks/`, update that directory's `README.md` in the same change.
4. If you add, remove, or rename a top-level entry under `skills/`, `agents/`, or `hooks/`, rerun `bin/install --user` from the dotfiles checkout on each consuming machine so dotfiles can refresh the link map.
5. Let the repo-local pre-commit hook run `scripts/check-public-safety.sh --staged` so publish-safety issues are caught before the commit leaves your machine. Dotfiles-managed checkouts should keep `core.hooksPath=.githooks` configured automatically; for a manual clone, run `git config core.hooksPath .githooks` once. You can also run `scripts/check-public-safety.sh` manually if you want to audit the staged commit or the full tracked repo.
6. Run `scripts/check-repo-hygiene.sh`.
7. Commit on a topic branch and open a pull request from this repository.
8. Request Codex Security review.
9. For non-draft PRs that target `main` from this repository, the `Arm Auto-merge` workflow automatically requests squash auto-merge when repository settings allow it. GitHub then waits for the required checks and review to turn green before merging.

## Layout

- [`AGENTS.md`](AGENTS.md): the shared global AGENTS surface plus `codex-goodies`-specific publication rules
- [`CONTRIBUTING.md`](CONTRIBUTING.md): commit and PR hygiene
- [`agents/README.md`](agents/README.md): human-readable guide to the published subagent roles
- [`hooks/README.md`](hooks/README.md): human-readable guide to the published hooks
- [`skills/README.md`](skills/README.md): human-readable guide to the published skills
- [`docs/repo-settings.md`](docs/repo-settings.md): one-time GitHub settings needed for review-gated auto-merge
- [`.githooks/pre-commit`](.githooks/pre-commit): repo-local hook that runs publish-safety and repo-hygiene before commits
- [`scripts/check-public-safety.sh`](scripts/check-public-safety.sh): publish-safety checks that catch sensitive or machine-local content before push
- [`scripts/check-repo-hygiene.sh`](scripts/check-repo-hygiene.sh): deterministic shape and README-index checks that are safe to run in CI
- [`.github/workflows/repo-hygiene.yml`](.github/workflows/repo-hygiene.yml): CI for repo-hygiene on PRs and pushes
- [`.github/workflows/arm-auto-merge.yml`](.github/workflows/arm-auto-merge.yml): auto-arms squash auto-merge for same-repo PRs

## License

This repository uses the Apache 2.0 license in [`LICENSE`](LICENSE).
