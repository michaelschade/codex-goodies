# Prompt Repair

Load this file when repairing an existing prompt or when you suspect prompt edits should stop.

## 1. Diagnose before rewriting

Ask what is actually failing:

- unclear goal
- weak constraints
- weak output contract
- skipped prerequisites or verification
- too much prose
- wrong runtime or task stage
- not really a prompt problem at all

Do not rewrite the whole prompt until the failure mode is named.

## 2. Keep the working lines

- Preserve lines that are already changing behavior in the right direction.
- Remove duplicated rules and weaker restatements.
- Keep stable terminology that the caller or runtime already depends on.

## 3. Delete before you add

Many weak prompts fail because they are too long, not because they are too short.

Delete:

- scene-setting
- repeated caveats
- authoring-session context
- examples that do not pull their weight
- process narration that does not change behavior

Add only the minimum needed to fix the failure.

## 4. Common repair moves

### When the goal is vague

- rewrite the `Goal`
- add a tighter `Done when`

### When the model returns the wrong shape

- tighten the `Output`
- add one explicit completeness check

### When the model skips prerequisites

- make dependency checks explicit
- say what must be verified before acting

### When the prompt feels bloated

- collapse repeated rules
- turn long prose into a short contract
- remove sections that are not changing behavior

### When the failure is structural

- stop editing the prompt
- name the real issue: ownership, routing, missing context, tool shape, or evaluation

## 5. Repair checklist

Before returning a revised prompt, check:

- Did I keep the lines that were already working?
- Did I make the smallest change likely to fix the failure?
- Did I remove more noise than I added?
- Is the new contract clearer about success, constraints, or verification?
- If this is not really a prompt problem, did I say so plainly?

## 6. Minimal repair meta prompt

```text
Here is the current prompt:
[PROMPT]

Desired behavior:
[DESIRED]

Observed failure:
[FAILURE]

Keep as much of the existing prompt intact as possible.
1. Identify the smallest set of changes likely to fix the failure.
2. Explain why each change helps.
3. Return one revised prompt.
4. Return a second variant only if there is a real tradeoff.
5. If this is not primarily a prompt problem, say what should change instead.
```

## 7. Step-back test

Use this when repeated prompt edits are not fixing the outcome.

```text
Goal:
[GOAL]

Observed failures:
[FAILURES]

Current prompt or approach:
[PROMPT_OR_APPROACH]

Step back and diagnose the real issue.
1. Is the main problem prompt wording, missing context, invocation shape, tool or interface design, routing, ownership, or evaluation?
2. Why are repeated prompt edits not changing the outcome?
3. What is the smallest broader fix that would likely help more than another rewrite?
4. Only return a revised prompt if wording is actually the main issue.
```
