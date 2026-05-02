# Changelog

All notable changes to architect are documented here.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versioning: [Semantic Versioning](https://semver.org/).

---

## [3.0.2] — 2026-05-02

### Added

**24 worked examples — `references/examples/`**
- Full ACME Corp Customer Onboarding Modernisation scenario instantiated end-to-end across all 23 skills
- Preliminary: `11.01` Architecture Principles (6 principles, 4-field template), `11.02` Request for Architecture Work
- Phase A: `12.01` Statement of Architecture Work (§7.6, 9 clauses)
- Phase B: `21.01` Business Capabilities Catalog (20 capabilities, CMMI 0–4), `13.01` Architecture Requirements Specification (§7.11, 9 sections)
- Phase C: `22.01` Data Architecture (DAMA-DMBOK, GDPR, 5 domains), `22.02` Data Pipeline Review (S3→SQS→Lambda→Document AI→KYC), `23.01` Integration Architecture (7 integration points, EIP anti-patterns), `31.01` Trade-off Analysis (BPM vs Kafka vs Step Functions)
- Phase D: `24.01` Technology Architecture (12 components, 6 anti-patterns, cost model)
- Phase E: `51.01` Gap Analysis (7 domains, 15 gaps, TOGAF matrix, dependency DAG), `31.02` Architecture Decision Record (MADR with weighted matrix)
- Phase F: `52.01` Migration Plan (strangler-fig, 6Rs for 7 workloads, 3 Transition Architectures, rollback playbooks)
- Phase G: `71.01` Architecture Contract (§7.18), `71.02` Compliance Assessment (8 categories), `71.03` Change Management (Phase H, CR-2025-008, Major classification)
- Validate: `61.01` Principles Check, `61.02` Architecture Review (12-item fix list), `61.03` Risk Radar (10-risk RAID log, bow-tie), `61.04` Artifact Completeness
- Communicate: `41.01` Executive Summary (Pyramid Principle, Before/After), `41.02` Stakeholder Communication (CISO briefing, Before/After)
- Route/Scaffold: `81.01` Architect Router (two routing interactions), `82.01` New Architecture Document (Phase D scaffold with guiding questions)
- All 23 `SKILL.md` files updated with `[!tip]` callouts citing their worked example
- Files named using **Johnny Decimal** nomenclature (`AA.NN-description.md`) — area numbers map to ADM phases (10s = Preliminary/A, 20s = B/C, 30s = Decide, 40s = Communicate, 50s = E/F, 60s = Validate, 70s = Govern, 80s = Route/Scaffold)

### Changed
- `tests/validate-skills.sh` — added reference integrity section: checks for stale `example-*.md` paths, verifies all SKILL.md citations resolve, verifies all index-file links resolve, detects orphan example files not listed in the index

---

## [3.0.1] — 2026-05-01

### Fixed — TOGAF 10 fidelity (source: TOGAF Standard 10th Edition Pocket Guide G220)

**P1 — Factual corrections**
- `artifact-completeness`: Phase C (Data) diagram list replaced "Class Diagram" (UML, not TOGAF) with the canonical set: Conceptual Data Diagram, Logical Data Diagram, Data Dissemination Diagram, Data Security Diagram, Data Migration Diagram, Data Lifecycle Diagram
- `migration-plan`: description now names both Phase E (Opportunities & Solutions) and Phase F (Migration Planning) explicitly; added `## Phase E vs Phase F Outputs` section mapping skill outputs to the correct ADM phase
- `capability-assessment`, `data-architecture`, `integration-architecture`: removed brittle hard counts ("TOGAF defines N catalogs/matrices/diagrams") — replaced with non-counted canonical phrasing citing the TOGAF Architecture Content reference
- `preliminary`, `principles-check`: replaced "TOGAF Table 56" references with "TOGAF Architecture Principle quality criteria" — table numbering is not stable across TOGAF 10 editions; the five criteria (Complete/Robust/Understandable/Consistent/Stable) remain authoritative

**P2 — Practitioner overlay labelling**
- Added `> [!info] Practitioner overlay — not TOGAF-native` callouts to all skills that use non-TOGAF frameworks: CMMI 0–4 maturity (`gap-analysis`, `capability-assessment`), PROVIDED/INTEGRATED/GOVERNED ownership model (`capability-assessment`), 6R Disposition Model and Migration Patterns (`migration-plan`), ISO 31000 4T and FAIR (`risk-radar`), Mendelow Power × Interest grid (`stakeholder-communication`), ATAM sensitivity/tradeoff mapping (`architecture-review`), MADR format and DACI model (`adr-generator`)
- Added inline attribution for Pyramid Principle (Minto/McKinsey) and SCQA (`executive-summary`, `stakeholder-communication`)
- `compliance-review`: added note that the 3-level Compliant/Partial/Non-Compliant status taxonomy is practitioner shorthand; the TOGAF Architecture Capability series guide defines a 6-level scale — map on request

**P3 — Coherence**
- `architecture-vision`: changed initial capability scan from 1–5 to 0–4 scale (consistent with `capability-assessment` and `gap-analysis`)
- Added `references/togaf-content-framework.md` — canonical Catalogs, Matrices, and Diagrams per ADM phase (B/C-Data/C-App/D), single source of truth for artefact lists
- Added `references/scoring-conventions.md` — canonical scoring scales (capability maturity 0–4, decision matrix 1–5, risk P×I, compliance status)
- Extended `tests/validate-skills.sh` with semantic TOGAF fidelity checks: rejects "Class Diagram" in artifact-completeness, forbids hard artefact count assertions, requires migration-plan to name both Phase E and Phase F, requires practitioner overlay callouts in all overlay-using skills

---

## [3.0.0] — 2026-05-01

### Added

**Full TOGAF ADM coverage — Tier 1 (specification)**
- `preliminary` skill — Architecture Principles (Name/Statement/Rationale/Implications), Tailored Architecture Framework, Organizational Model for EA, Request for Architecture Work
- `architecture-vision` skill — Phase A Statement of Architecture Work, Architecture Vision, Stakeholder Map (Power/Interest), Communications Plan, initial Capability Assessment
- `requirements-management` skill — continuous Requirements Impact Assessments, Architecture Requirements Repository updates, traceability matrix across all ADM phases
- `implementation-governance` skill — Phase G Architecture Contracts, 8-category TOGAF Compliance Assessments (Hardware/OS, Software/middleware, Applications, Information mgmt, Security, System mgmt, System engineering, Methods/tools), dispensation and exception log
- `change-management` skill — Phase H change classification (simplification / incremental / re-architecting), Requirements Impact Assessment, Architecture Repository update log, new ADM cycle trigger

**Validation track — Tier 2**
- `compliance-review` skill — TOGAF Architecture Compliance Assessment with Architecture Board verdict (Approve / Approve with Conditions / Reject), 8-category scorecard, dispensation recommendations
- `principles-check` skill — two-mode skill: (1) validate a document against Architecture Principles, (2) audit the principles themselves against TOGAF Table 56 quality criteria (Completeness, Robustness, Understandability, Consistency, Stability)
- `artifact-completeness` skill — score an artifact against its canonical TOGAF template; checks required Catalogs, Matrices, and Diagrams per the Architecture Content Framework for ADD, ARS, Architecture Roadmap, Transition Architecture, and Implementation & Migration Plan

**Routing and chaining**
- `architect-router` skill — entry-point dispatcher that detects ADM phase and intent (specifying vs validating) and recommends the right downstream skill; includes a full routing map across specification, validation, and decision tracks
- `## Next Step` section added to all skills — each skill declares its downstream chaining targets (next phase, validation gate, decision capture, communication)

### Changed
- Validator (`tests/validate-skills.sh`) — replaced hardcoded `SKILLS=()` array with dynamic `mapfile`-based discovery from the `skills/` directory; adding a new skill no longer requires patching the validator. Added `## Next Step` to required section checks.
- README — replaced two workflow diagrams with three: Specification Track (full ADM Preliminary–F with Requirements Management), Validation & Governance Track (artifact → Architecture Board → Phase G/H), and Routing Quick Reference (architect-router decision tree). Added Govern section to skills table. Updated TOGAF ADM Phase Mapping to include all phases.
- `CLAUDE.md` — added Govern category skill table
- All 14 existing skills — refreshed `description` frontmatter for stronger auto-invocation (action verb + trigger phrases); appended `## Next Step` chaining block

---

## [2.0.0] — 2025-05-01

### Added
- **Output Discipline** — four mandatory accountability markers enforced across all 12 skills: confidence markers (`[proven]` / `[informed estimate]` / `[working hypothesis]`), reversibility tags (one-way / two-way door), named owner + review trigger, and Broad Responsibility line
- **Standards Bar** — every skill output closes with an explicit client-deliverable quality check
- **CI validation** (`tests/validate-skills.sh`) — enforces Output Discipline rules, Core Mindset postures, and frontmatter presence across all skills
- **`.claude-plugin/plugin.json`** — standard plugin manifest
- **When NOT to Use** section in README — explicit scope boundaries
- **Troubleshooting** section in README — five common failure modes with fixes

### Changed
- All 12 skills updated with Output Discipline section and enhanced output format tables

---

## [1.4.0] — 2025-04-01

### Added
- `data-pipeline-review` skill — pipeline pattern vs SLA fitness, idempotency, lineage, observability
- `integration-architecture` skill — topology fitness, contract governance, reliability patterns, anti-pattern detection
- `new-arch-doc` skill — TOGAF phase document scaffolding (A–D) and framework-agnostic proposals

### Changed
- README updated with Architect Workflow tracks (Operational SI, Decisional SI) and TOGAF ADM phase mapping

---

## [1.0.0] — 2025-01-01

### Added
- Initial release with core skills: `architecture-review`, `gap-analysis`, `risk-radar`, `data-architecture`, `trade-off-analysis`, `migration-plan`, `adr-generator`, `executive-summary`, `stakeholder-communication`
- TOGAF-aware mode with framework-agnostic fallback across all skills
- Core Mindset postures: Working Backwards, Three Horizons, Commoditisation Pressure, Innovation Pressure, Bold Needs Evidence, Second-Order Effects, Highest Standards
