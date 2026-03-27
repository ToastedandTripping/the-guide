#!/usr/bin/env bash
# Plan gate: blocks ExitPlanMode unless a plan was saved
# Ensures plans are reviewed before implementation begins

set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
PLANS_DIR="$PROJECT_DIR/plans"

# Check if any plan was saved in the last 30 minutes
if [[ -d "$PLANS_DIR" ]]; then
    RECENT=$(find "$PLANS_DIR" -name "*.md" -mmin -30 2>/dev/null | head -1)
    if [[ -n "$RECENT" ]]; then
        exit 0
    fi
fi

echo "BLOCKED: No plan found in plans/ from the last 30 minutes. Save your plan before exiting plan mode." >&2
exit 2
