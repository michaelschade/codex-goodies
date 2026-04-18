# Prompt Writing

Use this when the wording itself matters, or when you need help proving the next fix should not be another prompt edit.

- **Make the instruction carry the work.** In the hook repair pass, prompt-writing did not redesign the system. It removed the `"In this projectless Codex workspace"` lead-in and rewrote the injected text so only the behavior-changing parts remained: delegation is allowed, what kind of task qualifies, and who keeps ownership.
- **Stop death by a thousand prompt edits.** When a system keeps missing the point, this skill helps you step back, cut the noise, and decide whether the next fix belongs in the prompt or somewhere else.
- **Turn a dense brief into an execution contract.** In recent codex-meta work, that meant splitting a one-block refresh prompt into sections for goal, cheap change detection, source priority, bounded subagent use, and done-when.
- **Write for the runtime, not the authoring chat.** Use it when the same task might run in a skill, automation, or `codex exec` job and you need the prompt to work there instead of quietly depending on chat-only context.
- **Keep the strong parts and delete the rest.** The point is not to rewrite everything. It is to preserve the lines that are already pulling their weight and remove everything that is just scene-setting or repeated caveats.

If you want the operational rules, checklists, and scaffolds, jump to [`SKILL.md`](SKILL.md).
