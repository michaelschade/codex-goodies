---
name: "codex-meta"
description: "Use when the user wants to design or improve Codex workflows or non-trivial prompts: hooks, subagents, skills, AGENTS.md or PLANS.md guidance, system or developer prompts, or reusable tool-using prompts. Inspect the current local Codex setup before recommending Codex-meta changes. Do not use for trivial rewrites, ordinary implementation work, or routine image prompting already handled by imagegen."
---

# Codex Meta

Use this skill for two related jobs:

1. Codex workflow design
2. Serious prompt authoring

Keep this file lean. Load deeper references only when they are actually needed:

- [references/prompt-patterns.md](references/prompt-patterns.md) for prompt scaffolds, structure patterns, repair recipes, and step-back prompts
- [references/codex-system.md](references/codex-system.md) for surface choice, hooks, subagents, memories, config, and grouped doc scaffolding
- [references/codex-programmatic.md](references/codex-programmatic.md) for `codex exec`, the SDK, App Server, GitHub Action, and embedded or CI Codex workflows
- [references/codex-local-state.md](references/codex-local-state.md) for privacy-safe self-inspection of local Codex sessions, rollouts, memories, logs, automations, and SQLite state

## Use this skill for

- hooks, subagents, skills, `AGENTS.md`, `PLANS.md`, and Codex workflow design
- system prompts, developer prompts, reusable task prompts, and prompt repair
- deciding what belongs in prompts versus Codex surfaces
- deciding when a workflow should move into `codex exec`, the SDK, App Server, GitHub Action, or automation
- privacy-safe introspection of local Codex history and state when the task is about improving Codex using prior sessions, rollout artifacts, logs, memories, or automation state

## Do not use this skill for

- trivial rewrites, polish passes, or generic copyediting
- ordinary coding or debugging tasks that do not involve Codex workflow design
- routine image-generation prompting already covered by `$imagegen`

## Core rules

### 1. Match the runtime and caller contract

Before writing or revising a prompt, decide:

- where it will run
- what context the caller will already provide
- what answer shape the caller expects back

Then:

- include only the context that materially changes behavior in that runtime
- cut incidental repo names, session artifacts, and irrelevant internal context
- do not rely on ambient context that will not really exist when the prompt runs

### 2. Prefer surface fixes over prompt bloat

- Prefer a small number of high-leverage instructions over long keyword piles.
- Move repeated stable behavior to the right surface instead of restating it in prompts.
- If several prompt revisions keep missing the goal, step back and diagnose whether the real issue is surface choice, missing context, invocation shape, tool design, or evaluation.
- If the current fix depends on semantic prompt parsing, keyword heuristics, or guessed workflow phases, that is usually evidence the fix belongs somewhere else.

### 2.5 Treat local `~/.codex` findings as approval-gated

- Anything derived from inspecting local `~/.codex` state is private by default.
- You may use local `~/.codex` artifacts for diagnosis, private analysis, or identifying possible patterns.
- Do not document new concepts, features, product behavior, or reusable guidance into this skill from local `~/.codex` evidence unless the user explicitly approves that documentation step.
- If local evidence suggests an interesting new concept or behavior, stop before editing public-bound skill content and ask for permission to promote that lesson into the skill.
- Prefer official OpenAI docs and other public sources for durable skill guidance. Treat local `~/.codex` evidence as a private hint or validation layer, not an automatic source for public documentation.

### 3. Keep hooks thin and pick the right Codex surface

- Hooks are for concise lifecycle context injection, light plumbing, or crisp objective guardrails.
- Do not use hooks as semantic planners, prompt classifiers, or hidden workflow engines.
- If nuanced judgment is required, prefer better model-facing instructions, better surface choice, better agent design, or a better evaluation loop.
- Load [references/codex-system.md](references/codex-system.md) when the hard part is surface choice across hooks, `AGENTS.md`, skills, subagents, config, MCP, worktrees, memories, or automations.
- Load [references/codex-programmatic.md](references/codex-programmatic.md) when the hard part is `codex exec`, the SDK, App Server, GitHub Action, or Codex as infrastructure inside a larger system.

### 4. Use model families intentionally

- Default general recommendations to the `gpt-5.4*` family.
- Use `gpt-5.3-codex-spark` only for fast, bounded, text-first work.
- Route visual proof, browser appearance, measurement, placement, and post-edit verification away from Spark roles.
- Do not assume text-agent prompting transfers cleanly to realtime or image generation.

## Mode router

Choose one primary mode first. If the request is mixed, solve the primary mode and bridge only the part that truly needs the second mode.

### 1. Codex workflow mode

Use for:

- hooks
- subagents
- skills
- `AGENTS.md`
- `PLANS.md`
- config-aware workflow design
- prompt or process architecture for Codex itself
- deciding when Codex should be interactive, automated, scripted, embedded, or event-driven

Start by inspecting live local context before recommending changes:

- `~/.codex/config.toml`
- `~/.codex/hooks.json`
- `~/.codex/agents/*.toml`
- directly relevant local skills under `~/.codex/skills/`
- repo-local `AGENTS.md`, `PLANS.md`, or repo skills when the task is repository-scoped

Default questions:

- what is the smallest safe change surface?
- should this live in a prompt, `AGENTS.md`, a skill, a hook, config, a subagent, automation, or a programmatic Codex surface?
- is the current proposal really fixing the root cause?

If the hard part is surface choice, config, hooks, subagents, or doc navigation, load [references/codex-system.md](references/codex-system.md).

If the hard part is CI, structured automation, embedded Codex, custom clients, or Codex as infrastructure, load [references/codex-programmatic.md](references/codex-programmatic.md).

If the hard part is learning from local rollout artifacts, session files, memories, logs, automations, or SQLite state without leaking sensitive content, load [references/codex-local-state.md](references/codex-local-state.md).

### 2. Prompt authoring mode

Use for:

- system prompts
- developer prompts
- reusable task prompts
- tool-using prompts
- prompt critique
- prompt repair after a specific failure mode

First classify the task:

- existing prompt repair
- fresh prompt authoring
- workflow recommendation disguised as a prompt problem
- specialized-family prompting, such as realtime or image generation

Defaults:

- For repair, preserve the lines that work and make the smallest change set that addresses the real failure.
- For new prompts, write one strong prompt by default, not a pile of variants.
- Make the prompt fit the caller contract, not the authoring session.
- If the failure is not primarily a prompt problem, say so and recommend the better fix.

Load [references/prompt-patterns.md](references/prompt-patterns.md) when you need concrete scaffolds, structure choices, repair recipes, or the step-back meta prompt.

### 3. Image prompt bridge

Use this mode only when the request mixes prompt engineering with image work.

- Reuse `$imagegen` for raster-specific prompt schemas and execution paths.
- Keep only the cross-cutting prompt critique, framing, or structure work here.
- Do not duplicate the full image prompting guide in this skill.

## Live facts

Use live docs only when the recommendation depends on drift-sensitive facts such as:

- current model names or preferred families
- current Codex feature behavior
- newly released guides or docs that may supersede older local guidance

Prefer official OpenAI sources. If `$openai-docs` is available, prefer it. Use the local references above to keep the main skill small and load live docs only when the details are likely to have changed.

## Trigger-fit check

Before finishing, sanity-check whether this skill was actually the right one.

- If the request was really ordinary image prompting, route to `$imagegen`.
- If the request was really a simple rewrite, do not force this skill's structure.
- If the request was really implementation work, switch back to the normal coding flow.
