# Repository Settings

These GitHub-side settings are the missing half of the local repo workflow. The files in this repository can shape CI and PR hygiene, but they cannot enforce branch protection or turn on auto-merge by themselves.

## Recommended GitHub Settings

Apply these once in the GitHub UI for `michaelschade/codex-goodies`:

1. General
   - Allow auto-merge: enabled
   - Automatically delete head branches: enabled
   - Allow squash merging: enabled
   - Allow merge commits: disabled
   - Allow rebase merging: disabled
2. Branch protection or ruleset for `main`
   - Require a pull request before merging
   - Require at least 1 approval
   - Dismiss stale approvals when new commits are pushed: enabled
   - Require conversation resolution before merging: enabled
   - Require status checks to pass before merging: enabled
   - Required check: `Public Safety / public-safety`
   - Do not allow bypasses except for an intentional owner/admin exception if you explicitly want one

## Intended Flow

1. Push a topic branch in this repository.
2. Open a non-draft PR targeting `main`.
3. Request Codex Security review.
4. The `Arm Auto-merge` workflow requests squash auto-merge for that PR.
5. GitHub waits for the required review and `Public Safety` check to succeed, then merges automatically.

## Notes

- The auto-merge workflow intentionally ignores PRs from forks. Those can still be merged manually or have auto-merge enabled manually in the UI if you want them to use the same path.
- If the workflow fails with an auto-merge error, check whether the repository-level auto-merge toggle or the `main` branch rules drifted from the settings above.
