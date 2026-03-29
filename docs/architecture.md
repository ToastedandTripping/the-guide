# The Guide: Architecture

## Three Primitives

Everything in The Guide derives from three primitives:

**1. Specialist** -- A self-contained knowledge container (agent definition + optional state). Carries domain expertise so the orchestrator doesn't have to. Invoked as subagent. Stateless per invocation (reads fresh each spawn).

**2. State File** -- Persistent file with a freshness contract (how often updated, when loaded). Survives sessions and compaction. Source of truth for continuity.

**3. Plan** -- Implementation spec with dependency graph and success criteria. Gates execution through specialist relay. Stress-tested before implementation.

## Two Configurations

### Mini Guide (Lightweight)

Target user: marketer, journalist, small business owner, freelancer. Someone who wants an AI thinking partner with personality, not just a chatbot.

- **CLAUDE.md:** ~60 lines. Core rules, pre-action gates, user profile (fill-in template), condensed personality, condensed philosophy.
- **Startup:** ~800-1,500 tokens. Date + current.md + session log tail.
- **4 specialists:** Creator (builds/writes), Critic (reviews), Strategist (plans/analyzes), Researcher (finds/verifies).
- **Relay:** 4 stages. Creator implements -> Critic reviews -> Creator fixes -> Report.
- **Integrations:** Gmail + Calendar (optional). No Dreams, no social media, no database.
- **State:** current.md + goals.md + session logs + plans.
- **Runs on:** MiniMax M2.7 ($0.30/1M tokens), Claude Haiku, Gemini Flash.

### Complete Guide (Full System)

Target user: technical founder, operator, or team lead running a complex business through an AI chief of staff.

- **CLAUDE.md:** Core rules + pre-action gates (~30 lines, always loaded) + user profile + session flow. Behavioral rules that gate actions are inline. Reference material (detailed voice guides, integration docs) stays in rules/ and memory files.
- **Rules files:** Personality (always loaded), philosophy (plan-work scoped), integration reference (always loaded).
- **Startup:** ~2,800-8,500 tokens depending on session type.
- **16+ specialists:** Domain experts (engineering, law, finance, HR, sales, design, etc.) plus relay trio (Builder, Reviewer, Designer).
- **Relay:** 8 stages with architecture alignment, design specs, fidelity gates.
- **Integrations:** Gmail, Calendar, Vestige memory, Dreams overnight research, social media, browser automation, database.
- **State:** current.md + goals.md + follow-ups.json + invoices.json + recurring-tasks.json + session logs + plans.
- **Runs on:** Claude Opus/Sonnet (personality and nuance require frontier models).

## Invariants (Both Configurations)

1. No unauthorized actions without explicit approval
2. No fabricated data
3. Specialists stateless per invocation
4. Work returns to orchestrator between relay stages
5. State files are source of truth for session continuity
6. Plans stress-tested before relay execution
7. Behavioral rules inline in CLAUDE.md; reference material in files
8. Startup loads only what the current task requires

## Inline vs Pointer: The Compliance Rule

**Hard-won lesson:** LLMs follow direct commands in CLAUDE.md far more reliably than pointers to other files. "No em dashes" works. "Read file X which tells you not to use em dashes" doesn't. The pointer adds a step that gets skipped.

**The principle:** If a rule gates an action (do this BEFORE doing that), it must be inline in CLAUDE.md. If a rule is reference material (the full list of voice guidelines, command syntax, integration details), it can live in a file.

**Why not put everything inline?** Once CLAUDE.md gets too long, rules at the bottom get less attention. There's a sweet spot: critical rules and pre-action gates in the first 30 lines, everything else either in always-loaded rules files or on-demand reference.

**What belongs inline:**
- Don'ts (critical rules: never fabricate, never send unauthorized)
- Pre-action gates (before email: do X. Before deploy: do Y.)
- Tool selection rules (use gws to send, not MCP)

**What belongs in files:**
- Personality voice and examples
- Philosophy and adversarial collaboration details
- Detailed formatting guides
- Integration command references
- Domain-specific knowledge

## Progressive Disclosure

Context loads in tiers:

| Tier | What | When | Token Cost |
|------|------|------|-----------|
| 0 | CLAUDE.md (rules, gates, profile, commands) | Every message | ~700-1,000 |
| 1 | Personality, integration reference (.claude/rules/, no paths) | Session start | ~600 |
| 2 | Philosophy (.claude/rules/, path-scoped) | When working on matching files | ~400 |
| 3 | State files, specialist knowledge | On-demand | Variable |

Uses Claude Code native mechanisms:
- `.claude/rules/` with `paths:` frontmatter for conditional loading
- Subdirectory CLAUDE.md files for lazy loading
- `InstructionsLoaded` hook for audit/verification

## The Upgrade Path

Mini Guide -> Complete Guide by additive changes only:

```
Mini Guide
  + Expand personality (15 lines -> 28 lines)
  + Expand philosophy (10 lines -> 33 lines, move to path-scoped rules/)
  + Add domain specialists (4 -> 16+)
  + Add relay stages (4 -> 8)
  + Add state files (2 -> 5)
  + Add Dreams overnight research
  + Add integrations (social, browser, DB)
  + Add hooks (auto-pdf, relay-preflight, etc.)
= Complete Guide
```

Nothing breaks going up. Same plan format, same hooks, same state file conventions.

## Model Compatibility

| Tier | Models | Why |
|------|--------|-----|
| Mini Guide | MiniMax M2.7, Haiku 4.5, Gemini Flash | Explicit, linear instructions. No nuanced personality interpretation needed. |
| Complete Guide | Opus 4.6, Sonnet 4.6 | Personality voice, adversarial collaboration, and complex multi-step reasoning require frontier capability. |
| Hybrid routing | Opus for planning + M2.7 for execution | Claude Code Router enables task-type routing within a single session. |

System prompts do NOT port across model tiers. Mini Guide instructions are purpose-built for cheap models (explicit ordering, no nested conditionals, repeated format instructions). Complete Guide instructions assume frontier-model nuance.

## Self-Correcting Architecture (v2, March 2026)

v1 depended on LLM compliance for ~20% of its rules. v2 shifts to mechanical enforcement with observability.

### Hook-First Enforcement

13 hooks across 6 event types. Enforcement hooks block actions that violate rules (exit code 0 with deny JSON). Advisory hooks warn via stderr.

| Hook | Event | Type | What It Does |
|------|-------|------|-------------|
| plan-gate | PreToolUse/ExitPlanMode | Enforce | Blocks exit unless plan has `stress-tested` marker |
| plan-mode-inject | PreToolUse/EnterPlanMode | Inject | Injects 5-phase workflow into context |
| loop-detect | PreToolUse/* | Enforce | Blocks 3+ identical tool calls in last 5 |
| git-safety | PreToolUse/Bash | Enforce | Blocks commits/merges to main, force pushes |
| email-compliance | PreToolUse/Bash | Enforce | Blocks multi-recipient without BCC, warns on non-HTML |
| relay-preflight | PreToolUse/Agent | Warn | Architecture doc reminder + context depth check |
| compliance-patterns | SessionStart | Report | Cross-session violation trends + escalation recommendations |
| session-quality | SessionEnd | Report | Compliance scorecard to state/compliance/{date}.json |
| pre-compact-save | PreCompact | Auto | Saves state + relay progress + compliance count |
| post-compact-restore | SessionStart/compact | Auto | Restores context after compaction |
| refresh-google-token | SessionStart | Auto | OAuth token refresh |
| auto-pdf | PostToolUse/Write,Edit | Auto | Branded PDF generation for content files |
| notify-desktop | Notification | Auto | Desktop notifications for task completion |

### Compliance Feedback Loop

```
Hooks enforce → JSONL logs events → session-quality scores at end
→ compliance-patterns surfaces trends at start → escalation when patterns recur
```

When a rule is violated 5+ times across sessions, the system recommends escalating from advisory to hook.

### Relay Complexity Tiers

| Tier | Criteria | Strategy |
|------|----------|----------|
| Simple | 1-3 files, isolated | Ted → Razor → Report |
| Standard | 4-10 files, bounded | Ted → Razor → Fix → Jen (if UI) → Report → Archive |
| Complex | 10+ files, visual precision | Jen spec → Ted (batched) → Razor per batch → Jen review → Report → Archive |
| Architectural | New primitives, composition changes | Architect review → Jen spec → Ted (batched) → Razor → Jen → Architecture update |

Complex/Architectural tiers use **batched implementation**: MARVIN breaks the plan into batches from the dependency graph. Ted implements one batch at a time with Razor review between batches. This prevents context exhaustion and preserves visual/rendering nuance.

**Stage 0.7 (Jen Visual Spec):** For plans requiring visual precision, Jen produces an exact specification before Ted implements — opacity tables, color hex codes, spacing in px/rem, transition timing. Ted builds to the spec. Jen reviews against her own spec at Stage 3 (fidelity gate).

## Research Foundation

Architecture decisions informed by research across 7 domains (100+ sources, March 2026):
- Memory architecture (Letta, Mem0, Zep, MemGPT)
- Context optimization (progressive disclosure, prompt caching)
- Multi-model orchestration (Claude Code Router, OpenRouter)
- Specialist routing (CrewAI, LangGraph, AutoGen, Google/MIT scaling research)
- CLAUDE.md best practices (Anthropic docs, community patterns)
- Hooks system (25 events, progressive disclosure via InstructionsLoaded)
- **Inline vs pointer compliance** (empirical finding, March 2026: behavioral rules in pointers get skipped ~80% of the time)
- **Self-correcting enforcement** (empirical: mechanical hooks reduce violation rate from ~20% to <5%)
