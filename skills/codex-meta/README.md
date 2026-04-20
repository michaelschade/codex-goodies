# Codex Meta

Use this when you are using Codex to configure Codex itself. It gives Codex a system-level map of its own surfaces, from hooks, `AGENTS.md`, skills, subagents, memories, and automations to `codex exec`, the SDK, App Server, GitHub Actions, and local-state inspection.

- **Codex: automate Codex.** When Codex understands how hooks, skills, subagents, automations, and programmatic surfaces fit together, it can build new extensions with much better awareness of the rest of the system and avoid creating overlapping instructions that fight each other.
- **Get the whole platform into one mental model.** This skill pulls prompts, hooks, `AGENTS.md`, skills, subagents, automations, `codex exec`, the SDK, App Server, and GitHub Actions into one coherent map, so Codex can reason across the full system instead of rediscovering the docs topology each time.
- **Call into Codex elsewhere to build better tools and products.** It highlights the surfaces that matter when you want Codex embedded beyond a chat: the SDK when you want Codex inside an internal tool, service, or app, and App Server when you want a richer client with conversation history, streamed events, and approval-aware workflows.

Many of these pair naturally with [`$prompt-writing`](../prompt-writing/README.md): `codex-meta` decides whether something should live in a hook, skill, subagent, automation, or more programmatic surface, and `prompt-writing` helps make the chosen prompt fit that runtime and caller contract. Together, that means a rollout review that took a few revs can turn into a sharper hook, subagent, or automation design without collapsing everything into one giant prompt.

If you already know you need the full operating rules, examples, and references, jump to [`SKILL.md`](SKILL.md).
