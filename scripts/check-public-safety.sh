#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

failures=0
SCAN_PATHS=(AGENTS.md CONTRIBUTING.md README.md agents hooks hooks.json skills .github docs scripts)

fail() {
  printf '[FAIL] %s\n' "$1" >&2
  failures=$((failures + 1))
}

pass() {
  printf '[OK] %s\n' "$1" >&2
}

require_git() {
  command -v git >/dev/null 2>&1 || {
    printf 'git is required for %s\n' "${BASH_SOURCE[0]}" >&2
    exit 1
  }
}

current_tracked_paths() {
  local path=''

  while IFS= read -r path; do
    if [[ -e "$path" || -L "$path" ]]; then
      printf '%s\n' "$path"
    fi
  done < <(git ls-files)
}

check_tracked_path_banlist() {
  local banned=''

  banned=$(current_tracked_paths | rg '(^|/)(auth\.json|session_index\.jsonl|models_cache\.json|installation_id|version\.json|\.codex-global-state\.json|.*\.sqlite(|-shm|-wal)|.*\.db|.*\.db-shm|.*\.db-wal|.*\.bak|.*\.orig|.*~|bak-skill\.md)$|(^|/)(archived_sessions|automations|cache|generated_images|log|memories|sessions|shell_snapshots|sqlite)/|^codex-home(/|$)|^skills/(\.system|codex-primary-runtime)(/|$)' || true)
  if [[ -n "$banned" ]]; then
    fail "tracked files or directories from local Codex state are present:"
    printf '%s\n' "$banned" >&2
  else
    pass "no banned local-state paths are tracked"
  fi
}

check_absolute_home_paths() {
  local matches=''

  matches=$(rg -n '/Users/[A-Za-z0-9_-][^[:space:]"]+|/home/[A-Za-z0-9_-][^[:space:]"]+' "${SCAN_PATHS[@]}" || true)
  if [[ -n "$matches" ]]; then
    fail "absolute home-directory paths were found in tracked content:"
    printf '%s\n' "$matches" >&2
  else
    pass "no absolute home-directory paths were found"
  fi
}

check_secret_like_content() {
  local matches=''

  matches=$(rg -n --glob '!scripts/check-public-safety.sh' 'sk-[A-Za-z0-9]{20,}|ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|xox[baprs]-[A-Za-z0-9-]{10,}|BEGIN [A-Z ]*PRIVATE KEY|OPENAI_API_KEY=' "${SCAN_PATHS[@]}" || true)
  if [[ -n "$matches" ]]; then
    fail "secret-like content was found:"
    printf '%s\n' "$matches" >&2
  else
    pass "no secret-like content was found"
  fi
}

readme_mentions_entry() {
  local readme=$1
  local entry_name=$2

  rg -Fq "\`$entry_name\`" "$readme"
}

check_agents_index() {
  local readme='agents/README.md'
  local agent_file=''
  local entry_name=''
  local missing=0

  if [[ ! -f "$readme" ]]; then
    fail "agents index README is missing: $readme"
    return
  fi

  while IFS= read -r agent_file; do
    entry_name=$(basename "$agent_file")
    if ! readme_mentions_entry "$readme" "$entry_name"; then
      fail "agents index README is missing \`$entry_name\`: $readme"
      missing=1
    fi
  done < <(find agents -mindepth 1 -maxdepth 1 -type f -name '*.toml' | LC_ALL=C sort)

  if ((missing == 0)); then
    pass "agents/README.md covers every tracked agent"
  fi
}

check_hooks_index() {
  local readme='hooks/README.md'
  local hook_entry=''
  local entry_name=''
  local missing=0

  if [[ ! -f "$readme" ]]; then
    fail "hooks index README is missing: $readme"
    return
  fi

  while IFS= read -r hook_entry; do
    entry_name=$(basename "$hook_entry")
    if ! readme_mentions_entry "$readme" "$entry_name"; then
      fail "hooks index README is missing \`$entry_name\`: $readme"
      missing=1
    fi
  done < <(find hooks -mindepth 1 -maxdepth 1 ! -name '.DS_Store' ! -name 'README.md' | LC_ALL=C sort)

  if ((missing == 0)); then
    pass "hooks/README.md covers every tracked hook entry"
  fi
}

check_skill_shape() {
  local skill_dir=''

  while IFS= read -r skill_dir; do
    [[ -f "$skill_dir/SKILL.md" ]] || fail "skill is missing SKILL.md: $skill_dir"
    [[ -f "$skill_dir/README.md" ]] || fail "skill is missing README.md: $skill_dir"
  done < <(find skills -mindepth 1 -maxdepth 1 -type d ! -name '.*' | LC_ALL=C sort)

  pass "every tracked custom skill has SKILL.md and README.md"
}

check_skills_index() {
  local readme='skills/README.md'
  local skill_dir=''
  local entry_name=''
  local missing=0

  if [[ ! -f "$readme" ]]; then
    fail "skills index README is missing: $readme"
    return
  fi

  while IFS= read -r skill_dir; do
    entry_name=$(basename "$skill_dir")
    if ! readme_mentions_entry "$readme" "$entry_name"; then
      fail "skills index README is missing \`$entry_name\`: $readme"
      missing=1
    fi
  done < <(find skills -mindepth 1 -maxdepth 1 -type d ! -name '.*' | LC_ALL=C sort)

  if ((missing == 0)); then
    pass "skills/README.md covers every tracked skill"
  fi
}

check_python_hook_compiles() {
  if [[ -f hooks/session_start_subagents.py ]]; then
    python3 -m py_compile hooks/session_start_subagents.py
    pass "hook script compiles with python3"
  fi
}

main() {
  require_git
  check_tracked_path_banlist
  check_absolute_home_paths
  check_secret_like_content
  check_agents_index
  check_hooks_index
  check_skill_shape
  check_skills_index
  check_python_hook_compiles

  if ((failures > 0)); then
    printf '\npublic-safety check failed with %d issue(s)\n' "$failures" >&2
    exit 1
  fi

  printf '\npublic-safety check passed\n' >&2
}

main "$@"
