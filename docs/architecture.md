# The Guide: Architecture

## Three Primitives

Everything in The Guide derives from three primitives:

**1. Specialist** -- A self-contained knowledge container (agent definition + optional state). Carries domain expertise so the orchestrator doesn't have to. Invoked as subagent. Stateless per invocation (reads fresh each spawn).

**2. State File** -- Persistent file with a freshness contract (how often updated, when loaded). Survives sessions and compaction. Source of truth for continuity.

**3. Plan** -- Implementation spec with dependency graph and success criteria. Gates execution through specialist relay. Critic-reviewed before implementation.

## Two Configurations

### Mini Guide (Lightweight)

Target user: marketer, journalist, small business owner, freelancer. Someone who wants an AI thinking partner with personality, not just a chatbot.

- **CLAUDE.md:** ~60 lines. Core rules, user profile (fill-in template), condensed personality, condensed philosophy.
- **Startup:** ~800-1,500 tokens. Date + current.md + session log tail.
- **4 specialists:** Creator (builds/writes), Critic (reviews), Strategist (plans/analyzes), Researcher (finds/verifies).
- **Relay:** 4 stages. Creator implements -> Critic reviews -> Creator fixes -> Report.
- **Integrations:** Gmail + Calendar (optional). No Dreams, no social media, no database.
- **State:** current.md + goals.md + session logs + plans.
- **Runs on:** MiniMax M2.7 ($0.30/1M tokens), Claude Haiku, Gemini Flash.

### Complete Guide (Full System)

Target user: technical founder, operator, or team lead running a complex business through an AI chief of staff.

- **CLAUDE.md:** Layered. Core (~50 lines always) + personality (rules/, always) + philosophy (rules/, plan work only) + email voice (rules/, client work only).
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
6. Plans critic-reviewed before relay execution
7. CLAUDE.md core layer under 60 lines
8. Startup loads only what the current task requires

## Progressive Disclosure

Context loads in tiers:

| Tier | What | When | Token Cost |
|------|------|------|-----------|
| 0 | CLAUDE.md core (rules, profile, commands) | Every message | ~500-900 |
| 1 | Personality, integrations (.claude/rules/, no paths) | Session start | ~600 |
| 2 | Philosophy, email voice (.claude/rules/, path-scoped) | When working on matching files | ~120-715 |
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

## Research Foundation

Architecture decisions informed by research across 6 domains (100+ sources, March 2026):
- Memory architecture (Letta, Mem0, Zep, MemGPT)
- Context optimization (progressive disclosure, prompt caching)
- Multi-model orchestration (Claude Code Router, OpenRouter)
- Specialist routing (CrewAI, LangGraph, AutoGen, Google/MIT scaling research)
- CLAUDE.md best practices (Anthropic docs, community patterns)
- Hooks system (25 events, progressive disclosure via InstructionsLoaded)
