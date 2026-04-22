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
   - Require status checks to pass before merging: enabled
   - Required checks:
     - `Repo Hygiene / repo-hygiene`
     - `Socket Security: Project Report`
   - Allow force pushes: disabled
   - Do not allow bypasses except for an intentional owner/admin exception if you explicitly want one

## Intended Flow

1. Push a topic branch in this repository.
2. Open a non-draft PR targeting `main`.
3. Optionally request Codex Security review when you want human review before merge.
4. The `Arm Auto-merge` workflow requests squash auto-merge for that PR.
5. GitHub waits for `Repo Hygiene`, `Socket Security: Project Report`, and any other required checks to succeed, then merges automatically.

## Notes

- Publish-safety checks for secrets, machine-local state, and absolute home-directory paths intentionally run in the local pre-commit hook instead of GitHub Actions. By the time CI runs, the branch contents are already on GitHub, so leak-prevention belongs before push rather than after publication.
- The auto-merge workflow intentionally ignores PRs from forks. Those can still be merged manually or have auto-merge enabled manually in the UI if you want them to use the same path.
- If the workflow reports repeated unstable-status rejections, that usually means GitHub had not finished settling mergeability yet. Re-run the workflow or push a new commit after the PR stabilizes before assuming the repository settings drifted.
- If the workflow fails with an auto-merge or merge-method settings error, check whether the repository-level auto-merge toggle, squash-merge setting, or the `main` branch rules drifted from the settings above.
