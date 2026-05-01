---
name: new-arch-doc
description: Scaffold a new architecture document. TOGAF ADM phase-aware (Phase A–D) with domain selection. Framework-agnostic fallback. Every section pre-populated with guiding questions, "so what?" prompts, and horizon/confidence reminders.
---

# New Architecture Document

You are scaffolding a new architecture document. Your job is to create a complete, structured shell that guides the author towards a high-quality output — not a blank template with headings.

## Core Mindset (embed in the scaffold)

Every section of the generated document must include:
- A guiding question in italics that prompts the author to think, not just fill in text
- A "so what?" prompt reminding the author to state the business implication
- Where relevant: a reminder to name the horizon (H1 / H2 / H3) and confidence level (proven at scale / working hypothesis / emerging)

## TOGAF Detection

**TOGAF mode** (default — use when TOGAF signals present or no framework specified):
Use ADM phase structure. Ask which phase if not provided.

**Framework-agnostic mode** (when user explicitly says "no TOGAF" or names a different framework):
Use the generic architecture proposal template at the bottom of this skill.

## Information to Gather

Ask (or infer from context) before generating. Do not ask for anything already provided:

1. **ADM Phase** — if unknown, ask: *"Which ADM phase? A = Architecture Vision, B = Business Architecture, C = Information Systems (Data or Application), D = Technology Architecture"*
2. **Domain** — for Phase C: Data or Application; for Phase D: name the technology sub-domain
3. **Document title**
4. **Lead architect name**
5. **Key stakeholders**
6. **Horizon** — H1 (optimise core), H2 (scale emerging), H3 (seed disruptive)

## Frontmatter (always apply)

```yaml
---
title: [title]
created: [today's date YYYY-MM-DD]
status: Draft
phase: [ADM phase A/B/C/D or N/A]
lead_architect: [name]
stakeholders: [comma-separated list]
horizon: [H1 / H2 / H3]
tags: []
---
```

## Phase A — Architecture Vision

Generate this content for Phase A documents:

> [!important] So what?
> Every section must answer: what does this mean for the business? A section that describes technology without naming a business implication fails the "so what?" test.

## 1. Business Context
*What business problem or opportunity is this architecture addressing? Who is the customer, and what outcome do they need? Work backwards from the outcome — not forwards from the technology.*

## 2. Stakeholders & Concerns
*Who has a stake in this architecture? What does each stakeholder need to know, decide, or approve? What are their top concerns?*

## 3. Scope & Constraints
*What is in scope? What is explicitly out of scope? What constraints are non-negotiable (regulatory, budget, timeline, existing contracts)?*

## 4. Architecture Vision
*What does the target state look like in 3–5 years if assumptions hold — and if they don't? Name the horizon: H1 / H2 / H3.*
*Disruptive alternative: what would a bold version of this vision look like? Why might the conservative version be obsolete in 3 years?*

## 5. Gap Summary
*What is the distance between current state and target state? What are the top 3 gaps that must be closed?*

## 6. Risks & Assumptions
*What assumptions underlie this vision? State the primary assumption explicitly. What breaks — and how badly — if it is wrong?*
*Second-order effect: what downstream impact on other systems or teams is non-obvious?*

## 7. Next Steps
*What decisions need to be made, by whom, and by when? What would unblock progress?*

---

## Phase B — Business Architecture

Generate this content for Phase B documents:

> [!important] So what?
> Every section must answer: what does this mean for the business?

## 1. Baseline Business Architecture
*Describe the current state: capabilities, processes, organisational structures. What works? What is broken or at risk?*

## 2. Target Business Architecture
*Describe the target state working backwards from the business outcome. What capabilities must exist? Name the horizon: H1 / H2 / H3.*
*Disruptive alternative: what would the most ambitious version of this target architecture look like?*

## 3. Gap Analysis
| Capability / Process | Baseline | Target | Gap | Priority |
|----------------------|----------|--------|-----|----------|
| *[list each]* | *[current state]* | *[target state]* | *[what must change]* | High / Med / Low |

## 4. Roadmap
*What sequence of changes moves from baseline to target? What can be done in H1 vs H2 vs H3? What are the dependencies?*

## 5. Risks & Assumptions
*Primary assumption + failure scenario. Second-order effect: which team or system outside this scope will be affected?*

---

## Phase C — Information Systems Architecture

Generate this content for Phase C documents:

> [!important] So what?
> Every section must answer: what does this mean for the business?

## 1. Baseline [Data / Application] Architecture
*Current state: key data entities or application components, integration points, known problems. What is brittle? What is approaching end-of-life?*

## 2. Target [Data / Application] Architecture
*Target state working backwards from the business outcome. What capabilities does this unlock? Name the horizon: H1 / H2 / H3.*
*Disruptive alternative: is there an emerging approach (AI-native, event-driven, data mesh, etc.) that makes the current direction look conservative?*

## 3. Gap Analysis
| Component / Data Entity | Baseline | Target | Gap | Priority |
|-------------------------|----------|--------|-----|----------|
| *[list each]* | *[current]* | *[target]* | *[delta]* | High / Med / Low |

## 4. Interoperability
*How do components integrate? What are the interface contracts? What standards apply? Where are the integration risks?*

## 5. Risks & Assumptions
*Primary assumption + failure scenario. Commoditisation check: is anything being custom-built that is becoming a product?*

---

## Phase D — Technology Architecture

Generate this content for Phase D documents:

> [!important] So what?
> Every section must answer: what does this mean for the business?

## 1. Baseline Technology Architecture
*Current technology stack: platforms, infrastructure, tools. What is approaching end-of-life? What is locked-in? Where is the technical debt?*

## 2. Target Technology Architecture
*Target state. Apply the commoditisation curve to every technology choice: genesis / custom-built / product / utility. Flag anything being custom-built that is drifting toward commodity.*
*Disruptive alternative: what would a cloud-native, AI-native, or open-source version of this architecture look like?*

## 3. Gap Analysis
| Technology Component | Baseline | Target | Gap | Priority |
|----------------------|----------|--------|-----|----------|
| *[list each]* | *[current]* | *[target]* | *[delta]* | High / Med / Low |

## 4. Standards & Patterns
*What technology standards apply? What architecture patterns govern this layer? What must be consistent across components?*

## 5. Lock-in Surface
*Where is the lock-in? Is it intentional (strategic bet) or accidental (path dependency)? What is the exit strategy if the bet fails?*

## 6. Risks & Assumptions
*Primary assumption + failure scenario. Second-order effect: what downstream system or team will be impacted by technology choices made here?*

---

## Framework-Agnostic Template

Generate this content when not using TOGAF:

> [!important] So what?
> Every section must answer: what does this mean for the business?

## 1. Problem Statement
*What problem are we solving? For whom? What is the business outcome we are working backwards from? What happens if we do nothing?*

## 2. Options Considered
*What approaches were evaluated? Include at minimum: the obvious option, the conservative option, and one disruptive alternative that questions whether the problem was framed correctly.*

## 3. Recommendation
*What are we doing and why? Recommendation first (Pyramid Principle), justification second.*
*Confidence level: proven at scale / working hypothesis — validate with a spike / emerging — monitor.*

## 4. Quality Attribute Assessment
| Attribute | Assessment | Rationale |
|-----------|------------|-----------|
| Scalability | High / Med / Low | *[one-line rationale]* |
| Resilience | High / Med / Low | *[one-line rationale]* |
| Security | High / Med / Low | *[one-line rationale]* |
| Evolvability | High / Med / Low | *[one-line rationale]* |
| Cost Efficiency | High / Med / Low | *[one-line rationale]* |

## 5. Risks & Assumptions
*Primary assumption stated explicitly. Failure scenario if wrong. Second-order effect: one non-obvious downstream consequence.*

## 6. Decision Log
*Key decisions made during this document's creation. Why was each option rejected? ADR references if applicable.*
