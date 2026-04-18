#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

failures=0

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

have_rg() {
  command -v rg >/dev/null 2>&1
}

readme_mentions_entry() {
  local readme=$1
  local entry_name=$2

  if have_rg; then
    rg -Fq "\`$entry_name\`" "$readme"
  else
    grep -Fq "\`$entry_name\`" "$readme"
  fi
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
  done < <(find hooks -mindepth 1 -maxdepth 1 ! -name '.DS_Store' ! -name 'README.md' ! -name '__pycache__' ! -name '.*' | LC_ALL=C sort)

  if ((missing == 0)); then
    pass "hooks/README.md covers every tracked hook entry"
  fi
}

check_skill_shape() {
  local skill_dir=''
  local missing=0

  while IFS= read -r skill_dir; do
    if [[ ! -f "$skill_dir/SKILL.md" ]]; then
      fail "skill is missing SKILL.md: $skill_dir"
      missing=1
    fi
    if [[ ! -f "$skill_dir/README.md" ]]; then
      fail "skill is missing README.md: $skill_dir"
      missing=1
    fi
  done < <(find skills -mindepth 1 -maxdepth 1 -type d ! -name '.*' | LC_ALL=C sort)

  if ((missing == 0)); then
    pass "every tracked custom skill has SKILL.md and README.md"
  fi
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
  local temp_cache=''

  if [[ -f hooks/session_start_subagents.py ]]; then
    temp_cache=$(mktemp -d "${TMPDIR:-/tmp}/codex-goodies-pycache.XXXXXX")
    if ! PYTHONPYCACHEPREFIX="$temp_cache" python3 -m py_compile hooks/session_start_subagents.py; then
      rm -rf "$temp_cache"
      return 1
    fi
    rm -rf "$temp_cache"
    pass "hook script compiles with python3"
  fi
}

main() {
  require_git
  check_agents_index
  check_hooks_index
  check_skill_shape
  check_skills_index
  check_python_hook_compiles

  if ((failures > 0)); then
    printf '\nrepo-hygiene check failed with %d issue(s)\n' "$failures" >&2
    exit 1
  fi

  printf '\nrepo-hygiene check passed\n' >&2
}

main "$@"
