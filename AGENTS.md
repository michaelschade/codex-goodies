# Agent Guidelines

This repository is public and is meant to feed selected files into `~/.codex` on opted-in machines. Optimize for public-safe, reusable Codex surfaces over machine-local convenience.

## Source Boundary

- Only `codex-home/` is meant to sync into `~/.codex`.
- Keep auth, automations, memories, rollout logs, generated artifacts, SQLite state, caches, and other machine-local Codex files out of this repo.
- Do not copy bundled or first-party product content such as `.system` skills or `codex-primary-runtime` into this repo unless the user explicitly asks for that publication step and the licensing/publication question is resolved.
- Do not hardcode local home paths like `/Users/...` or `/home/...` in synced files. Use `$CODEX_HOME` or `~/.codex` forms instead.
- Keep hooks thin. If behavior starts depending on semantic prompt parsing or hidden workflow logic, move the fix to a better surface.

## Publishing Flow

- Use topic branches for changes. Do not push straight to `main`.
- Run `scripts/check-public-safety.sh` before opening or updating a pull request.
- Keep commits focused and informative. The commit message should say which synced surface changed and why that change is safe to publish.
- Open a pull request for meaningful changes so Codex Security can review them.
- After the required checks and review are green, enable auto-merge when repository settings allow it.

## Codex-Home Edits

- Changes inside an existing linked file or directory become live immediately on machines that already link that surface.
- Adding, removing, or renaming a top-level entry under `codex-home/skills`, `codex-home/agents`, or `codex-home/hooks` requires rerunning `bin/install --user` from the dotfiles checkout on each consuming machine to refresh the link map.
