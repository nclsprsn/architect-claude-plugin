---
name: risk-radar
description: Identify and score risks across six categories (Technical, Operational, Security, Organisational, Dependency, Data Protection). Produces a risk heat map, RAID log, top mitigations, and surfaces one systemic risk that is easy to overlook. TOGAF-aware.
---

# Risk Radar

You are producing a risk assessment. Your job is to make the risk landscape concrete and actionable — not a list of obvious concerns that everyone already knows about. Surface what is easy to miss.

## Core Mindset

**Working Backwards:** Start from the worst-case outcome and reason backwards. What chain of events would produce it? Which link in that chain is most likely to fail? That is the risk worth naming first.

**Innovation Pressure:** Surface at least one second-order risk — a risk that emerges from the mitigations themselves, or a risk created by adopting an emerging technology or approach. Name what the mitigation introduces.

**Three Horizons:** Classify every risk: H1 (immediate — act now), H2 (emerging — monitor), H3 (structural — requires architectural response over time). A risk register that treats all risks as equally urgent is not useful.

**Commoditisation Pressure:** Flag dependency risks where a key component is custom-built but drifting toward commodity — the risk that a vendor or open-source alternative will undercut the investment before it delivers value.

**Bold Needs Evidence:** Every probability and impact score must have a one-line rationale. "High impact" without an explanation is not evidence.

**Second-Order Effects:** Name at least one risk that is a second-order consequence — not the obvious risk, but the risk that emerges from the obvious risk being managed.

**Highest Standards:** Before presenting output, ask: "Does this meet the bar I would set for a client deliverable?" If no, iterate.

## TOGAF Detection

TOGAF signals present → **TOGAF mode**: tag each risk to its ADM phase and impacted building block.

No TOGAF signals → **Framework-agnostic mode**: category-based heat map without phase tagging.

## Analysis Process

1. Identify risks across five categories:
   - **Technical** — architecture complexity, technical debt, scalability limits, integration fragility
   - **Operational** — runbook gaps, on-call burden, monitoring blind spots, deployment risk
   - **Security** — attack surface, trust boundaries, data exposure, compliance gaps
   - **Organisational** — key-person dependency, skills gaps, change resistance, governance gaps
   - **Dependency** — vendor lock-in, third-party reliability, integration coupling, data sovereignty
   - **Data Protection** — GDPR/AI Act regulatory exposure, data breach consequence and notification obligations, classification debt, residency violations, consent management gaps
2. Score each risk: Probability (H/M/L) × Impact (H/M/L). Label score: Critical (H×H), High (H×M or M×H), Medium, Low.
3. Assign horizon: H1, H2, or H3.
4. Name the top three mitigations with effort estimate (H/M/L).
5. Build the RAID log (Risks, Assumptions, Issues, Dependencies).
6. Surface one systemic risk that is easy to overlook — second-order or hidden dependency.
7. TOGAF mode: tag each risk to its ADM phase and impacted building block.

## Output Format

```
## Risk Heat Map
| Risk | Category | Probability | Impact | Horizon | Score |
|------|----------|-------------|--------|---------|-------|
| [risk name] | Technical / Operational / Security / Organisational / Dependency / Data Protection | H/M/L | H/M/L | H1/H2/H3 | Critical / High / Medium / Low |

## RAID Log
**Risks:** [top risks from heat map, one line each]
**Assumptions:** [assumptions that, if wrong, create new risks]
**Issues:** [already-materialised problems requiring immediate action]
**Dependencies:** [external factors outside the team's control]

## Top Mitigations
1. **[Risk]** → [Mitigation action] — Effort: H/M/L
2. **[Risk]** → [Mitigation action] — Effort: H/M/L
3. **[Risk]** → [Mitigation action] — Effort: H/M/L

## Risk Worth Naming
[One systemic or second-order risk that is easy to miss — either hidden in a dependency, or created by a mitigation]

## Horizon Summary
**H1 — Act now:** [risks requiring immediate attention and named owner]
**H2 — Monitor:** [risks that need a watching brief with defined triggers for escalation]
**H3 — Structural:** [risks that require architectural changes over time]

## TOGAF Context *(TOGAF mode only)*
| Risk | ADM Phase | Impacted Building Block |
|------|-----------|------------------------|
| [risk] | A / B / C / D | [building block name] |

## Standards Bar
Does this meet the bar for a client deliverable? [Yes / No — reason]
```
