# Prompt Shapes

Load this file when a prompt needs a compact shape.

These are not forms to fill out. They are ways to keep the prompt legible after you already know the intent. Delete any heading that does not change behavior.

## Minimal contract

Use when the prompt mostly needs a crisp target and completion bar.

```text
Goal:

Context:

Constraints:

Done when:

Output:
```

## Tool-using agent

Use when the model must decide when to gather context, call tools, and stop.

```text
Goal:

Relevant context:

Tool policy:

Exploration boundary:

Constraints:

Completion bar:

Verification:

Output:
```

Good tool prompts usually need fewer steps and stronger boundaries. Name when tools are required, when they are not, what evidence is enough, what must not be touched, and what counts as complete.

## Reasoning-model behavior patch

Use when the prompt mostly works, but a reasoning model is too eager, too terse, too verbose, or not persistent enough.

```text
Observed failure:

Keep unchanged:

Behavior change:

Boundary or stop rule:

Verification:
```

Patch the behavior directly. Do not rewrite a full prompt just to add one exploration, verbosity, or completion rule.

## Example-feedback generalization

Use when the prompt failed on one example but is meant for broader use.

```text
Observed example failure:

Durable failure mode:

True invariants:

Incidental details to avoid copying:

Generalized rule:

Acceptance check:
```

Keep this shape short. The point is to extract the reusable rule, not archive the whole failing case.

## Discovery prompt

Use when the next stage needs findings, not a polished report.

```text
Goal:

Fast path:

Sources or inputs:

Stop when:

Return:
```

Keep discovery prompts light. They should point the model toward the right evidence and leave presentation decisions to the later writing stage.

## Edit or transform prompt

Use when revising an existing artifact, prompt, image, or asset.

```text
Starting point:

Change:

Keep unchanged:

Quality bar:

Output:
```

For edits, "keep unchanged" is often more important than a long description of the change.
