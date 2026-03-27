# The Guide

A two-tier AI Chief of Staff architecture for Claude Code.

**Complete Guide** -- full-featured orchestrator with 16+ specialists, overnight research, Gmail/Calendar integration, and personality-driven collaboration. Runs on frontier models (Claude Opus, Sonnet).

**Mini Guide** -- lightweight AI thinking partner with 4 specialists, planning, and basic productivity integrations. Designed for non-technical users. Runs on cost-effective models (MiniMax M2.7, Claude Haiku, Gemini Flash).

Both configurations share the same three primitives (Specialist, State File, Plan) and the same upgrade path. Mini Guide is a strict subset of Complete Guide -- upgrading is additive, never breaking.

## Quick Start (Mini Guide)

1. Copy `mini-guide/` to your project
2. Edit `CLAUDE.md` -- fill in your profile (name, role, style)
3. Optionally configure Gmail/Calendar MCP
4. Run `claude` and type `/start`

## Architecture

See `docs/architecture.md` for the full conceptual model, primitives, composition rules, and upgrade path.

## Structure

```
the-guide/
  mini-guide/          # Standalone lightweight template
  complete-guide/      # Reference architecture (MARVIN patterns)
  docs/
    architecture.md    # Conceptual model and design decisions
    research/          # Research foundation (100+ sources)
```

## Naming

Named after The Hitchhiker's Guide to the Galaxy. The system that knows where your towel is.
