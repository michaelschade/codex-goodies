#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

failures=0
SCAN_PATHS=(AGENTS.md CONTRIBUTING.md README.md agents hooks hooks.json skills .github docs scripts)
MODE=auto

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

search_stream_regex() {
  local pattern=$1

  if have_rg; then
    rg "$pattern" || true
  else
    grep -E -- "$pattern" || true
  fi
}

search_paths_regex() {
  local pattern=$1

  shift

  if have_rg; then
    rg -n "$pattern" "$@" || true
  else
    grep -R -n -E -- "$pattern" "$@" || true
  fi
}

search_paths_secret_regex() {
  local pattern=$1

  shift

  if have_rg; then
    rg -n --glob '!scripts/check-public-safety.sh' "$pattern" "$@" || true
  else
    grep -R -n -E -- "$pattern" "$@" | grep -v '^scripts/check-public-safety.sh:' || true
  fi
}

staged_paths() {
  git diff --cached --name-only --diff-filter=ACMR
}

current_tracked_paths() {
  local path=''

  while IFS= read -r path; do
    if [[ -e "$path" || -L "$path" ]]; then
      printf '%s\n' "$path"
    fi
  done < <(git ls-files)
}

scope_mode() {
  local staged=''

  case "$MODE" in
    staged|tracked)
      printf '%s\n' "$MODE"
      return 0
      ;;
  esac

  staged=$(staged_paths)
  if [[ -n "$staged" ]]; then
    printf 'staged\n'
  else
    printf 'tracked\n'
  fi
}

scope_paths() {
  local mode=$1

  if [[ "$mode" == 'staged' ]]; then
    staged_paths
  else
    current_tracked_paths
  fi
}

cached_grep_paths() {
  local pattern=$1

  shift

  git grep --cached -nI -E "$pattern" -- "$@" 2>/dev/null || true
}

cached_grep_paths_secret() {
  local pattern=$1

  shift

  cached_grep_paths "$pattern" "$@" | grep -v '^scripts/check-public-safety.sh:' || true
}

check_path_banlist() {
  local mode=$1
  local banned=''

  banned=$(scope_paths "$mode" | search_stream_regex '(^|/)(auth\.json|session_index\.jsonl|models_cache\.json|installation_id|version\.json|\.codex-global-state\.json|.*\.sqlite(-shm|-wal)?|.*\.db|.*\.db-shm|.*\.db-wal|.*\.bak|.*\.orig|.*~|bak-skill\.md)$|(^|/)(archived_sessions|automations|cache|generated_images|log|memories|sessions|shell_snapshots|sqlite)/|^codex-home(/|$)|^skills/(\.system|codex-primary-runtime)(/|$)')
  if [[ -n "$banned" ]]; then
    fail "$mode scope includes tracked files or directories from local Codex state:"
    printf '%s\n' "$banned" >&2
  else
    pass "no banned local-state paths were found in the $mode scope"
  fi
}

check_absolute_home_paths() {
  local mode=$1
  local matches=''
  local -a paths=()
  local path=''

  if [[ "$mode" == 'tracked' ]]; then
    matches=$(search_paths_regex '/Users/[A-Za-z0-9_-][^[:space:]"]+|/home/[A-Za-z0-9_-][^[:space:]"]+' "${SCAN_PATHS[@]}")
  else
    while IFS= read -r path; do
      [[ -n "$path" ]] || continue
      paths+=("$path")
    done < <(scope_paths "$mode")

    if ((${#paths[@]} > 0)); then
      matches=$(cached_grep_paths '/Users/[A-Za-z0-9_-][^[:space:]"]+|/home/[A-Za-z0-9_-][^[:space:]"]+' "${paths[@]}")
    fi
  fi

  if [[ -n "$matches" ]]; then
    fail "absolute home-directory paths were found in the $mode scope:"
    printf '%s\n' "$matches" >&2
  else
    pass "no absolute home-directory paths were found in the $mode scope"
  fi
}

check_secret_like_content() {
  local mode=$1
  local matches=''
  local -a paths=()
  local path=''

  if [[ "$mode" == 'tracked' ]]; then
    matches=$(search_paths_secret_regex 'sk-[A-Za-z0-9]{20,}|ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|xox[baprs]-[A-Za-z0-9-]{10,}|BEGIN [A-Z ]*PRIVATE KEY|OPENAI_API_KEY=' "${SCAN_PATHS[@]}")
  else
    while IFS= read -r path; do
      [[ -n "$path" ]] || continue
      paths+=("$path")
    done < <(scope_paths "$mode")

    if ((${#paths[@]} > 0)); then
      matches=$(cached_grep_paths_secret 'sk-[A-Za-z0-9]{20,}|ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|xox[baprs]-[A-Za-z0-9-]{10,}|BEGIN [A-Z ]*PRIVATE KEY|OPENAI_API_KEY=' "${paths[@]}")
    fi
  fi

  if [[ -n "$matches" ]]; then
    fail "secret-like content was found in the $mode scope:"
    printf '%s\n' "$matches" >&2
  else
    pass "no secret-like content was found in the $mode scope"
  fi
}

usage() {
  cat <<'EOF'
Usage: scripts/check-public-safety.sh [--staged | --tracked]

  --staged   Check only the staged commit content
  --tracked  Check the full tracked repository content

With no flag, the script checks staged content when staged files are present and
otherwise falls back to the full tracked repository.
EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --staged)
        MODE=staged
        shift
        ;;
      --tracked)
        MODE=tracked
        shift
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        printf 'unknown argument: %s\n' "$1" >&2
        usage >&2
        exit 1
        ;;
    esac
  done
}

main() {
  local mode=''

  require_git
  parse_args "$@"
  mode=$(scope_mode)

  check_path_banlist "$mode"
  check_absolute_home_paths "$mode"
  check_secret_like_content "$mode"

  if ((failures > 0)); then
    printf '\npublic-safety check failed with %d issue(s)\n' "$failures" >&2
    exit 1
  fi

  printf '\npublic-safety check passed for %s content\n' "$mode" >&2
}

main "$@"
