#!/usr/bin/env bash
# Post-compact context restore
# Reads saved context and injects it back after compaction

set -euo pipefail

SESSION_ID=$(echo "$1" | python3 -c "import sys,json; print(json.load(sys.stdin).get('session_id',''))" 2>/dev/null || true)
[[ -z "$SESSION_ID" ]] && exit 0

TMPFILE="/tmp/guide-compact-context-${SESSION_ID}.md"

if [[ -f "$TMPFILE" ]]; then
    cat "$TMPFILE"
    rm -f "$TMPFILE"
fi

exit 0
