# /relay - Execute Plan Through Specialists

Run an approved plan through the specialist pipeline.

## Instructions

### Prerequisites
- A plan must exist in `plans/` and be approved by the user
- Read the plan file first

### Stage 1: Creator Implements
Spawn the Creator agent with the plan. Pass:
- The full plan content
- Any relevant files to read
- Clear success criteria

### Stage 2: Critic Reviews
Spawn the Critic agent with the Creator's output. The Critic reviews cold-eyes (does NOT read the plan first).

### Stage 3: Creator Fixes
If the Critic found CRITICAL or WARNING issues, spawn the Creator again with:
- The original plan
- The Critic's review
- Instructions to fix flagged issues only

### Stage 4: Report
Present to the user:
- What was built
- What the Critic found
- What was fixed
- Any remaining items

If no CRITICAL/WARNING issues were found in Stage 2, skip Stage 3 and report directly.
