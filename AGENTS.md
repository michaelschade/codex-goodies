# Global Working Norms

## Subagent Workflow

- Treat delegation as a normal tool for substantial work, not as a rare exception.
- For a non-trivial task, make an explicit delegation decision early instead of letting the first exploratory step quietly claim the whole workflow.
- When a task has multiple meaningful components, different modality needs, or a risk of polluting the parent thread with noisy intermediate work, decide whether one of those components should be owned by a subagent.
- Sequential phases can still be real delegation boundaries when one phase can hand a compact result to the next.
- Prefer subagents when they create a real handoff boundary, reduce context pollution, enable parallel progress, or provide a better model or proof posture for one component.
- Do not spawn subagents for tiny errands, tightly coupled micro-steps, or parallel work on the same active surface.
- Keep one owner per surface at a time.
- Keep the parent on requirements, user communication, shared-state decisions, and final synthesis.
- If a non-trivial task stays entirely in the parent, be able to name the coupling reason clearly in the plan or working notes.

## Agent Routing

- Use `scout` for substantial read-heavy exploration, evidence gathering, browser or app observation, and rollout or log archaeology.
- Use `builder` for one bounded text-first implementation or artifact-prep component after scope is clear.
- Use `precision` for visual or stateful workflows, exacting analysis, risky logic, and work where fresh proof matters more than speed.
- Spark is for bounded text-first work. If success depends on visual evidence, rendered layout, spatial relationships, browser or app state, measurement, placement, or post-action proof, prefer a non-Spark owner for that component.

## Planning

- When using `update_plan` for a multi-part task, make the ownership boundary visible when it helps decision quality.
- If one component is noisy exploration and another is downstream creation, implementation, or stateful execution, consider whether the exploratory component should be delegated before starting it.
- If one component needs stronger proof requirements or a different modality than the rest of the task, consider giving that component its own owner rather than keeping the whole task in the parent by default.

## codex-goodies Repository

When the current repository is `codex-goodies`:

- This repository is public and is meant to feed selected files into `~/.codex` on opted-in machines. Optimize for public-safe, reusable Codex surfaces over machine-local convenience.
- Dotfiles links only `AGENTS.md`, `hooks.json`, and the top-level runtime entries under `agents/`, `hooks/`, and `skills/` into `~/.codex`. Repo docs such as `README.md`, `CONTRIBUTING.md`, `docs/`, `scripts/`, `.github/`, and the directory index READMEs stay repo-local.
- Keep auth, automations, memories, rollout logs, generated artifacts, SQLite state, caches, and other machine-local Codex files out of this repo.
- Do not copy bundled or first-party product content such as `.system` skills or `codex-primary-runtime` into this repo unless the user explicitly asks for that publication step and the licensing or publication question is resolved.
- Do not hardcode local home paths like `/Users/...` or `/home/...` in synced files. Use `$CODEX_HOME` or `~/.codex` forms instead.
- Keep hooks thin. If behavior starts depending on semantic prompt parsing or hidden workflow logic, move the fix to a better surface.
- Keep `agents/README.md`, `hooks/README.md`, and `skills/README.md` current. Adding, removing, or renaming a top-level runtime entry under `agents/`, `hooks/`, or `skills/` requires updating the matching README and rerunning `bin/install --user` from the dotfiles checkout on each consuming machine so dotfiles can refresh the link map.
- Use topic branches for changes. Do not push straight to `main`.
- Run `scripts/check-public-safety.sh` before opening or updating a pull request.
- Keep commits focused and informative. The commit message should say which shared surface changed and why that change is safe to publish.
- Open a pull request for meaningful changes so Codex Security can review them.
- Prefer same-repo, non-draft pull requests that target `main`; the `Arm Auto-merge` workflow will request squash auto-merge for those PRs when repository settings allow it.
- Keep [`docs/repo-settings.md`](docs/repo-settings.md) aligned with the actual GitHub rules and required checks.
