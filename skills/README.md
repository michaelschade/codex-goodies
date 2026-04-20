# Skills

Keep this index current whenever a top-level skill directory is added, removed, renamed, or meaningfully repurposed. `scripts/check-repo-hygiene.sh` verifies that every tracked skill is covered here.

Each skill directory should also include a short `README.md` that explains why the skill matters and what it enables in practice. The per-skill README is the quick "should I care?" layer; `SKILL.md` is the operational source of truth.

- `codex-meta`: A Codex workflow and docs-navigation skill. It helps decide which behavior belongs in hooks, skills, `AGENTS.md`, config, automations, or a more programmatic Codex surface, and how those surfaces should be shaped without collapsing everything into prompt text.
- `prompt-writing`: A serious prompt-authoring skill. It writes and repairs system prompts, developer prompts, reusable task prompts, and tool-using prompts while keeping them aligned with the real runtime, execution surface, and caller contract once that surface is known.
- `xtool-studio`: A machine-control skill for measured placement and verification in xTool Studio. It treats geometry, target-surface identity, and fresh proof as first-class requirements so engraving setup does not devolve into visual guesswork.
