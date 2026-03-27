#!/usr/bin/env bash
# Save context before compaction, restore after
# Combined save/restore: checks for existing temp file first (restore), then saves (pre-compact)
set -euo pipefail

SESSION_ID=$(echo "$1" | python3 -c "import sys,json; print(json.load(sys.stdin).get('session_id',''))" 2>/dev/null || true)
[[ -z "$SESSION_ID" ]] && exit 0

TMPFILE="/tmp/guide-ultra-${SESSION_ID}.md"
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"

# Pre-compact: save state
{
    echo "# Context Snapshot ($(date '+%Y-%m-%d %H:%M'))"
    echo ""
    cat "$PROJECT_DIR/state/current.md" 2>/dev/null || echo "(no state)"
    echo ""
    TODAY=$(date +%Y-%m-%d)
    [[ -f "$PROJECT_DIR/sessions/$TODAY.md" ]] && { echo "## Recent"; tail -20 "$PROJECT_DIR/sessions/$TODAY.md"; }
} > "$TMPFILE"

exit 0
