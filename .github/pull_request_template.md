## Summary

## Why This Belongs In `codex-goodies`

## Consuming-Machine Impact

- [ ] No machine rerun needed beyond the live symlinked file edits
- [ ] Rerun `bin/install --user` on consuming machines because a top-level entry under `skills/`, `agents/`, or `hooks/` was added, removed, or renamed

## Public-Safety Checklist

- [ ] The local pre-commit hook or `scripts/check-public-safety.sh --staged` passed for the staged commit content
- [ ] `scripts/check-repo-hygiene.sh` passed
- [ ] No secrets, auth material, or machine-local Codex state were added
- [ ] No absolute `/Users/...` or `/home/...` paths remain in synced content
- [ ] No bundled product/system skill content was copied in by accident
- [ ] Directory README indexes were updated for any changed top-level entries

## Review

- [ ] Codex Security review requested
- [ ] This PR comes from a same-repo branch if it should auto-arm auto-merge
- [ ] Repo settings still match `docs/repo-settings.md`
