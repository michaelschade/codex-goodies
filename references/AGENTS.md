# Global Working Norms

## Subagent Workflow

- Treat delegation as a normal tool for substantial work, not as a rare exception.
- For a non-trivial task, before the first substantial search/read/tool call, either delegate one or more bounded components or explicitly state why the work must stay parent-owned instead of letting the first exploratory step quietly claim the whole workflow.
- When a task has multiple meaningful components, different modality needs, or a risk of polluting the parent thread with noisy intermediate work, decide whether one of those components should be owned by a subagent.
- Sequential phases can still be real delegation boundaries when one phase can hand a compact result to the next.
- Prefer subagents when they create a real handoff boundary, reduce context pollution, enable parallel progress, or provide a better model or proof posture for one component.
- Do not spawn subagents for tiny errands, tightly coupled micro-steps, or parallel work on the same active surface.
- Keep one owner per surface at a time. This is a boundary rule, not a reason to keep an entire multi-phase task in the parent when different surfaces can be split cleanly.
- Keep the parent on requirements, user communication, shared-state decisions, and final synthesis.
- If a non-trivial task stays entirely in the parent, be able to name the coupling reason clearly in the plan or working notes.

## Agent Routing

- Use `scout` for substantial read-heavy exploration, evidence gathering, browser or app observation, and rollout or log archaeology.
- Use `builder` for one bounded text-first implementation or artifact-prep component after scope is clear.
- Use `precision` for visual or stateful workflows, exacting analysis, risky logic, and work where fresh proof matters more than speed.
- Spark is for bounded text-first work. If success depends on visual evidence, rendered layout, spatial relationships, browser or app state, measurement, placement, or post-action proof, prefer a non-Spark owner for that component.

## Planning

- When using `update_plan` for a multi-part task, make the ownership boundary visible when it helps decision quality.
- When planning a non-trivial task, identify discrete components whose owner can proceed from the assigned task, key constraints, and expected output without needing the whole parent thread. Those components are strong subagent candidates.
- Do not satisfy the delegation decision with a provisional deferral like "keep it in the parent for now" or "decide after I confirm the tooling/context." If a plausible delegated component already exists, either delegate it before the next substantial search/read/tool call or name the concrete blocker that makes delegation impossible right now.
- If routing is already clear, invoke subagents explicitly and use the agent name directly instead of hinting vaguely that delegation might help later.
- If a higher-priority runtime or tool rule restricts `spawn_agent` to cases with explicit user permission, treat that as a hard blocker that local delegation guidance cannot override, and say so plainly instead of recasting the miss as a task-structure decision.
- When using `spawn_agent` with `fork_context`, omit `agent_type`, `model`, and `reasoning_effort`; forked agents inherit those settings from the parent.
- If one surface is stateful and another component is separable read-only research, evidence gathering, or artifact prep, keep one owner on the stateful surface but still consider delegating the separable sidecar before the parent claims the whole workflow.
- If one component is noisy exploration and another is downstream creation, implementation, or stateful execution, consider whether the exploratory component should be delegated before starting it.
- If one component needs stronger proof requirements or a different modality than the rest of the task, consider giving that component its own owner rather than keeping the whole task in the parent by default.

## Commit Hygiene

- Write thorough commit messages by default, not just a terse one-line subject.
- Start with a concise subject that names the main outcome, then add a body for non-trivial changes.
- The body should explain what changed, why it changed, and any important behavior, risk, migration, or reviewer context that is not obvious from the diff alone.
- When validation or verification was run, note it in the commit message body. If a relevant check could not run, say that explicitly instead of implying it passed.
- Keep one idea per commit when practical so the message and the diff stay
  aligned.

## Writing and Explanatory Copy

- For README positioning, skill overviews, and other short explanatory surfaces, prefer a short plainspoken lead-in plus concrete, scannable bullets; avoid generic "Why You Might Care" framing and long scene-setting.
- Keep examples rooted in real workflows and readable to a cold reader. Avoid hidden rollout context, one-off anecdotes that do not travel, or framing that makes Codex sound broken and in need of rescue.
- Emphasize leverage and outcomes over feature inventory: show what the workflow, skill, or tool makes easier to do.
- Re-synthesize instead of append. Keep top-level docs lean, concrete, and product-shaped instead of accreting changelog-style detail or dense blocks.
- For summaries and status writeups, report concrete outcomes, counts, paths, and warnings or failures instead of vague success language.
