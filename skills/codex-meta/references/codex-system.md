# Codex System

Load this file when the task is about Codex itself: which layer should own behavior, which runtime is the right fit, which configuration knobs matter, or where to go in the docs for deeper detail.

This reference assumes basic familiarity with Codex. It focuses on the concepts and surfaces that actually change system design.

## 1. Concepts that change design choices

If advice feels shallow, it is usually because it is operating at the wrong layer. The important Codex concepts are the ones that change where behavior should live, what context is reliable, and how a workflow should be executed.

### Customization

This is one of the most important pages in the docs because it defines the layering model directly: customization is how you make Codex work the way your team works.

The key lesson is that the main customization layers are complementary, not competing:

- `AGENTS.md` for persistent project guidance
- memories for useful context learned from prior work
- skills for reusable workflows and domain expertise
- MCP for access to external tools and shared systems
- subagents for delegating work to specialized agents

Most Codex quality issues are not solved by picking one favorite mechanism and forcing everything into it. They are solved by putting each kind of behavior into the right layer.

### Memories

Memories matter because they change what can be treated as already-known context across threads.

Where memories shine:

- stable personal preferences
- recurring workflows
- known project pitfalls
- tech-stack context that is annoying to restate every time

Important boundaries:

- memories are a local recall layer, not the source of truth for must-follow team rules
- required guidance still belongs in `AGENTS.md` or checked-in docs
- memories are off by default
- they should be treated as reviewable local artifacts, especially before sharing a Codex home directory

Use memories when the problem is repeated local context. Do not use them as a substitute for durable repository policy or checked-in team guidance.

### Sandboxing and approvals

This is the trust boundary: sandboxing controls what Codex can do technically, and approvals control when it must stop and ask.

Where this concept matters:

- choosing how autonomous Codex should be
- deciding whether a workflow should run locally, in a worktree, or in the cloud
- reducing approval fatigue without removing all guardrails

Do not confuse this with behavior design. Sandboxing and approvals define autonomy and reach, not judgment quality or task decomposition.

### Workflows

This is the main “surface fit” concept. It is less about isolated tips and more about how Codex work should be shaped end to end.

What the docs emphasize:

- choose the right surface for the job
- know what Codex automatically sees versus what you need to attach
- include verification, not just implementation
- prefer concrete, end-to-end usage patterns over abstract advice

This is one of the highest-leverage docs when a user says “Codex is not using the right context” or “this works badly in one surface but not another.” The issue is often workflow fit, not just wording.

### Models

Models are a first-class Codex concept because they change what level of reasoning, speed, and modality support a design can rely on.

Use the models docs when the question is really about:

- the right mainline model family
- reasoning-level defaults
- surface-specific model availability
- distinct model families such as realtime or image generation

Do not let model choice become cargo-cult guidance. Pick models to match the job, then verify that the surrounding surface and workflow also fit.

### Cyber Safety

Cyber Safety is a separate concept from local sandboxing and from Codex Security.

The docs describe this as cybersecurity safeguards and trusted access for Codex users. The key lesson is that cyber capability is treated as dual-use, so the system may apply additional safeguards or reroute suspicious high-risk traffic.

Use this concept when a workflow touches offensive security, malware, credential theft patterns, or other dual-use cyber work. Do not mistake it for a local config knob you can "turn off" inside the skill.

## 2. System surfaces

### Interactive surfaces are different context contracts, not the main abstraction

The app, IDE extension, CLI, and cloud are useful, but they are not four unrelated systems. They are different entry points into Codex with different context contracts.

The distinctions that matter:

- CLI is the most explicit local runtime: cwd, files, shell environment, and command execution are front and center.
- Cloud and integrations are background delegation surfaces: named environments, connected repos, and async event-driven work matter more.
- App and IDE are richer clients over the same broader system: they expose review, worktrees, thread management, open-file context, and approvals in a friendlier UI.

Do not spend much design energy on the UI surface itself unless the request is specifically about the client experience. Spend it on the workflow contract and the layer that should own behavior.

### Integrations and cloud

Integrations matter because they move Codex to where work already happens.

Where they shine:

- GitHub review and repo-event workflows
- Slack-driven async handoffs
- Linear or other tracker-driven work intake
- cloud tasks that should run without occupying a local session

The important system lesson is that integrations change task ingress and review loops, not just convenience. A Slack thread, GitHub PR, or cloud environment often becomes part of the task contract.

### Programmatic and infrastructure surfaces

When the question is no longer “which prompt should I use?” but “how should Codex fit into a larger system?”, you have moved into a different class of surface:

- `codex exec` for scriptable one-shot or resumable automation
- the SDK for programmatic thread control from applications or services
- App Server for building a rich custom client with approvals, history, and streamed events
- GitHub Action for GitHub-native event automation

Load [codex-programmatic.md](codex-programmatic.md) when these are the hard part. That file is where the deeper guidance lives.

### Codex Security

Codex Security is a separate product surface for finding, validating, and remediating likely vulnerabilities in connected GitHub repositories. It is not the same thing as:

- sandboxing
- approval policy
- cyber safety controls
- local command restrictions

Use these docs when the task is specifically about security scanning, findings validation, and remediation workflows in connected repositories.

## 3. Customization and extensibility surfaces

This is where most high-leverage Codex improvements live.

### `AGENTS.md` and instruction layering

The docs frame this as custom instructions with `AGENTS.md`, and the best-practices guide describes it as an open-format README for agents.

What it is for:

- durable project guidance that should apply before the agent starts work
- team norms and repository rules that travel with the codebase
- local nested guidance for more specialized directories

Where it shines:

- build, test, and lint commands
- verification expectations
- review expectations
- repo or directory-specific conventions
- routing guidance when Codex keeps reading the wrong parts of a codebase

Why it is powerful:

- Codex layers guidance from broad to local scope
- files closer to the working directory take precedence
- this turns repeated feedback into durable behavior instead of repeated prompt text

Do not reach for `AGENTS.md` when:

- the behavior is only for one reusable workflow rather than most work in a scope
- you need lifecycle-time behavior at session start or tool boundaries
- the real change is about approvals, sandboxing, or available tools

Useful nuance from the docs:

- keep it small and practical
- add rules after repeated mistakes, not preemptively for every imagined edge case
- pair it with enforcement such as tests, linters, or hooks when correctness matters

### Hooks

The docs frame hooks as deterministic scripts during the Codex lifecycle.

What they are for:

- concise lifecycle-time context injection
- light plumbing at session or tool boundaries
- crisp, objective guardrails tied to observable conditions

Where they shine:

- `SessionStart` context that should always appear in a scope
- blocking clearly bad commands at `PreToolUse`
- post-tool validation or lightweight summaries
- directory-sensitive reminders or validators

What they are not for:

- semantic planning
- hidden workflow engines
- prompt classification
- heuristic guessing about intent, delegation, or ownership

Strong rule:

- if the logic depends on prompt wording, regex buckets, scoring rules, or inferred task semantics, the hook is probably the wrong surface

Prompting nuance:

- hook-injected text should carry only the behavior-changing context
- strip scene-setting, repo trivia, and architectural debates out of hook text
- if the hard part is drafting the injected model-facing instructions so they fit the goal, runtime, and terminology rather than choosing the surface, pair the fix with `$prompt-writing`

### Skills and plugins

The docs frame skills as reusable capabilities and expertise for Codex. A plugin is the packaging and distribution surface for sharing those capabilities more broadly.

What skills are for:

- repeatable workflows
- domain-specific expertise
- procedures that benefit from references, examples, or helper scripts
- progressive disclosure instead of loading everything into every session

Why they are powerful:

- Codex starts with skill metadata for discovery
- it loads `SKILL.md` only when the skill is chosen
- it can read references or run scripts only when they are actually needed

Where they shine:

- standardized review routines
- migration planning
- release or maintenance workflows
- local expert workflows that would otherwise become bloated prompts

Do not use a skill for:

- generic personality instructions better handled by `AGENTS.md`
- shallow documentation dumps with no workflow method
- one-off prompts that are unlikely to recur

Plugin nuance that matters:

- build or install a plugin when you want to package skills, apps, or dependencies for reuse or sharing
- keep the first version local unless broader sharing is actually the goal

Prompting nuance:

- the description should say what the skill does and when to use it
- one skill should own one reusable job with a small number of concrete use cases
- keep `SKILL.md` lean and move depth into references or scripts when needed

### Subagents and custom agents

The docs frame subagents as specialized agents spawned in parallel. The concepts docs emphasize their value for managing context pollution and keeping noisy work off the main thread.

What they are for:

- bounded delegation
- parallel exploration or verification
- using different instructions, tools, or models for different roles

Where they shine:

- codebase exploration while the parent keeps planning
- tests, logs, triage, or visual verification
- multi-part work with clean ownership boundaries

Do not use them when:

- the task is tiny
- the parent is blocked on the result immediately
- multiple agents would fight over the same surface
- delegation is being used as a substitute for clearer thinking

Important reminder:

- subagents are explicit delegation tools, not automatic decomposition magic

Prompting nuance:

- give each subagent one clear job
- state the ownership boundary or write scope explicitly
- match the tool and model surface to the kind of proof the task needs
- include anti-drift or evidence expectations when correctness matters

### MCP and connectors

The docs frame MCP as the standard way to connect Codex to external tools and context providers.

What it is for:

- giving Codex access to systems outside the local repo
- making live external context available as tools, resources, or prompts
- turning repeated copy-paste context into a durable integration

Where it shines:

- documentation systems
- issue trackers
- design tools
- browsers
- internal services

Useful mental model from the docs:

- host: Codex
- client: the MCP connection inside Codex
- server: the external tool or context provider

That separation matters because capability and trust boundaries differ. Some MCP servers mostly provide context; others expose powerful actions.

### Config

The docs frame `config.toml` as the baseline operating posture across Codex surfaces.

What it is for:

- default model and reasoning settings
- approvals and sandboxing
- profiles
- MCP and app setup
- feature flags
- project trust and config loading behavior

Do not use config when:

- the issue is one reusable workflow better expressed as a skill
- the issue is durable repo behavior better expressed in `AGENTS.md`
- the issue is truly one-off and belongs in the prompt

### Rules

The docs frame rules as controlling which commands Codex can run outside the sandbox.

What they are for:

- crisp command-level policy
- specific allow, ask, or deny behavior around command prefixes

Where they shine:

- narrow, objective exceptions
- keeping the sandbox tight while permitting a few recurring commands

Do not use rules for:

- semantic task interpretation
- high-level workflow guidance
- command families that are too broad to be safe as prefix matches

## 4. Execution and scaling surfaces

### Worktrees

Worktrees matter because they let parallel Codex work happen without colliding with your active checkout.

Where they shine:

- parallel threads on the same repo
- background automations
- isolated spikes or risky changes
- cloud or app workflows that should not step on active local work

Use a worktree when isolation is the real need. Do not default to one when the task depends on exact local uncommitted state.

### Local environments

Local environments are the setup and action layer for worktrees and app-local workflows.

Where they shine:

- preparing new worktrees
- installing dependencies
- defining reusable actions such as test, build, or dev-server commands

This is the right surface when the workflow is failing because the environment is not ready, not because the agent needs more prose.

### Automations

Automations are for stable recurring Codex tasks.

Where they shine:

- maintenance or monitoring
- recurring summaries or reviews
- stable workflows that should wake up on a cadence

Strong rule from the best-practices guide:

- automate only after the workflow is manually reliable

Skills define the method. Automations define the schedule.

Prompting nuance:

- the automation prompt should describe the durable task, not the cadence or workspace
- include change detection, source priority, delegation limits, and done-when when the run is non-trivial
- if the hard part is drafting that model-facing task prompt so it fits the intended goal, runtime, and terminology, pair the draft with `$prompt-writing`

## 5. Administration and trust surfaces

These are not usually the first pages to read, but they matter when the real blocker is environment posture rather than prompt quality.

### Authentication

Use this when the issue is how Codex signs in, whether account auth or API-key auth is appropriate, or how non-interactive and cloud workflows should authenticate.

### Agent approvals and security

Use this when the issue is operational trust boundaries, approval posture, or cloud execution controls. This is different from Codex Security and different from Cyber Safety.

### Remote connections

Use this when Codex needs to work against remote environments rather than only the local machine or default cloud environment.

### Enterprise and managed configuration

Use these docs when the real question is centrally managed rollout, governance, or org-level policy, not local workflow design.

## 6. Surface-choice heuristics

- First choose the workflow contract: what context is guaranteed, what needs approval, and what counts as done.
- Then choose the customization surface: `AGENTS.md`, memories, skill, hook, config, MCP, subagent, or rules.
- Then choose the execution surface: local, worktree, cloud, automation, or one of the programmatic surfaces.
- Move repeated behavior outward from one-off prompts.
- Use the workflow docs whenever the hard part is what context is automatic versus what must be attached.
- If the proposal depends on semantic guessing, keyword heuristics, or inferred workflow phases, default away from hooks and toward model-facing instructions or a different surface.
- If repeated prompt edits are not fixing the problem, step back and ask whether the wrong surface is being used.

## 7. Config fields worth checking first

These are the highest-leverage config fields to know by heart. Do not try to memorize the full config reference.

### Session defaults

- `model`, `model_reasoning_effort`: default intelligence and depth posture
- `plan_mode_reasoning_effort`: plan-mode-specific reasoning override
- `service_tier`: fast versus flex preference when supported
- `profile`, `profiles.<name>.*`: named operating modes for repeatable posture changes
- `notify`: command invoked for notifications

### Execution boundaries

- `approval_policy`: when Codex pauses for approval
- `approvals_reviewer`: who reviews supported approvals
- `sandbox_mode`: read-only, workspace-write, or danger-full-access
- `sandbox_workspace_write.network_access`, `sandbox_workspace_write.writable_roots`: what the writable sandbox can actually reach
- `allow_login_shell`: whether shell tools may run with login-shell semantics

### Instruction layering and project scope

- `model_instructions_file`: config-level replacement for built-in instructions
- project `.codex/config.toml` layers: ordered from project root down to the current directory, closest wins
- `projects.<path>.trust_level`: whether project-scoped config is even loaded
- `project_root_markers`: how Codex finds project roots and related instruction layers
- `project_doc_fallback_filenames`, `project_doc_max_bytes`: how alternate instruction files and size limits behave

### Reuse and delegation

- `features.codex_hooks`: whether hooks are enabled
- `features.memories` plus `[memories]` settings: memory generation and reuse tradeoffs
- `features.multi_agent`: whether multi-agent collaboration tools are enabled
- `agents.max_threads`, `agents.max_depth`: concurrency and recursion guardrails
- `skills.config`: per-skill enable or disable overrides

### Tool and connector surface

- `mcp_servers.*`: enablement, env, timeouts, tool allow or deny, and startup behavior
- `apps.*`: app-wide or per-tool enablement and approval behavior
- `rules.prefix_rules`: command guardrails that are stronger than asking nicely in a prompt

### Provider and routing

- `model_provider`, `openai_base_url`: provider or proxy routing

## 8. Doc map

Use these grouped paths when you need live detail. Start from the group that matches the kind of problem, not from a random page.

### Core design concepts

- Customization:
  `https://developers.openai.com/codex/concepts/customization`
- Memories:
  `https://developers.openai.com/codex/memories`
- Sandboxing:
  `https://developers.openai.com/codex/concepts/sandboxing`
- Workflows:
  `https://developers.openai.com/codex/workflows`
- Models:
  `https://developers.openai.com/codex/models`
- Cyber Safety:
  `https://developers.openai.com/codex/concepts/cyber-safety`
- Best practices:
  `https://developers.openai.com/codex/learn/best-practices`

### Customization and extensibility

- `AGENTS.md`:
  `https://developers.openai.com/codex/guides/agents-md`
- Hooks:
  `https://developers.openai.com/codex/hooks`
- Skills:
  `https://developers.openai.com/codex/skills`
- Subagents:
  `https://developers.openai.com/codex/subagents`
- Subagent concepts:
  `https://developers.openai.com/codex/concepts/subagents`
- MCP:
  `https://developers.openai.com/codex/mcp`
- Plugins overview:
  `https://developers.openai.com/codex/plugins`
- Build plugins:
  `https://developers.openai.com/codex/plugins/build`
- Config basics:
  `https://developers.openai.com/codex/config-basic`
- Advanced config:
  `https://developers.openai.com/codex/config-advanced`
- Config reference:
  `https://developers.openai.com/codex/config-reference`
- Rules:
  `https://developers.openai.com/codex/rules`

### Programmatic, cloud, and automation surfaces

- Non-interactive mode:
  `https://developers.openai.com/codex/noninteractive`
- Codex SDK:
  `https://developers.openai.com/codex/sdk`
- App Server:
  `https://developers.openai.com/codex/app-server`
- GitHub Action:
  `https://developers.openai.com/codex/github-action`
- Codex cloud:
  `https://developers.openai.com/codex/cloud`
- GitHub integration:
  `https://developers.openai.com/codex/integrations/github`
- Use cases:
  `https://developers.openai.com/codex/use-cases`

### Trust, operations, and administration

- Authentication:
  `https://developers.openai.com/codex/auth`
- Agent approvals and security:
  `https://developers.openai.com/codex/agent-approvals-security`
- Remote connections:
  `https://developers.openai.com/codex/remote-connections`
- Codex Security:
  `https://developers.openai.com/codex/security`
- Enterprise admin:
  `https://developers.openai.com/codex/enterprise/admin-setup`
- Enterprise governance:
  `https://developers.openai.com/codex/enterprise/governance`
- Managed configuration:
  `https://developers.openai.com/codex/enterprise/managed-configuration`

### Discover what changed

- Codex docs home:
  `https://developers.openai.com/codex`
- Developers docs index:
  `https://developers.openai.com/llms.txt`
- Codex docs index:
  `https://developers.openai.com/codex/llms.txt`
- Cookbook index:
  `https://developers.openai.com/cookbook/llms.txt`
- Developers full docs export:
  `https://developers.openai.com/llms-full.txt`
- Codex full docs export:
  `https://developers.openai.com/codex/llms-full.txt`
- Cookbook full docs export:
  `https://developers.openai.com/cookbook/llms-full.txt`
- Codex changelog:
  `https://developers.openai.com/codex/changelog`
- Feature maturity:
  `https://developers.openai.com/codex/feature-maturity`
- Open source:
  `https://developers.openai.com/codex/open-source`
- Cookbook:
  `https://developers.openai.com/cookbook`
- Developers homepage:
  `https://developers.openai.com/`

Use the `llms.txt` indexes as the fast current map of what exists, and the `llms-full.txt` exports for targeted deeper reading once you know which sections or entries matter.

Treat X as early signal only. Confirm changes against official docs, cookbook pages, blog posts, help-center guidance, or another official OpenAI source before updating the skill.
