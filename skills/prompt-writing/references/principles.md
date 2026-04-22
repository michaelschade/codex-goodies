# Prompt Principles

Load this file when you need the core authoring rules for a prompt.

## 1. Start with intent, stage, and contract

Before writing, answer these:

- What is the prompt trying to make easier, safer, or more reliable?
- Is this prompt for discovery, execution, reporting, or handoff?
- Where will it run?
- What context does that runtime already provide?
- What output is needed, and who consumes it next?
- What counts as done?

If the prompt is for discovery:

- ask for the findings needed by the next stage
- do not ask for a polished report unless reporting is the task

## 2. Generalize from examples and feedback

When feedback comes from one example, do not automatically add that example's details to the prompt.

Instead identify:

- the durable failure mode
- the broader intent the prompt should preserve
- the acceptance bar that would have caught the miss
- which example details are true invariants versus incidental evidence
- what the runtime already knows and does not need repeated

Good revisions usually say less than the failing example contained. They point to the kind of judgment needed next time.

Example:

- Weak: "Always include the red button, the blue sidebar, the exact toolbar labels, and the modal title."
- Strong: "Use a few source-grounded UI moments to convey the product, but do not turn the prompt into an exhaustive feature inventory."

## 3. Prefer goals over micromanaged procedure

- Reasoning models usually work best with straightforward prompts and clear end goals.
- Many strong prompts are short. Extra prose is a cost, not a sign of rigor.
- Say what must happen, what must not happen, and how the result should be checked.
- Do not narrate every obvious thinking step just because the task is important.
- If there are real constraints, say them directly.
- If the model is already capable, tune exploration, output shape, and stopping conditions before adding more step-by-step process.

Examples of high-leverage instructions:

- "Return the smallest fix that addresses the failure."
- "Keep going until the key postconditions are verified."
- "If the evidence is insufficient, say so instead of guessing."

## 4. Keep only behavior-changing context

Include:

- facts that change the output
- constraints that change decisions
- caller-contract details that explain how the prompt will be used
- environment facts the model can safely rely on

Cut:

- authoring-session trivia
- incidental repo names and internal labels
- repeated caveats
- background that does not affect the result
- harness assumptions that will not exist where the prompt runs

## 5. Use structure deliberately

- Markdown headings are enough for most prompts.
- Tags are useful when you need explicit boundaries, reusable sections, or blocks that other rules refer to.
- Not every prompt needs every section.
- Keep one place for each important rule.
- Pick structure after you know the intent; do not let the template decide what matters.

Sections that often earn their keep:

- `Goal`
- `Context`
- `Constraints`
- `Tools`
- `Done when`
- `Output`

Context often belongs near the end when it varies per request and the stable instructions belong earlier.

## 6. Choose the right control lever

Before adding prose, decide which lever actually changes the behavior:

- prompt text for goals, constraints, output shape, examples, and verification
- model settings for latency, reasoning depth, verbosity, and cost tradeoffs
- runtime or tool design for missing context, unavailable state, awkward routing, or unsafe side effects
- evals or examples when repeated edits are being judged by taste instead of evidence

If the fix is really a setting, integration, tool contract, or eval gap, do not hide that inside a longer prompt.

## 7. Make the contract explicit

When correctness matters, make these concrete:

- what the model should optimize for
- what it must avoid
- what tools it should or should not use
- what "complete" means
- what to verify before finishing
- what shape the output should take

Useful contract patterns:

- completeness checks
- follow-through rules
- prerequisite checks before later actions
- output rules that are tight enough to consume downstream

## 8. Use examples as leverage, not filler

- Try zero-shot instructions first.
- Add examples only when the output pattern is hard to infer or zero-shot has failed.
- Keep examples representative and close to the actual task.
- If examples and instructions disagree, the prompt gets weaker, not stronger.
- Use examples to reveal taste, judgment, format, or failure boundaries; do not add them just to make the prompt feel thorough.
- When examples are only diagnostic evidence, synthesize the underlying rule and leave the example out.
