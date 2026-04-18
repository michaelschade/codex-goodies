## Summary

## Why This Belongs In `codex-goodies`

## Consuming-Machine Impact

- [ ] No machine rerun needed beyond the live symlinked file edits
- [ ] Rerun `bin/install --user` on consuming machines because a top-level entry under `codex-home/skills`, `codex-home/agents`, or `codex-home/hooks` was added, removed, or renamed

## Public-Safety Checklist

- [ ] `scripts/check-public-safety.sh` passed
- [ ] No secrets, auth material, or machine-local Codex state were added
- [ ] No absolute `/Users/...` or `/home/...` paths remain in synced content
- [ ] No bundled product/system skill content was copied in by accident

## Review

- [ ] Codex Security review requested
- [ ] Auto-merge enabled after required checks and review were green, if repository settings allowed it
