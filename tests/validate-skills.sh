#!/usr/bin/env bash
set -euo pipefail

ERRORS=0
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

pass() { echo "  ✓ $1"; }
fail() { echo "  ✗ $1"; ERRORS=$((ERRORS + 1)); }

# Discover skills dynamically from the skills/ directory
mapfile -t SKILLS < <(ls -d "$REPO_ROOT/skills"/*/ 2>/dev/null | xargs -n1 basename | sort)

POSTURES=(
  "Working Backwards"
  "Innovation Pressure"
  "Three Horizons"
  "Commoditisation Pressure"
  "Bold Needs Evidence"
  "Second-Order Effects"
  "Highest Standards"
)

echo "=== Validating skill files ==="

for skill in "${SKILLS[@]}"; do
  echo ""
  echo "--- $skill ---"
  file="$REPO_ROOT/skills/$skill/SKILL.md"

  if [[ ! -f "$file" ]]; then
    fail "SKILL.md missing"
    continue
  fi
  pass "SKILL.md exists"

  # --- Frontmatter ---

  # File must start with ---
  if head -1 "$file" | grep -q "^---"; then
    pass "frontmatter present"
  else
    fail "missing YAML frontmatter (file must start with ---)"
  fi

  # Frontmatter must have name: and description: fields
  frontmatter=$(sed -n '2,/^---$/p' "$file")
  if echo "$frontmatter" | grep -q "^name:"; then
    pass "frontmatter: name field"
  else
    fail "frontmatter missing name: field"
  fi

  if echo "$frontmatter" | grep -q "^description:"; then
    pass "frontmatter: description field"
  else
    fail "frontmatter missing description: field"
  fi

  # --- Required sections ---

  for section in "## Core Mindset" "## TOGAF Detection" "## Information to Gather" "## Output Discipline" "## Standards Bar" "## Next Step"; do
    if grep -q "^${section}" "$file"; then
      pass "section: $section"
    else
      fail "missing section: $section"
    fi
  done

  # Artifact Selection Guide required for all skills except new-arch-doc (delegates to phase files)
  if [[ "$skill" != "new-arch-doc" ]]; then
    if grep -q "^## Artifact Selection Guide" "$file"; then
      pass "section: ## Artifact Selection Guide"
    else
      fail "missing section: ## Artifact Selection Guide"
    fi
  fi

  # --- TOGAF Detection branching ---

  for branch in "TOGAF mode" "Framework-agnostic mode"; do
    if grep -q "$branch" "$file"; then
      pass "togaf detection: $branch"
    else
      fail "togaf detection: missing '$branch'"
    fi
  done

  # --- Output Discipline: four rules ---

  for rule in "Confidence marker" "Reversibility tag" "Named owner" "Broad Responsibility"; do
    if grep -q "$rule" "$file"; then
      pass "output discipline: $rule"
    else
      fail "missing output discipline rule: $rule"
    fi
  done

  # Confidence levels: all three must be documented
  for level in "[proven]" "[informed estimate]" "[working hypothesis]"; do
    if grep -qF "$level" "$file"; then
      pass "confidence level: $level"
    else
      fail "missing confidence level: $level"
    fi
  done

  # Reversibility vocabulary: both labels must appear
  for label in "one-way door" "two-way door"; do
    if grep -q "$label" "$file"; then
      pass "reversibility: $label"
    else
      fail "missing reversibility label: $label"
    fi
  done

  # --- Information to Gather: batch questions discipline ---

  if grep -q "Batch all missing questions into a single message" "$file"; then
    pass "information: batch questions rule"
  else
    fail "information: missing batch questions rule"
  fi

  # --- Core Mindset postures ---

  for posture in "${POSTURES[@]}"; do
    if grep -q "$posture" "$file"; then
      pass "posture: $posture"
    else
      fail "missing posture: $posture"
    fi
  done

  # --- Standards Bar quality question ---

  if grep -q "Does this meet the bar" "$file"; then
    pass "standards bar: quality question present"
  else
    fail "standards bar: missing quality question"
  fi

  # --- Command wrapper ---

  cmd="$REPO_ROOT/commands/$skill.md"
  if [[ -f "$cmd" ]]; then
    pass "command wrapper exists"
  else
    fail "command wrapper missing: commands/$skill.md"
  fi

  # Command must reference the skill name
  if grep -q "$skill" "$cmd" 2>/dev/null; then
    pass "command references skill"
  else
    fail "command does not reference skill name"
  fi

  # Command wrapper must have description field
  if grep -q "^description:" "$cmd" 2>/dev/null; then
    pass "command: description field"
  else
    fail "command: missing description field"
  fi

done

echo ""
echo "=== Validating package.json ==="

pkg="$REPO_ROOT/package.json"
if [[ ! -f "$pkg" ]]; then
  fail "package.json missing"
else
  if node -e "JSON.parse(require('fs').readFileSync('$pkg','utf8'))" 2>/dev/null; then
    pass "package.json is valid JSON"
  else
    fail "package.json is invalid JSON"
  fi

  version=$(node -e "console.log(JSON.parse(require('fs').readFileSync('$pkg','utf8')).version)" 2>/dev/null || echo "")
  if [[ -n "$version" ]]; then
    pass "package.json has version: $version"
  else
    fail "package.json missing version field"
  fi

  name=$(node -e "console.log(JSON.parse(require('fs').readFileSync('$pkg','utf8')).name)" 2>/dev/null || echo "")
  if [[ -n "$name" ]]; then
    pass "package.json has name: $name"
  else
    fail "package.json missing name field"
  fi
fi

echo ""
echo "=== Validating plugin.json ==="

plugin="$REPO_ROOT/.claude-plugin/plugin.json"
if [[ ! -f "$plugin" ]]; then
  fail "plugin.json missing"
else
  if node -e "JSON.parse(require('fs').readFileSync('$plugin','utf8'))" 2>/dev/null; then
    pass "plugin.json is valid JSON"
  else
    fail "plugin.json is invalid JSON"
  fi

  for field in name description version; do
    val=$(node -e "const f=JSON.parse(require('fs').readFileSync('$plugin','utf8')).$field; console.log(f||'')" 2>/dev/null || echo "")
    if [[ -n "$val" ]]; then
      pass "plugin.json has $field"
    else
      fail "plugin.json missing $field field"
    fi
  done
fi

echo ""
echo "=== Validating repository files ==="

for reqfile in "README.md" "CHANGELOG.md" "CLAUDE.md"; do
  if [[ -f "$REPO_ROOT/$reqfile" ]]; then
    pass "$reqfile exists"
  else
    fail "$reqfile missing"
  fi
done

echo ""
echo "=== Validating CLAUDE.md skill references ==="

claude_md="$REPO_ROOT/CLAUDE.md"
if [[ -f "$claude_md" ]]; then
  for skill in "${SKILLS[@]}"; do
    if grep -q "$skill" "$claude_md"; then
      pass "CLAUDE.md references: $skill"
    else
      fail "CLAUDE.md does not reference: $skill"
    fi
  done
fi

echo ""
echo "=== Validating TOGAF artefact fidelity ==="
echo ""

# Reject UML "Class Diagram" in Phase C-Data context
echo "--- artifact-completeness: Phase C-Data diagram names ---"
if grep -q "Class Diagram" "$REPO_ROOT/skills/artifact-completeness/SKILL.md" 2>/dev/null; then
  fail "artifact-completeness contains 'Class Diagram' — must be 'Logical Data Diagram' (TOGAF canonical)"
else
  pass "artifact-completeness: no 'Class Diagram' (correct — TOGAF uses Logical Data Diagram)"
fi

# Reject hard counts of TOGAF artefacts across all skills
echo ""
echo "--- Forbid hard TOGAF artefact count assertions ---"
hard_count_hits=$(grep -rn --include="SKILL.md" -E "TOGAF defines [0-9]+ (standard )?(catalog|matrix|matrice|diagram)" "$REPO_ROOT/skills/" 2>/dev/null || true)
if [[ -n "$hard_count_hits" ]]; then
  echo "$hard_count_hits"
  fail "found hard TOGAF artefact count assertion(s) — use 'canonical artefacts include the following' instead"
else
  pass "no hard TOGAF artefact count assertions"
fi

# Require migration-plan to name both Phase E and Phase F explicitly
echo ""
echo "--- migration-plan: explicit Phase E and Phase F naming ---"
mig_file="$REPO_ROOT/skills/migration-plan/SKILL.md"
if grep -q "Phase E (Opportunities" "$mig_file" 2>/dev/null && grep -q "Phase F (Migration Planning)" "$mig_file" 2>/dev/null; then
  pass "migration-plan: Phase E (Opportunities) and Phase F (Migration Planning) both named"
else
  fail "migration-plan: must name both 'Phase E (Opportunities' and 'Phase F (Migration Planning)' explicitly"
fi

# Require practitioner overlay callout in skills that use non-TOGAF frameworks
echo ""
echo "--- Practitioner overlay callouts ---"
declare -A OVERLAY_SKILLS
OVERLAY_SKILLS["gap-analysis"]="CMMI 0-4 maturity"
OVERLAY_SKILLS["capability-assessment"]="CMMI 0-4 maturity"
OVERLAY_SKILLS["migration-plan"]="6R Disposition Model"
OVERLAY_SKILLS["risk-radar"]="ISO 31000 4T model"
OVERLAY_SKILLS["stakeholder-communication"]="Mendelow Power×Interest"
OVERLAY_SKILLS["architecture-review"]="ATAM sensitivity mapping"
OVERLAY_SKILLS["adr-generator"]="MADR format"

for skill in "${!OVERLAY_SKILLS[@]}"; do
  sfile="$REPO_ROOT/skills/$skill/SKILL.md"
  label="${OVERLAY_SKILLS[$skill]}"
  if [[ -f "$sfile" ]] && grep -q "Practitioner overlay" "$sfile" 2>/dev/null; then
    pass "overlay callout: $skill ($label)"
  else
    fail "overlay callout missing: $skill ($label) — add '> [!info] Practitioner overlay — not TOGAF-native'"
  fi
done

echo ""
echo "=== Validating example file references ==="
echo ""

EXAMPLES_DIR="$REPO_ROOT/references/examples"

# No stale example-*.md references anywhere in the repo
echo "--- Stale example-*.md path references ---"
stale_hits=$(grep -r --include="*.md" -l "example-[a-z]" "$REPO_ROOT" 2>/dev/null \
  | grep -v "^$REPO_ROOT/.git" || true)
if [[ -n "$stale_hits" ]]; then
  echo "$stale_hits"
  fail "stale example-*.md references found — rename to Johnny Decimal paths"
else
  pass "no stale example-*.md references"
fi

echo ""
echo "--- SKILL.md [!tip] citations resolve ---"
while IFS= read -r path; do
  full="$REPO_ROOT/$path"
  if [[ -f "$full" ]]; then
    pass "skill citation OK: $path"
  else
    fail "skill citation BROKEN: $path"
  fi
done < <(grep -rh --include="SKILL.md" "references/examples/" "$REPO_ROOT/skills/" \
  | grep -oP 'references/examples/[^\s`\)]+\.md' | sort -u)

echo ""
echo "--- examples/README.md relative links resolve ---"
while IFS= read -r target; do
  full="$EXAMPLES_DIR/$target"
  if [[ -f "$full" ]]; then
    pass "examples/README link OK: $target"
  else
    fail "examples/README link BROKEN: $target"
  fi
done < <(grep -oP '\[.*?\]\(\K[^)]+\.md' "$EXAMPLES_DIR/README.md" | sort -u)

echo ""
echo "--- No orphan files in references/examples/ ---"
for f in "$EXAMPLES_DIR"/*.md; do
  base=$(basename "$f")
  [[ "$base" == "README.md" ]] && continue
  if grep -q "$base" "$EXAMPLES_DIR/README.md"; then
    pass "indexed in examples/README: $base"
  else
    fail "orphan — not in examples/README: $base"
  fi
done

echo ""
echo "--- Root README.md example paths resolve ---"
while IFS= read -r path; do
  if [[ -f "$REPO_ROOT/$path" ]]; then
    pass "README path OK: $path"
  else
    fail "README path BROKEN: $path"
  fi
done < <(grep -oP 'references/examples/[^\s`\|]+\.md' "$REPO_ROOT/README.md" | sort -u)

echo ""
echo "--- togaf-content-framework.md example paths resolve ---"
while IFS= read -r path; do
  full="$REPO_ROOT/references/$path"
  if [[ -f "$full" ]]; then
    pass "content-framework path OK: $path"
  else
    fail "content-framework path BROKEN: $path"
  fi
done < <(grep -oP 'examples/[^\s`\)]+\.md' "$REPO_ROOT/references/togaf-content-framework.md" | sort -u)

echo ""

if [[ $ERRORS -eq 0 ]]; then
  echo "All checks passed."
  exit 0
else
  echo "$ERRORS check(s) failed."
  exit 1
fi
