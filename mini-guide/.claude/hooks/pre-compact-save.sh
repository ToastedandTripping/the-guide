#!/usr/bin/env bash
# Pre-compact context save
# Saves current state to temp file before compaction

set -euo pipefail

SESSION_ID=$(echo "$1" | python3 -c "import sys,json; print(json.load(sys.stdin).get('session_id',''))" 2>/dev/null || true)
[[ -z "$SESSION_ID" ]] && exit 0

TMPFILE="/tmp/guide-compact-context-${SESSION_ID}.md"
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"

{
    echo "# Context Snapshot"
    echo "Saved: $(date '+%Y-%m-%d %H:%M')"
    echo ""
    echo "## Current State"
    cat "$PROJECT_DIR/state/current.md" 2>/dev/null || echo "(no current.md)"
    echo ""
    echo "## Recent Session"
    TODAY=$(date +%Y-%m-%d)
    SESSION_FILE="$PROJECT_DIR/sessions/$TODAY.md"
    [[ -f "$SESSION_FILE" ]] && tail -40 "$SESSION_FILE" || echo "(no session log today)"
} > "$TMPFILE"

exit 0
