---
name: "prompt-writing"
description: "Use when the user wants a serious prompt written, repaired, or critiqued: system prompts, developer prompts, reusable task prompts, tool-using prompts, or minimal-edit prompt surgery after a specific failure mode. Fit the prompt to the real runtime and caller contract, and say so when the real fix belongs in a better Codex surface instead."
---

# Prompt Writing

Use this skill for prompt authoring and prompt repair.

Keep this file lean. Load deeper references only when they are actually needed:

- [references/prompt-patterns.md](references/prompt-patterns.md) for prompt scaffolds, structure patterns, repair recipes, and step-back prompts

## Use this skill for

- system prompts
- developer prompts
- reusable task prompts
- tool-using prompts
- prompt critique
- prompt repair after a specific failure mode

## Do not use this skill for

- trivial rewrites, polish passes, or generic copyediting
- Codex surface-choice or workflow-design problems that really belong in `$codex-docs`
- routine image-generation prompting already covered by `$imagegen`
- ordinary coding or debugging tasks that do not involve prompt authoring

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

### 2. Prefer minimal surgery over full rewrites

- Preserve the lines that are already pulling their weight.
- Identify the actual failure mode before rewriting.
- Prefer a small number of strong edits over a full rewrite.
- Write a second variant only when there is a real tradeoff.

### 3. Prefer surface fixes over prompt bloat

- Prefer a small number of high-leverage instructions over long keyword piles.
- Move repeated stable behavior to the right surface instead of restating it in prompts.
- If several prompt revisions keep missing the goal, step back and diagnose whether the real issue is surface choice, missing context, invocation shape, tool design, or evaluation.
- If the current fix depends on semantic prompt parsing, keyword heuristics, or guessed workflow phases, that is usually evidence the fix belongs somewhere else.

### 4. Use model families and modalities intentionally

- Default general prompt recommendations to the `gpt-5.4*` family.
- Use `gpt-5.3-codex-spark` only for fast, bounded, text-first work.
- Route visual proof, browser appearance, measurement, placement, and post-edit verification away from Spark roles.
- Do not assume text-agent prompting transfers cleanly to realtime or image generation.

## Workflow

Choose one primary mode first. If the request is mixed, solve the prompt-authoring part here and bridge only the part that truly needs a second skill.

### 1. Classify the task

- existing prompt repair
- fresh prompt authoring
- workflow recommendation disguised as a prompt problem
- specialized-family prompting, such as realtime or image generation

### 2. Preserve what already works

- For repair, keep the lines that are earning their keep and change only what addresses the failure.
- For new prompts, write one strong prompt by default, not a pile of variants.
- Make the prompt fit the caller contract, not the authoring session.

### 3. Load the prompt reference when needed

- Load [references/prompt-patterns.md](references/prompt-patterns.md) when you need concrete scaffolds, structure choices, repair recipes, or the step-back meta prompt.

### 4. Bridge when the issue is not really prompt wording

- If the hard part is deciding what belongs in prompts versus hooks, skills, subagents, config, or automation, use `$codex-docs`.
- If the failure is not primarily a prompt problem, say so and recommend the better fix instead of overfitting the prompt.

## Image prompt bridge

Use this only when the request mixes prompt engineering with image work.

- Reuse `$imagegen` for raster-specific prompt schemas and execution paths.
- Keep only the cross-cutting prompt critique, framing, or structure work here.
- Do not duplicate the full image prompting guide in this skill.

## Trigger-fit check

Before finishing, sanity-check whether this skill was actually the right one.

- If the request is really about Codex surfaces, docs, hooks, skills, or automations, route to `$codex-docs`.
- If the request is really ordinary image prompting, route to `$imagegen`.
- If the request is really a simple rewrite, do not force this skill's structure.
- If the request is really implementation work, switch back to the normal coding flow.
