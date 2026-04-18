# Codex Local State

Load this file when the task is about improving Codex using local evidence from `~/.codex`: sessions, archived rollouts, memories, logs, automations, shell snapshots, or SQLite state.

This reference is intentionally privacy-first. It is about what can be learned structurally, how to inspect it safely, and when to escalate from metadata to content.

## 1. Privacy rules first

Treat local Codex state as high-sensitivity by default. It may contain:

- raw user prompts
- system and developer instructions
- local file paths and working directories
- internal tools or connectors
- auth or enrollment material
- unreleased product details or alpha-surface behavior

Default behavior:

- inspect metadata, schemas, counts, keys, timestamps, thread IDs, and file names first
- prefer derived summaries over raw transcripts
- prefer table schemas and row counts over row bodies
- prefer event types and key shapes over message content
- abstract lessons into workflow or design guidance instead of copying text

Approval gate for public-bound documentation:

- local `~/.codex` inspection may inform private analysis, but it must not introduce new public-bound skill concepts, features, or reusable guidance without explicit user approval
- if local evidence suggests a novel concept, product behavior, or best practice, treat it as a private finding until the user explicitly approves documenting it
- the safe default is: analyze privately, summarize structurally, ask before promoting

Do not echo or embed into reusable skills:

- message bodies
- prompt text
- `base_instructions`
- `user_instructions`
- `developer_instructions`
- `first_user_message`
- `raw_memory`
- rollout transcript excerpts unless the user explicitly wants them
- auth or enrollment secrets

## 2. Recommended order of inspection

When the task is “learn from prior Codex work,” use this order unless there is a strong reason not to.

### 1. Current local setup

Start with the files that define current behavior:

- `~/.codex/config.toml`
- `~/.codex/hooks.json`
- `~/.codex/agents/*.toml`
- relevant skills under `~/.codex/skills/`
- automations under `~/.codex/automations/`

This tells you what behavior is current before you go spelunking through history.

### 2. Derived memory artifacts

Use these first when the question is “what happened before?” or “what lessons have already been extracted?”

- `~/.codex/memories/memory_summary.md`
- `~/.codex/memories/MEMORY.md`
- `~/.codex/memories/rollout_summaries/`
- `~/.codex/memories/skills/`

These are higher-signal and lower-noise than raw session files.

### 3. Lightweight thread and session indexes

Use these to locate candidate threads without reading transcripts:

- `~/.codex/session_index.jsonl`
- `~/.codex/state_5.sqlite` `threads` metadata
- `~/.codex/archived_sessions/`
- `~/.codex/sessions/YYYY/MM/DD/`

Good uses:

- find relevant thread IDs
- map activity by date
- see which cwd, model, sandbox, or approval posture a thread used
- locate the raw rollout path for targeted follow-up

### 4. Targeted raw rollout inspection

Only after narrowing the scope should you read a raw session JSONL.

Use raw rollout files to answer questions like:

- what event types occurred?
- what tool or model surfaces were active?
- what was the timing or turn structure?
- where did the workflow branch, compact, or fail?

Start with:

- top-level event types
- key shapes for `session_meta`, `turn_context`, `event_msg`, and `response_item`
- targeted search by `thread_id`, `turn_id`, tool name, or event type

Avoid bulk-loading entire large rollout files unless there is no narrower path.

### 5. Logs and DB-backed runtime state

Use structured logs and SQLite state when the task is about system behavior, automation plumbing, thread metadata, or failure patterns rather than prompt content.

## 3. What is in `~/.codex`

The exact contents will evolve, but the current structure already suggests a useful mental model.

### Live behavior and policy

- `config.toml`: baseline config and feature posture
- `AGENTS.md`: global instruction layering
- `hooks.json` and `hooks/`: lifecycle interception
- `agents/*.toml`: custom agent definitions
- `rules/`: command policy
- `skills/`: local and system skills

### Session and rollout history

- `sessions/YYYY/MM/DD/rollout-*.jsonl`: raw session event streams organized by date
- `archived_sessions/rollout-*.jsonl`: archived raw rollout streams
- `session_index.jsonl`: lightweight thread index
- `shell_snapshots/*.sh`: shell-state captures tied to thread IDs and timestamps

### Derived memory and summarization

- `memories/MEMORY.md`
- `memories/memory_summary.md`
- `memories/raw_memories.md`
- `memories/rollout_summaries/`
- `state_5.sqlite` `stage1_outputs`

### Runtime state and observability

- `logs_2.sqlite`: structured runtime logs
- `state_5.sqlite`: thread registry, derived memory state, dynamic tools, spawn edges, and agent-job state
- `sqlite/codex-dev.db`: automations, runs, and inbox items
- `log/codex-tui.log`: text log surface

### Cached or generated artifacts

- `generated_images/`: generated image outputs tied to thread IDs
- `cache/`, `plugins/`, `.tmp/`, `vendor_imports/`: marketplace, plugin, and runtime cache state
- `models_cache.json`, `version.json`, `.codex-global-state.json`: environment and cache metadata

### High-sensitivity files

Treat these as need-to-know only:

- `auth.json`
- remote-control enrollment state
- anything containing raw prompt or instruction bodies
- any file whose purpose is auth, enrollment, or account linkage

## 4. Safe ways to inspect each surface

### `session_index.jsonl`

Use for:

- quick thread discovery
- identifying candidate thread IDs
- finding thread names and recency

Safe first pass:

- inspect only top-level keys
- sort or filter by `updated_at`
- avoid reading related raw rollout content until you have narrowed the target set

### Raw rollout JSONL

Use for:

- event structure
- turn boundaries
- workflow shape
- targeted debugging of one thread

Safe first pass:

- inspect unique `.type` values
- inspect payload key shapes for each event type
- search by `thread_id`, `turn_id`, or narrow event types
- only read message content if metadata is insufficient

Current useful event classes observed locally include:

- `session_meta`
- `turn_context`
- `event_msg`
- `response_item`

Useful payload classes observed locally include metadata such as:

- session identifiers and timestamps
- cwd, model, sandbox, approval, collaboration, and effort context
- response item roles and content containers

That is enough to do a lot of structural analysis before reading actual text.

### `logs_2.sqlite`

Use for:

- runtime error patterns
- component or target-level debugging
- per-thread log correlation
- rough volume and timing analysis

Current schema indicates fields such as:

- timestamps
- log level
- target
- module path
- file and line
- thread ID
- process UUID
- estimated bytes
- `feedback_log_body`

Safe first pass:

- inspect schema
- count rows
- group by `level`, `target`, or `thread_id`
- avoid pulling `feedback_log_body` unless the task specifically requires deeper debugging

### `state_5.sqlite`

Use for:

- thread metadata without opening raw rollouts
- rollout-path lookup
- archived state
- spawn relationships
- dynamic-tool registration
- derived memory state

Current high-value tables include:

- `threads`
- `stage1_outputs`
- `thread_spawn_edges`
- `thread_dynamic_tools`
- `agent_jobs`
- `agent_job_items`

What they are good for:

- `threads`: metadata lookup for thread ID, cwd, model, sandbox, approval, branch, title, rollout path
- `stage1_outputs`: evidence that a memory pipeline or rollout-summary layer exists for a thread
- `thread_spawn_edges`: parent or child relationships for delegated threads
- `thread_dynamic_tools`: whether custom dynamic tools were attached
- `agent_jobs` and `agent_job_items`: batch or job-like workflows if present

Safe first pass:

- inspect table schema
- count rows
- query non-content metadata only
- do not dump `raw_memory` or `rollout_summary` bodies into reusable guidance

### `sqlite/codex-dev.db`

Use for:

- automation inventory
- automation lifecycle state
- inbox-style follow-up surfaces

Current high-value tables include:

- `automations`
- `automation_runs`
- `inbox_items`

Safe first pass:

- inspect schema
- count rows
- look at names, IDs, status fields, timestamps, and run state before reading full prompt text

### `shell_snapshots/*.sh`

Use for:

- reconstructing shell context around a thread
- understanding environment or cwd drift
- debugging shell-based reproducibility problems

These can contain sensitive environment details. Inspect minimally and only when shell state is the real issue.

## 5. Practical questions and the best source to answer them

### “Which prior threads are even relevant?”

Start with:

- `memories/MEMORY.md`
- `memories/rollout_summaries/`
- `session_index.jsonl`

### “What changed in Codex behavior or setup between runs?”

Start with:

- current `config.toml`, hooks, agents, skills
- `threads` metadata in `state_5.sqlite`
- targeted `turn_context` key inspection in raw rollout JSONL

### “Was this a workflow mistake, a prompt issue, or an environment issue?”

Start with:

- rollout summaries
- `threads` metadata
- `logs_2.sqlite` grouped by thread or target
- only then raw rollouts if the summary layer is insufficient

### “Which automations exist, what did they touch, and are they noisy?”

Start with:

- `sqlite/codex-dev.db`
- `~/.codex/automations/`

### “Did delegation or parallel agents help here?”

Start with:

- `thread_spawn_edges`
- relevant rollout summaries
- targeted raw rollout event inspection for parent and child threads

## 6. Techniques to elevate Codex-meta work

- Prefer structural evidence over anecdote. Look for repeated patterns across summaries, metadata, or logs before changing guidance.
- Use rollout summaries as the first compression layer and raw rollouts as the appeal path.
- Use thread metadata to compare runs without loading transcript text.
- When studying failures, separate environment facts from prompt or workflow facts.
- Treat shell snapshots, auth state, and enrollment state as sensitive and inspect only when they are the blocker.
- Convert recurring findings into durable skill guidance only after abstracting away user-specific content.
- If a local artifact contains private or alpha-product details, extract the lesson as a generic pattern and leave the content behind.

## 7. What not to bake into the skill

Do not encode:

- specific private prompts or rollout excerpts
- unreleased feature details from local usage
- account-specific auth or enrollment behavior
- one-off thread titles, repo names, or local identifiers unless they are already part of a reusable public workflow

Encode instead:

- where to look first
- how to inspect safely
- how to distinguish metadata from sensitive content
- how to turn local evidence into abstract workflow improvements

Only do that last step for public-bound skill content after explicit user approval when the improvement is derived from local `~/.codex` inspection rather than public sources.
