# codex-goodies Contributor Guidance

This file is for work inside the `codex-goodies` repository itself. The managed source copied into `~/.codex/AGENTS.md` lives at [`references/AGENTS.md`](references/AGENTS.md); keep shared cross-machine Codex guidance there and keep this file focused on repo-local contributor rules.

## Repository Scope

- This repository is public and is meant to feed selected files into `~/.codex` on opted-in machines. Optimize for public-safe, reusable Codex surfaces over machine-local convenience.
- Dotfiles copies `references/AGENTS.md` into `~/.codex/AGENTS.md`, links `hooks.json`, and symlinks the top-level runtime entries under `agents/`, `hooks/`, and `skills/`. Repo docs such as `README.md`, `CONTRIBUTING.md`, `docs/`, `scripts/`, `.github/`, and the directory index READMEs stay repo-local.
- Keep auth, automations, memories, rollout logs, generated artifacts, SQLite state, caches, and other machine-local Codex files out of this repo.
- Do not copy bundled or first-party product content such as `.system` skills or `codex-primary-runtime` into this repo unless the user explicitly asks for that publication step and the licensing or publication question is resolved.
- Do not hardcode local home paths like `/Users/...` or `/home/...` in synced files. Use `$CODEX_HOME` or `~/.codex` forms instead.
- Keep hooks thin. If behavior starts depending on semantic prompt parsing or hidden workflow logic, move the fix to a better surface.

## Docs and Surface Maintenance

- Keep `agents/README.md`, `hooks/README.md`, and `skills/README.md` current. Adding, removing, or renaming a top-level runtime entry under `agents/`, `hooks/`, or `skills/` requires updating the matching README and rerunning `bin/install --user` from the dotfiles checkout on each consuming machine so the Codex home layout refreshes.
- Keep each skill directory's `README.md` current as well. It should explain the use cases and user-visible value of that skill without duplicating the full `SKILL.md`.
- When editing README or skill-overview copy in this repo, follow the `Writing and Explanatory Copy` guidance in [`references/AGENTS.md`](references/AGENTS.md).

## Git and Review Flow

- Use topic branches for changes. Do not push straight to `main`.
- Keep the repo-local pre-commit hook active so `scripts/check-public-safety.sh --staged` catches machine-local or secret content before push.
- Run `scripts/check-repo-hygiene.sh` before opening or updating a pull request.
- For this public repo, the commit message should also say which shared surface changed and why that change is safe to publish.
- Open a pull request for meaningful changes so Codex Security can review them.
- Prefer same-repo, non-draft pull requests that target `main`; the `Arm Auto-merge` workflow will request squash auto-merge for those PRs when repository settings allow it.
- Keep [`docs/repo-settings.md`](docs/repo-settings.md) aligned with the actual GitHub rules and required checks.
