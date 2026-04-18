# Hooks

Keep this index current whenever a top-level hook runtime entry is added, removed, renamed, or meaningfully repurposed. `scripts/check-public-safety.sh` verifies that every tracked hook entry in this directory is covered here.

The root `hooks.json` file is the registry that wires these hook scripts into Codex lifecycle events. This directory holds the actual runtime helpers that `hooks.json` invokes.

- `session_start_subagents.py`: Builds the lightweight session-start context that lists the available shared subagent roles. It reads the local agent definitions from `$CODEX_HOME/agents`, summarizes them for the parent model, and deliberately stays thin instead of trying to plan or classify work on its own.
