# Agents

Keep this index current whenever a top-level agent role is added, removed, renamed, or meaningfully repurposed. `scripts/check-public-safety.sh` verifies that every tracked agent entry is covered here.

- `builder.toml`: Defines the fast Spark-based builder role for one bounded, text-first implementation or artifact-prep task. It is intentionally strict about staying within a narrow ownership boundary and escalating work that turns visual, stateful, or otherwise proof-heavy.
- `precision.toml`: Defines the high-certainty role for correctness-critical, visual, or stateful work. It separates investigation, change, and fresh verification so delegated work comes back with concrete proof instead of optimistic claims.
- `scout.toml`: Defines the read-only exploration role for focused evidence gathering and compact handoffs. It is meant to reduce uncertainty for the parent without drifting into implementation or claiming more proof than it actually has.
