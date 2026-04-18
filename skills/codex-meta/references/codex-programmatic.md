# Codex Programmatic Surfaces

Load this file when the hard part is `codex exec`, the SDK, App Server, GitHub Action, or embedding Codex into a larger system.

This reference is for the high-leverage automation and infrastructure surfaces. It assumes you already understand the broader Codex layering model from [codex-system.md](codex-system.md).

## 1. Choose the surface first

### `codex exec`

Use when you want:

- one-shot or resumable runs from scripts, CI, or scheduled jobs
- explicit sandbox and approval settings
- output that pipes cleanly into other shell tools
- JSONL or schema-constrained output for downstream automation

Do not use it when you need a custom client UI, live approvals inside your own product, or deeper thread orchestration than a script boundary can comfortably own.

### `codex mcp-server` and Agents SDK orchestration

Use when you want:

- Codex to appear as a tool inside another agent runtime
- multi-agent development workflows with hand-offs, guardrails, and traces
- a long-running Codex worker reused across multiple agent turns
- deterministic, reviewable pipelines that are richer than a single script but lighter than building your own Codex client

The official guide frames this as a major workflow pattern, not a curiosity. Codex CLI can run as an MCP server, expose `codex()` and `codex-reply()` tools, and stay alive across multiple turns while another agent system orchestrates the larger flow.

Do not use it when a single `codex exec` step is enough, or when your real need is a custom client protocol with approvals, history, and streamed events.

### SDK

Use when you want:

- programmatic thread control from an application or service
- server-side orchestration that can start and resume work over time
- Codex inside your own internal tools or product workflows

Do not use it when a single `codex exec` job is enough, or when the main requirement is a rich client protocol with approvals, streamed events, and client-owned UI state.

### App Server

Use when you want:

- a deep integration inside your own product
- authentication, conversation history, approvals, and streamed agent events
- a custom rich client, review console, or domain-specific Codex UI

Do not use it for simple CI jobs or shell scripts where `codex exec` already fits.

### GitHub Action

Use when you want:

- GitHub events to trigger Codex work
- Codex reviews, patches, or workflow steps from GitHub Actions
- a packaged GitHub-native wrapper around `codex exec`

Do not use it when GitHub is not the control plane, or when you need a richer multi-step service outside Actions.

### Quick chooser

Use the smallest surface that fits:

- If `stdout`, `stderr`, JSONL, and a schema are enough, start with `codex exec`.
- If you want Codex to be one tool inside a broader agentic system, start with `codex mcp-server` and the Agents SDK guide.
- If you need stored thread IDs and resumable work from your own service, use the SDK.
- If you need a full custom client with approvals, history UI, and live events, use App Server.
- If the trigger is a GitHub event, start with the GitHub Action.

## 2. `codex exec` is more than “CLI without the TUI”

The non-interactive docs describe `codex exec` as running Codex in scripts and CI, but the real power is that it turns Codex into a shell-native automation primitive.

### What it gives you

- progress on `stderr` and only the final agent message on `stdout`
- piped stdin as additional context
- `--ephemeral` when you do not want to persist rollout files
- explicit sandbox and approval settings
- JSON Lines output with `--json`
- schema-constrained final responses with `--output-schema`
- resumable multi-stage flows with `codex exec resume`
- API-key auth that is purpose-built for automation

The JSONL mode is especially important. The docs note that event types include:

- `thread.started`
- `turn.started`
- `turn.completed`
- `turn.failed`
- `item.*`
- `error`

And the item stream covers much more than final prose:

- agent messages
- reasoning
- command executions
- file changes
- MCP tool calls
- web searches
- plan updates

That means `codex exec` is not just “generate me a paragraph.” It can be used as an observable worker inside a larger shell pipeline.

### Where it shines

- CI autofix jobs after a failed workflow
- release notes, summaries, or migration checklists generated from git state
- structured project metadata extraction with `--output-schema`
- log, alert, or export analysis driven by shell pipes
- scheduled jobs that read artifacts, return structured results, and hand off the next step to another tool
- two-stage pipelines where one run analyzes and the next run resumes to implement

### High-leverage patterns

These patterns are directly supported by the docs or are straightforward combinations of documented features.

#### Codex as a shell-native reducer

Take large, noisy artifacts and reduce them into something human-usable or machine-usable.

Examples:

- `curl ... | codex exec "...summarize or reformat..." > output.md`
- `git log ... | codex exec "...draft release notes..." | tee release-notes.md`
- `rg ... | codex exec "...group the findings into risks..." --output-schema schema.json`

This is a strong fit when the task is fundamentally “read external data, reason over it, emit a clean artifact.”

#### Codex as a typed worker

If downstream automation needs stable fields instead of prose, `--output-schema` is one of the most important features in the entire Codex system.

Good use cases:

- release metadata
- risk reports
- repo classification
- bug or incident triage records
- migration checkpoints

This is one of the clearest ways to turn Codex from “assistant text” into a real pipeline component.

#### Codex as a resumable pipeline stage

The docs explicitly support resuming a previous run with `codex exec resume`.

That opens patterns like:

- analyze now, implement later
- collect evidence in stage one, draft action plan in stage two
- review in one run, fix only approved findings in the next

If you only need one or two turns and a shell boundary is natural, this is often better than reaching for the SDK too early.

### Where it is the wrong tool

- custom review UIs
- approval consoles inside another product
- workflows that need long-lived service-owned thread state
- custom client behavior like steerable in-flight turns or dynamic tool callbacks

## 2.5 Codex CLI as an MCP server is a distinct automation pattern

The `Use Codex with the Agents SDK` guide and the cookbook workflow example make a stronger point than our current skill had captured: Codex CLI is not just a terminal client and not just a script target. It can also become an MCP tool provider for other agents.

### Why this matters

- it turns Codex into a reusable coding worker inside a broader orchestrated system
- it keeps Codex alive across multiple agent turns instead of paying the full setup cost for each shell invocation
- it gives you a clean split between orchestration logic and implementation logic

The official guide explicitly positions this as a way to create deterministic, reviewable workflows that scale from a focused single-agent workflow to a complete software delivery pipeline.

### Where it shines

- multi-agent developer workflows with clear hand-offs
- planning agents that delegate concrete implementation to Codex
- systems where Codex should be one specialized capability among several
- workflows that benefit from Agents SDK traces and guardrails while still using Codex for the coding-heavy work

### Important mechanics

- start Codex as an MCP server with `codex mcp-server`
- the server exposes two tools: `codex()` to start a conversation and `codex-reply()` to continue one
- Agents SDK integrations can connect over stdio and keep the same Codex worker around across turns

### When this is better than the local SDK

Use this pattern when:

- the parent orchestration system is already built around MCP or Agents SDK primitives
- you want Codex to be a specialist worker inside a broader agent team
- you want Agents SDK guardrails, traces, and orchestration while reusing Codex for coding execution

Use the Codex SDK instead when the service boundary is primarily “own Codex threads directly” rather than “treat Codex as one MCP-backed tool inside another agent runtime.”

## 3. The SDK is for Codex as a service dependency

The SDK docs describe two distinct shapes:

- a TypeScript library that is more comprehensive and flexible than non-interactive mode
- an experimental Python library that controls the local Codex app-server over JSON-RPC

### Why the TypeScript SDK matters

The TypeScript SDK is the cleanest way to embed Codex in server-side systems without designing your own full protocol layer.

The core mental model is simple:

- create a `Codex` client
- start a thread
- run prompts on that thread
- resume the same thread later by ID

That last part is the real unlock. The SDK is not just about calling Codex; it is about treating a thread as durable workflow state.

### Where it shines

- internal engineering tools that need to start and resume work items
- services that escalate from analysis to implementation over multiple turns
- bots or dashboards that need Codex to maintain a coherent thread per issue, repo, or incident
- product workflows that want Codex behind a form, button, or webhook
- orchestration services that route work to Codex and persist thread IDs alongside task IDs

### Good SDK patterns

#### Thread per work item

Treat one Codex thread as the durable context for one coherent work item:

- one incident
- one migration
- one flaky-test investigation
- one review thread

This lets the service resume work without re-stuffing the same context every time.

#### Human checkpoint orchestration

Use Codex for one stage, then let a human or another service decide whether to continue:

- stage 1: diagnose
- stage 2: approve scope
- stage 3: implement

The SDK is a strong fit because the thread can resume from the existing reasoning trail instead of reauthoring a giant prompt each time.

#### Proactive Codex services

The official “Set up a teammate” use case is a good example of the broader pattern. The use case itself is framed through plugins and automations, but the same architecture can be implemented through the SDK when you want your own service layer.

Examples:

- a workstream concierge that checks tools and escalates what needs attention
- a triage service that revisits the same issue thread on a cadence
- a launch assistant that keeps a running thread for one launch and resumes when new source material appears

### Python SDK nuance

The Python SDK is experimental and controls the local app-server. It is a better fit for:

- notebooks
- local prototypes
- research workflows
- glue code in Python-heavy internal tooling

It is not the primary recommendation for broad production integration when the TypeScript SDK already fits your service boundary.

### When the SDK is not enough

If you need:

- explicit approval UIs
- streamed item-level events in your own client
- custom client-side tool callbacks
- thread history browsing and archive operations in your own product

then the real surface is App Server, not the SDK.

## 4. App Server is the protocol for building your own Codex client

The App Server docs describe it as the interface Codex uses to power rich clients. That is the key mental model.

Use it when the goal is not just “call Codex from code,” but “build a Codex-native experience inside another product.”

### Why it is powerful

The docs call out the important client-facing capabilities directly:

- authentication
- conversation history
- approvals
- streamed agent events

And the protocol surface is deep:

- JSON-RPC over `stdio` or experimental WebSocket
- thread start, resume, read, list, fork, archive, unarchive, compact, and rollback
- thread status tracking and loaded-thread management
- user-initiated `thread/shellCommand`
- background terminal cleanup
- turn start, steer, and interrupt
- per-turn overrides for model, effort, `cwd`, sandbox policy, summary, personality, and `outputSchema`
- text, remote image, and `localImage` inputs
- command and file-change approvals
- dynamic tools
- skills listing and configuration
- apps listing and enablement visibility

This is much closer to “build your own Codex client” than to “run one Codex job.”

### Capabilities that are easy to underrate

#### `turn/steer`

The ability to steer an active turn is a major difference from simpler automation surfaces. It lets your client append new user input to an in-flight turn without restarting the whole interaction.

That is useful for:

- human-in-the-loop correction
- narrowing a turn after partial results
- interactive review or triage consoles

#### Approval handling

App Server pushes approval requests to the client for command execution and file changes, and the client responds with a decision payload.

This is what you use when approvals are part of your product experience rather than something you want to approximate with logs and shell wrappers.

#### Dynamic tools

The experimental dynamic-tool flow means your client can act as a live tool provider during a turn.

That opens patterns like:

- domain-specific internal actions exposed only inside your product
- operator consoles that route certain actions through your own backend
- hybrid clients where Codex handles reasoning but your application handles privileged actions

#### Skills and apps awareness

App Server can list skills and apps, and can inject explicit skill input items. That means your custom client can surface the same broader Codex capability model instead of pretending Codex is only raw chat.

### Where App Server shines

- custom IDE-like clients
- review dashboards with thread history and approval controls
- domain-specific engineering consoles
- browser or desktop products that want Codex as a first-class embedded subsystem
- internal tools that need live event streams, images, and explicit steerability

### Where App Server is overkill

- one-shot scripts
- CI jobs
- scheduled cron-like work
- simple orchestration where the SDK already covers the needed thread lifecycle

## 5. GitHub Action is event-driven `codex exec`

The GitHub Action docs make this very clear: the action installs the Codex CLI, starts the Responses API proxy when you provide an API key, and runs `codex exec` under the permissions you specify.

That means the GitHub Action is not a separate conceptual system. It is a GitHub-shaped wrapper around the non-interactive surface.

### Where it shines

- PR review automation
- CI quality gates
- patch proposals driven by GitHub events
- release prep or migration tasks triggered from workflow files

### Why choose it over hand-rolled CLI steps

- less glue code
- a more standard GitHub Actions entrypoint
- easier packaging of prompts and permissions inside one workflow file

### Where not to use it

- non-GitHub automation
- richer orchestration that needs stored thread state across a service
- custom approval or review experiences outside the Actions model

## 6. Range of applications

The examples below combine official programmatic-surface docs with official Codex use cases. Some are direct documented patterns; others are straightforward compositions of documented capabilities.

### CI autofix and narrow repair bots

Best surface:

- `codex exec` or GitHub Action

Why it works:

- the non-interactive docs explicitly show autofixing CI failures
- the GitHub Action is purpose-built for GitHub event triggers
- narrow prompts plus explicit permissions make the trust boundary legible

### Multi-agent delivery pipelines with Codex as the coding worker

Best surface:

- `codex mcp-server` plus Agents SDK orchestration

Why it works:

- the official guide explicitly frames this as a path from a single agent to a full software delivery pipeline
- Codex handles the coding-heavy work while the parent system owns orchestration, hand-offs, guardrails, and traces
- it is a strong fit when Codex should be specialized, not the whole system

This is one of the biggest concepts surfaced by the current `llms.txt` map and was previously underweighted in the skill.

### Release intelligence and structured reporting

Best surface:

- `codex exec`

Why it works:

- `stdout`/`stderr` separation makes it easy to chain shell tools
- JSONL gives full event telemetry
- `--output-schema` turns final output into typed data for later stages

This is a strong pattern for release notes, migration reports, dependency summaries, risk scans, and other “analyze then emit an artifact” jobs.

### Cross-system engineering automation

Best surface:

- `codex exec` or GitHub Action for direct event jobs
- `codex mcp-server` plus Agents SDK when multiple systems and hand-offs are involved

Examples surfaced by the current cookbook index:

- Jira to GitHub automation
- GitLab code quality and security fixers
- structured code review services with the Codex SDK

These are useful reminders that Codex is not just for local coding sessions. It can sit in the middle of engineering systems and workflow glue.

### Multi-source bug triage sweeps

Best surface:

- `codex exec` for a narrow scheduled sweep
- SDK if you want service-owned thread continuity

Why it works:

- the official bug-triage use case already frames this as a workflow you tune manually and then automate
- the use case also shows how multi-source evidence across GitHub, Slack, Linear, Sentry, logs, and tickets can be combined into one prioritized report

This is one of the clearest examples of Codex as a real operational worker rather than a coding-only assistant.

### Code modernization and long-horizon migrations

Best surface:

- `codex exec` for narrow modernization passes
- SDK or MCP-server orchestration for staged multi-step programs

Why it works:

- the cookbook now includes a dedicated modernization example
- these workflows benefit from reviewable staged outputs, resumability, and clear done-when criteria

This is a good example of Codex as a force multiplier on large but mechanically repetitive change programs.

### Slack-thread handoffs into scoped tasks

Best surface:

- official Slack integration and Codex cloud for the standard case
- SDK or App Server for a custom internal version

Why it works:

- the Slack use case shows that async work intake can start from conversation context instead of a local session
- if your team needs a custom version of that idea inside its own product, the SDK or App Server becomes the deeper surface

### Proactive teammate services

Best surface:

- SDK for a custom service
- cloud plus automations for the default product path

Why it works:

- the official “Set up a teammate” use case shows Codex watching connected sources and escalating what matters
- the same underlying pattern generalizes to internal ops assistants, launch monitors, or decision escalators

### Agent-friendly CLIs as a Codex force multiplier

Best surface:

- interactive Codex to build the CLI and its companion skill
- then `codex exec` or SDK-based systems can rely on the resulting tool

Why it works:

- the official use case explicitly recommends creating a composable CLI for APIs, log sources, exports, or local databases
- this is a good reminder that some “automation” wins come from giving Codex a better tool surface, not from adding more prompt text

### Custom review and approval consoles

Best surface:

- App Server

Why it works:

- thread history, list/read/fork/archive operations, approval requests, steering, shell-command injection, and skill/app discovery all belong naturally in a custom client

This is where App Server starts to look like a serious platform boundary rather than just a transport protocol.

### Visual or domain-specific clients

Best surface:

- App Server

Why it works:

- the docs support remote images and `localImage` input items
- in-flight steering lets a user react to what Codex is doing
- dynamic tools let the host application expose product-specific actions back to Codex

This is the shape you want when building a serious review UI, debugging console, or domain-specific engineering workstation.

## 7. Heuristics

- Start with `codex exec` unless you have a clear reason to own more infrastructure.
- Upgrade to the SDK when thread continuity becomes a real requirement.
- Upgrade to App Server when client behavior, approvals, streamed events, or custom tools become the real product.
- Use the GitHub Action when GitHub is already the workflow control plane.
- If you keep trying to solve infrastructure needs with hooks, giant prompts, or fragile shell wrappers, you are probably on the wrong surface.

## 8. Where to read more

- Non-interactive mode:
  `https://developers.openai.com/codex/noninteractive`
- Codex SDK:
  `https://developers.openai.com/codex/sdk`
- App Server:
  `https://developers.openai.com/codex/app-server`
- GitHub Action:
  `https://developers.openai.com/codex/github-action`
- Use Codex with the Agents SDK:
  `https://developers.openai.com/codex/guides/agents-sdk`
- Codex use cases:
  `https://developers.openai.com/codex/use-cases`
- Create a CLI Codex can use:
  `https://developers.openai.com/codex/use-cases/agent-friendly-clis`
- Automate bug triage:
  `https://developers.openai.com/codex/use-cases/automation-bug-triage`
- Kick off coding tasks from Slack:
  `https://developers.openai.com/codex/use-cases/slack-coding-tasks`
- Set up a teammate:
  `https://developers.openai.com/codex/use-cases/proactive-teammate`
- Build Code Review with the Codex SDK:
  `https://developers.openai.com/cookbook/examples/codex/build_code_review_with_codex_sdk.md`
- Building Consistent Workflows with Codex CLI & Agents SDK:
  `https://developers.openai.com/cookbook/examples/codex/codex_mcp_agents_sdk/building_consistent_workflows_codex_cli_agents_sdk.md`
- Automating Code Quality and Security Fixes with Codex CLI on GitLab:
  `https://developers.openai.com/cookbook/examples/codex/secure_quality_gitlab.md`
- Automate Jira ↔ GitHub with Codex:
  `https://developers.openai.com/cookbook/examples/codex/jira-github.md`
- Modernizing your Codebase with Codex:
  `https://developers.openai.com/cookbook/examples/codex/code_modernization.md`
