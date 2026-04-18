# Skills

Keep this index current whenever a top-level skill directory is added, removed, renamed, or meaningfully repurposed. `scripts/check-repo-hygiene.sh` verifies that every tracked skill is covered here.

Each skill directory should also include a short `README.md` that explains why the skill matters and what it enables in practice. The per-skill README is the quick "should I care?" layer; `SKILL.md` is the operational source of truth.

- `codex-meta`: A workflow-and-prompt design skill for Codex itself. It helps decide which behavior belongs in hooks, skills, `AGENTS.md`, config, or a more programmatic surface, and it pushes toward small surface fixes instead of prompt bloat.
- `xtool-studio`: A machine-control skill for measured placement and verification in xTool Studio. It treats geometry, target-surface identity, and fresh proof as first-class requirements so engraving setup does not devolve into visual guesswork.
