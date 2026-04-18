#!/usr/bin/env python3
import json
import os
import tomllib
from pathlib import Path


CODEX_HOME = Path(os.environ.get("CODEX_HOME", str(Path.home() / ".codex"))).expanduser()
AGENTS_DIR = CODEX_HOME / "agents"
ORDER = [
    "scout",
    "builder",
    "precision",
]


def load_agent(agent_name: str) -> dict:
    path = AGENTS_DIR / f"{agent_name}.toml"
    if not path.exists():
        return {}
    with path.open("rb") as fh:
        return tomllib.load(fh)


def build_context() -> str:
    lines = [
        "<available_subagents>",
        "Match delegated components to the agent whose modality, ownership boundary, and proof requirements fit best.",
        "",
        "<agents>",
    ]
    for name in ORDER:
        data = load_agent(name)
        if not data:
            continue
        model = data.get("model", "inherit")
        effort = data.get("model_reasoning_effort", "inherit")
        description = data.get("description", "").strip()
        lines.append(f"- `{name}` [{model} / {effort}]: {description}")
    lines.extend(
        [
            "</agents>",
            "",
            "<routing_hint>",
            "Spark is for bounded text-first work. Use a non-Spark owner when visual evidence, rendered layout, spatial relationships, or post-action proof matter.",
            "</routing_hint>",
            "",
            "<usage_hint>",
            "Hint by name in the prompt: `scout`, `builder`, or `precision` when a real ownership boundary exists.",
            "</usage_hint>",
            "</available_subagents>",
        ]
    )
    return "\n".join(lines)


def main() -> None:
    payload = {
        "hookSpecificOutput": {
            "hookEventName": "SessionStart",
            "additionalContext": build_context(),
        }
    }
    print(json.dumps(payload))


if __name__ == "__main__":
    main()
