# The Guide

A three-tier AI Chief of Staff architecture for Claude Code. Pick the tier that fits your budget and needs -- upgrading is always additive, never breaking.

| Tier | Startup Tokens | Specialists | Runs On | For Who |
|------|---------------|-------------|---------|---------|
| **Ultralight** | <500 | 0 | Anything | Anyone who wants session continuity + personality at minimum cost |
| **Mini** | ~1,500 | 4 | MiniMax M2.7, Haiku, Gemini Flash | Non-technical users wanting a thinking partner |
| **Complete** | ~8,500 | 16+ | Claude Opus, Sonnet | Full AI chief of staff for complex operations |

## Quick Start

### Ultralight (5 minutes)
1. Copy `ultralight-guide/` to your project
2. Edit `CLAUDE.md` -- fill in your name, role, and current focus
3. Run `claude` and type `/start`

### Mini (10 minutes)
1. Copy `mini-guide/` to your project
2. Edit `CLAUDE.md` -- fill in your profile
3. Optionally configure Gmail/Calendar MCP
4. Run `claude` and type `/start`

## What You Get

**Ultralight** -- Session memory (never re-explain yourself) + personality (not a chatbot) + compaction safety (context survives long sessions). That's it. 20 lines of CLAUDE.md. The whole system costs less than a tweet's worth of tokens.

**Mini** -- Everything in Ultralight, plus 4 specialists (Creator, Critic, Strategist, Researcher), a relay pipeline for plan execution, state tracking (priorities + goals), and optional Gmail/Calendar integration.

**Complete** -- Everything in Mini, plus 16+ domain specialists, overnight research (Dreams), 8-stage relay with design fidelity gates, full business operations (invoicing, follow-ups, recurring tasks), and multi-model routing. Reference architecture documented in `complete-guide/`.

## Upgrade Path

```
Ultralight
  + Add specialists (0 -> 4)
  + Add relay pipeline
  + Add state files (1 -> 2)
  + Add plan-gate hook
= Mini Guide

Mini Guide
  + Add domain specialists (4 -> 16+)
  + Add relay stages (4 -> 8)
  + Add state files (2 -> 5)
  + Add Dreams overnight research
  + Add integrations (social, browser, DB)
  + Add hooks (auto-pdf, relay-preflight, etc.)
= Complete Guide
```

## Architecture

See `docs/architecture.md` for the conceptual model, three primitives (Specialist, State File, Plan), and design decisions.

## Naming

Named after The Hitchhiker's Guide to the Galaxy. The system that knows where your towel is.
