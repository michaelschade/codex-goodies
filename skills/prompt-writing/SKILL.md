---
name: "prompt-writing"
description: "Use when the user wants a prompt written, repaired, or critiqued for a known runtime, stage, model family, or modality: system prompts, developer prompts, reusable task prompts, tool-using or reasoning-model prompts, image prompts, realtime prompts, or minimal-edit prompt surgery after a specific failure mode. Fit the prompt to the real runtime and caller contract, keep it concise, generalize from example feedback, and diagnose when wording is not the real issue."
---

# Prompt Writing

Use this skill when the deliverable is a prompt and the runtime or surface is already clear.

Keep this file lean. Load deeper references only when they are actually needed:

- [references/principles.md](references/principles.md) for cross-runtime prompt principles
- [references/reasoning-models.md](references/reasoning-models.md) for GPT-5-class, reasoning-model, and tool-heavy prompt behavior
- [references/repair.md](references/repair.md) for prompt surgery and step-back tests
- [references/prompt-shapes.md](references/prompt-shapes.md) for compact prompt shapes and when to use them
- [references/modalities/image-generation.md](references/modalities/image-generation.md) for image-prompt structure and examples
- [references/modalities/realtime.md](references/modalities/realtime.md) for live-interaction prompt structure

## Use this skill for

- system prompts
- developer prompts
- reusable task prompts
- tool-using prompts
- reasoning-model prompts where exploration depth, verbosity, persistence, or settings matter
- image-generation prompts once the output type and constraints are known
- realtime or voice prompts once the interaction surface is known
- prompt critique
- prompt repair after a specific failure mode

## Core rules

### 1. Match the task stage, runtime, and caller contract

Before writing or revising a prompt, decide:

- which stage the prompt is for: discovery, execution, reporting, or handoff
- where it will run
- what that runtime or surface already provides
- what context the caller will already provide
- what the output is for and who consumes it
- what answer shape the caller expects back

Then:

- include only the context that materially changes behavior in that runtime or surface
- cut incidental repo names, session artifacts, and irrelevant internal context
- do not rely on ambient context that will not really exist when the prompt runs
- if the job is discovery, ask for findings rather than a polished report unless reporting is the task

### 2. Prefer goals, constraints, and verification over micromanaged procedure

- Reasoning models usually do better with direct prompts than with long scripts for every step.
- Make the end goal explicit.
- Name the hard constraints and things to avoid.
- Add self-checks, completion bars, or verification rules when correctness matters.
- For reasoning-model prompts, steer exploration depth, tool boundaries, and stopping conditions rather than narrating every thought step.
- Use examples only when zero-shot instructions are not enough or the output pattern is unusually specific.

### 3. Generalize from example feedback

- Treat individual failures as evidence of a broader behavior gap.
- Extract the durable intent, constraint, or acceptance bar before editing the prompt.
- Do not paste in every concrete detail from the failing example unless those details are true invariants.
- Prefer a reusable rule over a case-specific patch.
- Rely on the target runtime's existing context instead of re-teaching procedures it already supplies.

### 4. Keep prompts short enough to stay legible

- A shorter prompt is often the stronger one if each line changes behavior.
- Delete scene-setting, repeated caveats, and authoring-session artifacts.
- Prefer one strong prompt over many nearby variants.
- Keep one place for each important rule instead of repeating it in softer words.
- Use headings or tags only when they make the contract easier to follow.

### 5. Repair surgically

- Preserve the lines that are already pulling their weight.
- Diagnose the actual failure mode before rewriting.
- Prefer the smallest change likely to fix the behavior.
- Write a second variant only when there is a real tradeoff.

### 6. Do not patch structural problems with prose

- If the failure is ownership, routing, missing context, tool shape, or evaluation, fix that contract first.
- If the prompt keeps absorbing architecture or workflow decisions, stop and solve that problem before editing the wording again.
- If several revisions keep missing the goal, step back and diagnose why prompt edits are not changing the outcome.

## Workflow

Keep the work anchored on the prompt artifact and the behavior it needs to produce.

### 1. Classify the task

- fresh prompt authoring
- existing prompt repair
- prompt critique
- stage-fit repair for a chosen runtime or surface
- modality-specific prompting, such as image generation or realtime interaction

### 2. Load only the reference you need

- Load [references/principles.md](references/principles.md) for stage-fit, context-fit, brevity, and structure.
- Load [references/reasoning-models.md](references/reasoning-models.md) when the prompt targets GPT-5-class or other reasoning/tool-heavy models and behavior tuning is central.
- Load [references/repair.md](references/repair.md) when repairing an existing prompt or deciding whether prompt edits should stop.
- Load [references/prompt-shapes.md](references/prompt-shapes.md) when you need a compact shape for a specific kind of prompt.
- Load a modality file only when the prompt is genuinely for that modality.

### 3. Draft or repair once, then reassess

- For repair, keep the lines that are earning their keep and change only what addresses the failure.
- For new prompts, write one strong draft by default, not a pile of variants.
- If the draft keeps growing without improving the outcome, stop and diagnose the real blocker.
