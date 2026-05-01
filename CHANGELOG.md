# Changelog

All notable changes to architect-claude-plugin are documented here.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/). Versioning: [Semantic Versioning](https://semver.org/).

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
