# /end - End Session

Save context for next session.

## Instructions

### 1. Summarize (brief)
- What was worked on (2-4 bullets)
- Any decisions made
- What's next

### 2. Save Session Log
Append to `sessions/{TODAY}.md`:
```markdown
## Session End: {TIME}

### Worked On
- {bullet points}

### Decisions
- {any decisions made, or "None"}

### Next
- {what to pick up next time}
```

### 3. Update State
Update `state/current.md` if anything material changed:
- New priorities or completed items
- Changed status on any thread

Update `state/goals.md` with any progress on goals.

### 4. Confirm
"Session saved. {one-line summary of state}."
