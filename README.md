# codex-goodies

`codex-goodies` is the public source of truth for the Codex surfaces that are safe and useful to share across machines.

The synced surface lives under [`codex-home/`](codex-home/). Dotfiles links that subtree into `~/.codex` on machines that opt in, while the rest of `~/.codex` stays machine-local.

## What Syncs

- `codex-home/AGENTS.md`
- `codex-home/agents/*.toml`
- `codex-home/hooks.json`
- `codex-home/hooks/*`
- `codex-home/skills/*`

## What Stays Local

- `~/.codex/auth.json`
- `~/.codex/automations/`
- `~/.codex/memories/`
- `~/.codex/sessions/` and `~/.codex/archived_sessions/`
- `~/.codex/generated_images/`
- `~/.codex/*.sqlite*`
- cache, logs, rollout indexes, and other runtime state

## Workflow

1. Edit files under `codex-home/`.
2. If you changed files inside an existing linked skill, hook, or agent, the live `~/.codex` surface updates immediately through the symlink.
3. If you add, remove, or rename a top-level entry under `codex-home/skills`, `codex-home/agents`, or `codex-home/hooks`, rerun `bin/install --user` from the dotfiles checkout on each machine so dotfiles can refresh the link map.
4. Run `scripts/check-public-safety.sh`.
5. Commit on a topic branch and open a pull request from this repository.
6. Request Codex Security review.
7. For non-draft PRs that target `main` from this repository, the `Arm Auto-merge` workflow automatically requests squash auto-merge when repository settings allow it. GitHub then waits for the required checks and review to turn green before merging.

## Layout

- [`AGENTS.md`](AGENTS.md): repo-specific instructions for agents working in this public repo
- [`CONTRIBUTING.md`](CONTRIBUTING.md): commit and PR hygiene
- [`codex-home/`](codex-home/): the only subtree dotfiles links into `~/.codex`
- [`docs/repo-settings.md`](docs/repo-settings.md): one-time GitHub settings needed for review-gated auto-merge
- [`scripts/check-public-safety.sh`](scripts/check-public-safety.sh): deterministic public-safety and shape checks
- [`.github/workflows/public-safety.yml`](.github/workflows/public-safety.yml): CI for PRs and pushes
- [`.github/workflows/arm-auto-merge.yml`](.github/workflows/arm-auto-merge.yml): auto-arms squash auto-merge for same-repo PRs

## License

This repository uses the Apache 2.0 license in [`LICENSE`](LICENSE).
