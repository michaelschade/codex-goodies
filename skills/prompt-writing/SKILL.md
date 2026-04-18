---
name: "prompt-writing"
description: "Use when the user wants a serious prompt written, repaired, or critiqued: system prompts, developer prompts, reusable task prompts, tool-using prompts, or minimal-edit prompt surgery after a specific failure mode. Fit the prompt to the real runtime and caller contract, and diagnose when wording is not the real issue."
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

Choose one primary prompt task first. Keep the work anchored on the prompt artifact and the behavior it needs to produce.

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

### 4. Step back when wording is not the real problem

- If the draft keeps growing without improving the outcome, diagnose whether the issue is missing context, caller contract, tool design, or evaluation.
- Say plainly when another prompt rewrite will not solve the failure mode.
- Keep the prompt deliverable clean even when the surrounding diagnosis reaches beyond wording.

## Specialized modalities

Use this only when the request genuinely needs prompt work for a specialized modality.

- Keep the focus on cross-cutting framing, structure, and repair.
- Do not turn this skill into a domain-specific execution guide.
- Do not assume text-agent prompting transfers cleanly to every modality.
