# Reasoning-Model Prompts

Load this file when a prompt targets GPT-5-class or other reasoning/tool-using models and the hard part is exploration depth, tool use, verbosity, persistence, migration, or model settings.

Modern reasoning models are already capable. Do not bury them in ceremonial "think harder" prose or a giant procedure. Give them the behavioral frame: what to optimize for, what to inspect, how far to go, when to stop, and what the caller should see.

## 1. Start With Task Shape

The same model wants different controls for different jobs.

- Execution-heavy transforms need input boundaries, schema, edge cases, and a tight output contract.
- Research-heavy work needs source boundaries, search depth, citation rules, conflict handling, and a stopping rule.
- Long-horizon agent work needs ownership, persistence, blocked-state handling, and completion accounting.
- Tool-routing work needs criteria for when tools are required, when internal knowledge is enough, and how to validate after writes.
- Long-context synthesis needs re-grounding: restate the active constraints, anchor claims to the relevant section or source, and avoid walking the whole context in order.
- Smaller or more literal models need more explicit ordering and packaging; do not over-prompt a small model into doing broad planning work that belongs on a stronger model.

## 2. Bound Exploration

GPT-5-class agents can over-gather context when the task is underspecified. Fix that with exploration criteria, not with a longer task script.

Good exploration guidance says:

- what evidence is enough to act
- what signals justify one deeper pass
- which tool calls should be parallel, sequential, or avoided
- when to proceed under stated uncertainty
- what must be checked before finalizing

Compact pattern:

```text
Gather enough context to [act / answer / edit] confidently.
Start broad once, then use focused follow-ups only for symbols, sources, or contracts you rely on.
Stop when the likely answer or edit target is clear and another search is unlikely to change the decision.
If signals conflict, run one targeted second pass, then proceed with the uncertainty labeled.
```

Use hard tool budgets only when latency or cost matters more than exhaustive recall. Otherwise prefer stop criteria; they generalize better.

## 3. Separate Verbosity Channels

"Be concise" is too blunt. A prompt should say where detail belongs.

- Keep user-facing progress updates brief.
- Let evidence, code, data, or tool outputs be detailed when reviewability depends on it.
- Put length limits on sections, not on the whole task, when completeness matters.
- For writing tasks, specify channel, register, formatting, and hard length; do not rely on personality alone.
- For final answers, prefer compact synthesis over transcript replay.

Better than "be concise":

```text
Keep status updates to 1-2 sentences.
Use detailed evidence only in the final "Evidence" section.
Do not shorten required caveats, citations, or verification results.
```

## 4. Push Follow-Through, Not Thrash

Strong agents should keep going when the path is clear and stop when the next choice would materially change the outcome.

Prompt for:

- completion criteria: what must be covered before finalizing
- blocked-state behavior: how to mark missing data instead of guessing
- recovery behavior: what to try after empty or suspiciously narrow results
- verification: the one check most likely to catch a bad answer
- permission boundaries: what actions need confirmation because they are irreversible, external, or high impact

Do not turn persistence into tool spam. Pair "keep going" with a stop rule.

## 5. Treat Settings and Evals as Control Levers

Do not solve every model-behavior problem with more prompt text.

- When migrating prompts, change one thing at a time: model first, prompt unchanged, reasoning setting pinned, eval baseline recorded, then targeted prompt changes.
- Treat reasoning effort as a last-mile knob. Before increasing it, add or tighten the output contract, completion rule, verification loop, or tool-use policy.
- If a prompt has no representative examples or eval cases, say the work is being tuned by taste.
- If a smaller model misses implied steps, either make the flow explicit or route the task to a stronger model.
- If the runtime drops state, citations, tool results, or phase boundaries, fix the integration rather than teaching around it in prose.

## 6. High-Leverage Repairs

Start by deleting old crutches that make strong models worse:

- "Maximize thoroughness" when the real need is bounded exploration.
- "Think step by step" when the caller needs only the final answer or a visible plan.
- "Be comprehensive" when the success bar is a narrow decision, edit, or extraction.
- "Ask clarifying questions" as a default when the model can proceed safely with labeled assumptions.
- "Use tools for everything" when freshness, user-specific state, or exact evidence is not required.

Then patch the observed behavior:

- Too much searching: add evidence sufficiency, early-stop criteria, and one allowed escalation pass.
- Too little follow-through: add a completion contract and blocked-state reporting.
- Verbose updates: separate brief user updates from detailed final evidence or tool artifacts.
- Terse final answer: specify which sections must include evidence, risks, caveats, or examples.
- Tool churn: say when tools are required, when internal knowledge is acceptable, and what to do after a write.
- Scope drift: say exactly what surface is in bounds, what expansions are forbidden, and where creative freedom is allowed.
- Long-context misses: ask the model to identify the relevant sections first, restate active constraints, and anchor claims to source locations.
- Hallucinated specifics: require retrieved or provided evidence for IDs, URLs, dates, prices, claims, and citations.
- Migration regression: restore the old prompt, pin settings, run baseline evals, then make the smallest targeted change.
- Literal small-model behavior: put critical rules first, define step order, and use closed outputs; if the job is broad, route it away from the small model.
