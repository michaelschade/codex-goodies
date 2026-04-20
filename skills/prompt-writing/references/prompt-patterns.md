# Prompt Patterns

Load this file when the task needs a concrete scaffold, repair recipe, or authoring checklist.

## 1. Durable prompt ingredients

For most strong agentic prompts, include only the pieces that actually matter:

```text
Role:
Goal:
Context:
Constraints and invariants:
Tools:
- Use when:
- Avoid when:
Workflow:
Done when:
Output:
```

Do not force every section into every prompt. Use the smallest structure that removes ambiguity.

## 1.25 Structuring patterns

Use structure as a steering tool, not as decoration.

### Markdown structure

Good for most prompts:

```markdown
## Goal
## Context
## Constraints
## Workflow
## Done When
## Output
```

### Tagged blocks

Useful when a prompt is longer, more agentic, or needs precise named sections:

```text
<context_gathering>
...
</context_gathering>

<tool_rules>
...
</tool_rules>

<done_when>
...
</done_when>
```

### How to choose

- Use Markdown when simple headings are enough.
- Use tagged blocks when you want explicit named regions that can be referenced or tuned independently.
- Do not use tags just because they look advanced; use them when they make the prompt easier to follow.
- Keep one prompt internally consistent instead of mixing too many structural styles.

## 1.5 Execution-context and surface check

Before writing the prompt, answer this:

- Is this prompt meant for Codex specifically?
- Is it meant for some other known harness?
- Or should it run well in isolation?
- If it is Codex-specific, which surface will carry it: a direct prompt, hook text, skill guidance, subagent brief, or automation prompt?
- What does that surface already provide, and what would be duplicated if repeated here?
- What context will the caller provide versus what must the prompt say explicitly?
- What answer shape does the caller need back?

If it should run in isolation or travel across environments:

- include the necessary task and environment context explicitly
- avoid references to ambient conversation state
- avoid Codex-only tool names, file assumptions, approvals, memory behavior, or phase mechanics unless the target runtime truly has them

If it is Codex-specific:

- it can name Codex surfaces and tool behavior
- but only include the harness details that materially change behavior
- do not drag surface-choice debates into the prompt when the real problem is architectural
- if the hard part is choosing between hooks, skills, subagents, or automation, use `$codex-meta`

## 2. Prompt surgery checklist

Use when repairing an existing prompt.

- Preserve lines that are already pulling their weight.
- Identify the actual failure mode before rewriting.
- Remove ambiguity, contradictions, duplicate rules, and fake precision.
- Tighten tool rules and stopping criteria.
- Add output-shape instructions only if the consumer cares.
- Prefer a small number of strong edits over a full rewrite.
- If the prompt keeps growing while the core issue stays the same, recommend a workflow fix instead.

## 3. Fresh harness-aware prompt scaffold

Use when writing a new non-trivial prompt after the execution surface is already chosen.

```text
Role:
You are responsible for [job].

Goal:
[the task to complete]

Context:
[only the context that changes behavior]

Constraints:
- Preserve:
- Avoid:
- Ask only if:

Tools:
- Use [tool] for [cases].
- Do not use [tool] for [cases].

Workflow:
- Gather only the context needed to act safely.
- Keep going until the task is actually complete.
- Verify the key postconditions before finishing.

Done when:
- [clear completion bar]

Output:
- [desired answer or artifact shape]
```

## 3.5 Portable prompt patterns

Use when the prompt should run well outside the current Codex harness.

This is not one fixed template. The point is to ensure the prompt covers the right ground for the target runtime.

Common ingredients to cover when needed:

- goal
- necessary context
- constraints and invariants
- decision rules
- completion criteria
- output contract

One lightweight shape:

```text
Goal:
Necessary context:
Constraints:
Done when:
Output:
```

Another shape for more agentic tasks:

```text
Role:
Goal:
Necessary context:
Decision rules:
Workflow:
Output:
```

Keep the prompt free of local file references, tool names, and harness assumptions unless they are part of the actual runtime.

## 4. Context-gathering control patterns

Use these when the prompt needs to shape exploration depth.

### More action, less search

```text
Context gathering:
- Search only for the symbols, files, or docs that are directly needed.
- Prefer acting once the main unknowns are resolved.
- Search again only if validation fails or a new blocker appears.
```

### More caution, more research

```text
Context gathering:
- Inspect the live setup before proposing changes.
- Trace only the contracts you will modify or rely on.
- If a high-risk ambiguity remains, surface it before committing.
```

## 4.5 Context hygiene checklist

Include:

- facts that change the output
- constraints that change decisions
- environment facts the model can safely rely on
- caller-interface facts that explain how the prompt will be invoked or consumed

Cut:

- implementation trivia from the authoring session
- incidental repo names, internal labels, or identifiers that are not meaningful to the task
- irrelevant background
- harness details that will not exist where the prompt runs
- duplicated instructions that restate the same rule in weaker words

## 4.75 Structure hygiene checklist

Prefer:

- one place for each important rule
- section labels that reflect real behavioral categories
- clear separation between context, constraints, workflow, and output

Avoid:

- wall-of-text prompts
- repeated instructions scattered across sections
- headings that sound nice but do not change behavior

## 5. Workflow recommendation scaffold

Use when the user is really designing Codex itself rather than just asking for a prompt.

If the hard part is deciding what should live in prompts versus skills, hooks, config, subagents, or automation, also use `$codex-meta`.

```text
Recommended shape:
Smallest safe change surface:
Why this fits the current local setup:
What should live in prompts vs skills vs agents vs automation:
Current-doc caveats:
```

## 5.25 Surface-boundary check

Use this when the prompt keeps absorbing Codex-system design decisions.

- If the hard part is choosing where behavior belongs across hooks, skills, subagents, config, or automation, stop editing the prompt and use `$codex-meta`.
- Once the surface is chosen, come back here to draft or repair the wording.

## 6. Prompt-repair meta prompt

Use this when the user wants GPT-5 to repair a prompt with minimal edits.

```text
Here is the current prompt:
[PROMPT]

Desired behavior:
[DESIRED]

Observed failure:
[FAILURE]

While keeping as much of the existing prompt intact as possible:
1. Identify the smallest set of changes that would likely fix the failure.
2. Explain why each change helps.
3. Return one revised prompt.
4. Return a second variant only if there is a real tradeoff.
5. If the failure is not primarily a prompt problem, say what should change instead.
```

## 6.5 Step-back meta prompt

Use this when repeated prompt tweaks are not fixing the outcome.

```text
We have tried multiple prompt refinements and the result is still not meeting the goal.

Goal:
[GOAL]

Observed failures:
[FAILURES]

Current prompt or approach:
[PROMPT_OR_APPROACH]

Step back and rethink the problem.
1. Identify whether the real issue is prompt wording, missing context, invocation shape, tool/interface design, or evaluation criteria.
2. Explain why repeated prompt tweaks are or are not the right path.
3. Call out any brittle deterministic logic, such as heuristic hook scripts or prompt classifiers, that should be removed rather than refined.
4. Recommend the smallest broader change that would most likely fix the outcome.
5. Only provide a revised prompt if prompt wording is actually the main issue.
```

## 7. Specialized family notes

### Realtime

Use a different prompt shape from ordinary text-agent prompting.

- define voice or interaction style explicitly
- define interruption and turn-taking behavior
- define tool-call behavior and when to confirm actions aloud
- define recovery behavior for mishearing, uncertainty, or failed tools
- keep instructions easy to follow under latency pressure

### Image generation

Use image-specific prompting instead of generic text-agent prompting.

- specify subject, scene, composition, style, and constraints concretely
- quote exact text that must appear in-image
- for edits, restate what must stay unchanged
- use `$imagegen` for the detailed asset schema and execution rules
