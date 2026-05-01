# architect-claude

A Claude Code plugin for Enterprise Architects and Solution Architects.

Four skills and slash commands for architecture review, decision support, stakeholder communication, and document scaffolding. TOGAF-aware by default, framework-agnostic fallback.

## Install

```bash
claude plugin install gh:nclsprsn/architect-claude
```

## Skills & Commands

| Command | Skill | What it does |
|---------|-------|-------------|
| `/architecture-review [path]` | `architecture-review` | Chief architect critique: quality attributes, assumption stress-test, disruptive alternative, second-order effects |
| `/trade-off-analysis [context]` | `trade-off-analysis` | Evaluate 2–3 options → clear recommendation → ADR-ready output |
| `/executive-summary [path]` | `executive-summary` | Rewrite technical doc for C-level: Pyramid Principle, business implications, numbered claims |
| `/new-arch-doc [phase]` | `new-arch-doc` | Scaffold TOGAF phase document (A–D) or framework-agnostic proposal |

## Core Posture

Every skill operates from the same architect mindset:

- **Work backwards** from the business outcome — never forward from the technology
- **Surface a disruptive alternative** that questions whether the problem was framed correctly
- **Name the horizon** — H1 optimise core / H2 scale emerging / H3 seed disruptive
- **Apply the commoditisation curve** — never custom-build a commodity
- **Anchor every claim** with a number or first-principles reasoning
- **Name second-order effects** — at least one non-obvious downstream consequence per output
- **Highest Standards** — every output closes with a client-deliverable quality check

## TOGAF Default

TOGAF vocabulary (ADM phases, building blocks, gap analysis) is active by default. If your project does not use TOGAF, the skills degrade gracefully to framework-agnostic mode — just don't mention TOGAF in your prompts.

## Examples

```
/architecture-review docs/platform-architecture.md
/trade-off-analysis API gateway selection for our microservices migration
/executive-summary docs/data-platform-proposal.md
/new-arch-doc phase-b
```

## License

MIT
