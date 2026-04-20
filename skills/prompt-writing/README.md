# Prompt Writing

Use this when the wording itself matters, or when you need help proving the next fix should not be another prompt edit.

- **Write for the invocation context.** The same job reads differently in a chat, a skill, an automation, or a `codex exec` run. This skill helps strip chat-only assumptions and keep only the runtime context that actually changes behavior.
- **Turn a dense brief into an execution contract.** In recent codex-meta work, that meant splitting a one-block refresh brief into sections for goal, cheap change detection, source priority, bounded delegation, and done-when.
- **Make the instruction carry the work.** The strongest edits usually delete scene-setting and repeated caveats so the remaining lines actually change behavior.
- **Know when prompt surgery should stop.** If the hard part is deciding whether something belongs in a hook, skill, subagent, automation, or config, pair it with [`$codex-meta`](../codex-meta/README.md) instead of cramming architecture decisions into the prompt.
- **Stop death by a thousand prompt edits.** When a system keeps missing the point, this skill helps you step back, cut the noise, and decide whether the next fix belongs in the prompt or somewhere else.
- **Keep the strong parts and delete the rest.** The point is not to rewrite everything. It is to preserve the lines that are already pulling their weight and remove everything that is just scene-setting or repeated caveats.

If you want the operational rules, checklists, and scaffolds, jump to [`SKILL.md`](SKILL.md).
