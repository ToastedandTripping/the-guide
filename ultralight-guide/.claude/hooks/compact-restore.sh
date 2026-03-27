#!/usr/bin/env bash
set -euo pipefail

SESSION_ID=$(echo "$1" | python3 -c "import sys,json; print(json.load(sys.stdin).get('session_id',''))" 2>/dev/null || true)
[[ -z "$SESSION_ID" ]] && exit 0

TMPFILE="/tmp/guide-ultra-${SESSION_ID}.md"
[[ -f "$TMPFILE" ]] && { cat "$TMPFILE"; rm -f "$TMPFILE"; }

exit 0
