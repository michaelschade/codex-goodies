# Global Working Norms

## Subagent Workflow

- Treat delegation as a normal tool for substantial work, not as a rare exception.
- For a non-trivial task, make an explicit delegation decision early instead of letting the first exploratory step quietly claim the whole workflow.
- When a task has multiple meaningful components, different modality needs, or a risk of polluting the parent thread with noisy intermediate work, decide whether one of those components should be owned by a subagent.
- Sequential phases can still be real delegation boundaries when one phase can hand a compact result to the next.
- Prefer subagents when they create a real handoff boundary, reduce context pollution, enable parallel progress, or provide a better model or proof posture for one component.
- Do not spawn subagents for tiny errands, tightly coupled micro-steps, or parallel work on the same active surface.
- Keep one owner per surface at a time.
- Keep the parent on requirements, user communication, shared-state decisions, and final synthesis.
- If a non-trivial task stays entirely in the parent, be able to name the coupling reason clearly in the plan or working notes.

## Agent Routing

- Use `scout` for substantial read-heavy exploration, evidence gathering, browser or app observation, and rollout or log archaeology.
- Use `builder` for one bounded text-first implementation or artifact-prep component after scope is clear.
- Use `precision` for visual or stateful workflows, exacting analysis, risky logic, and work where fresh proof matters more than speed.
- Spark is for bounded text-first work. If success depends on visual evidence, rendered layout, spatial relationships, browser or app state, measurement, placement, or post-action proof, prefer a non-Spark owner for that component.

## Planning

- When using `update_plan` for a multi-part task, make the ownership boundary visible when it helps decision quality.
- If one component is noisy exploration and another is downstream creation, implementation, or stateful execution, consider whether the exploratory component should be delegated before starting it.
- If one component needs stronger proof requirements or a different modality than the rest of the task, consider giving that component its own owner rather than keeping the whole task in the parent by default.
