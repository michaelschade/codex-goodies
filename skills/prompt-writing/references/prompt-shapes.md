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

Tool rules:

Constraints:

Verification:

Output:
```

Good tool prompts usually need fewer steps and stronger boundaries. Name what must be checked, what must not be touched, and what counts as complete.

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
