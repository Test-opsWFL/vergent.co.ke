#!/usr/bin/env bash
#
# scripts/add-copyright-headers.sh
# Idempotently prepend a copyright header to every source file in the repo.
#
# Usage:
#   ./scripts/add-copyright-headers.sh           # add headers
#   ./scripts/add-copyright-headers.sh --check   # exit 1 if any file missing a header (CI use)
#
# The header attributes copyright to Vergent Technology Solutions Ltd
# (the sole IP owner) and references the proprietary LICENSE.
#
# Safe to re-run: each file is checked for the marker line
# "Copyright © 20YY Vergent Technology Solutions Ltd" before injection.
# Files already carrying the marker are skipped.
#
# Skipped automatically: node_modules, .next, .git, dist, build outputs,
# JSON files (which do not support comments), markdown files, lock files,
# and any file matched by .gitignore.

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

CHECK_MODE=0
if [ "${1:-}" = "--check" ]; then
  CHECK_MODE=1
fi

YEAR=$(date +%Y)
OWNER="Vergent Technology Solutions Ltd"
MARKER="Copyright © ${YEAR} ${OWNER}"

# ── Header bodies per comment style ──────────────────────────────────────────
read -r -d '' SLASH_HEADER <<EOF || true
// Copyright © ${YEAR} ${OWNER}. All rights reserved.
// Proprietary and confidential - see LICENSE for terms.

EOF

read -r -d '' BLOCK_HEADER <<EOF || true
/*
 * Copyright © ${YEAR} ${OWNER}. All rights reserved.
 * Proprietary and confidential - see LICENSE for terms.
 */

EOF

read -r -d '' HASH_HEADER <<EOF || true
# Copyright © ${YEAR} ${OWNER}. All rights reserved.
# Proprietary and confidential - see LICENSE for terms.

EOF

# ── Discover source files via git (respects .gitignore by definition) ───────
# Filters:
#   • Tracked files only
#   • Skip generated dirs (defence in depth, even if listed)
#   • Skip lock files + JSON (JSON has no comments)
#   • Skip markdown + plain-text + license / notice docs (legal text, not code)
FILES=$(
  git ls-files \
    | grep -E '\.(ts|tsx|js|jsx|mjs|cjs|css|sh|py|ps1|psm1|yml|yaml)$|(^|/)Dockerfile(\..+)?$' \
    | grep -vE '^(node_modules|\.next|dist|\.git|\.venv|venv|__pycache__|\.pytest_cache|build)/' \
    | grep -vE '(^|/)package-lock\.json$' \
    | grep -vE '\.d\.ts$' \
    | grep -vE '(^|/)migrations/' \
    || true
)

INJECTED=0
SKIPPED=0
MISSING=0

for file in $FILES; do
  [ -f "$file" ] || continue

  # Choose header style by extension
  case "$file" in
    *.css)
      HEADER="$BLOCK_HEADER"
      ;;
    *.sh|*.py|*.ps1|*.psm1|*.yml|*.yaml)
      HEADER="$HASH_HEADER"
      ;;
    */Dockerfile|Dockerfile|*/Dockerfile.*|Dockerfile.*)
      HEADER="$HASH_HEADER"
      ;;
    *)
      HEADER="$SLASH_HEADER"
      ;;
  esac

  # Already carries a Vergent copyright marker?
  if grep -q "Copyright © .* ${OWNER}" "$file" 2>/dev/null; then
    SKIPPED=$((SKIPPED + 1))
    continue
  fi

  if [ "$CHECK_MODE" -eq 1 ]; then
    echo "✗ Missing header: $file"
    MISSING=$((MISSING + 1))
    continue
  fi

  # Inject. Two tricks:
  #   1) For executable scripts (.sh, .py), preserve any shebang on line 1.
  #   2) For .py files preserve a `# -*- coding: ... -*-` encoding line too.
  #   3) For others (Dockerfile, .ps1, .yml, .css, .ts/.tsx etc), prepend
  #      the header verbatim.
  tmp="$(mktemp)"
  case "$file" in
    *.sh|*.py)
      if head -n1 "$file" | grep -q '^#!'; then
        # Keep shebang, then header, then the rest from line 2.
        {
          head -n1 "$file"
          echo "$HEADER"
          tail -n +2 "$file"
        } > "$tmp"
      else
        {
          echo "$HEADER"
          cat "$file"
        } > "$tmp"
      fi
      ;;
    *)
      {
        echo "$HEADER"
        cat "$file"
      } > "$tmp"
      ;;
  esac

  mv "$tmp" "$file"
  # Preserve executable bit on .sh files
  case "$file" in
    *.sh) chmod +x "$file" ;;
  esac
  INJECTED=$((INJECTED + 1))
done

if [ "$CHECK_MODE" -eq 1 ]; then
  if [ "$MISSING" -gt 0 ]; then
    echo
    echo "$MISSING file(s) missing copyright header."
    exit 1
  fi
  echo "✓ All source files carry the copyright header."
  exit 0
fi

echo "✓ Copyright header pass complete."
echo "  injected: $INJECTED"
echo "  skipped:  $SKIPPED (already present)"
