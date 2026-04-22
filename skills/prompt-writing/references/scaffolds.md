# Prompt Scaffolds

Load this file when you need a short starting shape for a new prompt.

Delete unused headings. These are scaffolds, not required templates.

## 1. Minimal contract

Use for straightforward prompts where the main need is a clear contract.

```text
Goal:

Context:

Constraints:

Done when:

Output:
```

## 2. Tool-using agent

Use when the prompt needs tool rules, follow-through, and verification.

```text
Role:

Goal:

Context:

Tools:
- Use when:
- Avoid when:

Working rules:
- Gather only the context needed to act safely.
- Check prerequisites before later actions.
- Verify the key postconditions before finishing.

Done when:

Output:
```

## 3. Discovery prompt

Use for research, tracing, or evidence gathering.

```text
Goal:

Search focus:

Relevant sources or inputs:

Stop when:

Return:
```

For discovery prompts, keep output scaffolding minimal. Ask for the findings needed by the next stage, not a polished report unless reporting is the task.

## 4. Edit or transform prompt

Use when revising an existing artifact, prompt, or asset.

```text
Starting point:

Change:

Keep unchanged:

Constraints:

Done when:

Output:
```
