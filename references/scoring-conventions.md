# Scoring Conventions

Canonical scoring scales used across all plugin skills. All skills must use the scales defined here — never introduce a different scale without updating this document.

---

## Capability Maturity Scale (0–4)

Used by: `gap-analysis`, `capability-assessment`, `architecture-vision` (initial scan), any skill that scores capability domains.

**Source:** Derived from CMMI (CMMI Institute). Not defined by the TOGAF standard — used as a practitioner overlay alongside TOGAF Phase B/C/D artefacts.

| Level | Name | What it means |
|-------|------|--------------|
| **0** | Not Defined | No awareness; not in any roadmap; capability does not exist |
| **1** | Initial | Exists but inconsistent; ad-hoc; manual; no repeatable process |
| **2** | Defined | Documented; repeatable; team follows a standard process |
| **3** | Managed | Monitored; metrics in place; automated where appropriate; SLAs defined |
| **4** | Optimised | Continuously improved; cost-tracked; feedback loops closing automatically |

RAG indicators for heat maps: 🔴 0–1 · 🟡 2 · 🟢 3–4

---

## Decision Matrix Scoring (1–5)

Used by: `trade-off-analysis`, `adr-generator` (weighted decision matrix only).

This scale scores options against criteria in a weighted decision matrix. It is distinct from the capability maturity scale — do not mix the two.

| Score | Meaning |
|-------|---------|
| **1** | Poor fit — criterion is not met |
| **2** | Weak fit — partial and unsatisfying |
| **3** | Acceptable — criterion is met with trade-offs |
| **4** | Good — criterion is well satisfied |
| **5** | Excellent — criterion is fully satisfied with positive second-order effects |

Weights: 1 = nice-to-have · 2 = important · 3 = critical.

---

## Risk Probability / Impact / Score

Used by: `risk-radar`.

- **Probability:** H = > 50% in horizon · M = 10–50% · L = < 10%
- **Impact:** H = material business disruption or regulatory breach · M = significant degradation · L = manageable
- **Score:** Critical (H×H) · High (H×M or M×H) · Medium (M×M or H×L or L×H) · Low (L×L or L×M or M×L)

---

## Compliance Conformance Status

Used by: `compliance-review`.

**3-level shorthand (default):** Compliant / Partial / Non-Compliant

**6-level scale (on request — TOGAF Architecture Capability series guide):** Irrelevant / Consistent / Compliant / Conformant / Fully Conformant / Non-conformant
