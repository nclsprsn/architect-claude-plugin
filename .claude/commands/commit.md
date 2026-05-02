---
description: Stage and commit changes following the project commit convention — gitmoji prefix, imperative subject, no Co-Authored-By trailer.
argument-hint: "[optional commit message subject]"
---

You are committing changes to the architect plugin repository. Follow the project commit convention exactly.

## Step 1 — Inspect the working tree

Run `git status` and `git diff` to understand what has changed. Do not assume — read the actual diff.

## Step 2 — Select the gitmoji

Pick the single most appropriate gitmoji for the changeset:

| Gitmoji | When |
|---------|------|
| ✨ | New skill, new command, new feature |
| 🐛 | Bug fix |
| 📝 | Documentation (README, CHANGELOG, comments) |
| ✅ | CI, tests, validation |
| ♻️ | Refactor — behaviour unchanged |
| 🔧 | Tooling, config (package.json, plugin.json, workflow files) |
| 🔥 | Remove code or files |
| ⬆️ | Dependency upgrade |
| 🏷️ | Rename or restructure without feature change |

If the changeset spans multiple types, use the gitmoji of the dominant change.

## Step 3 — Draft the subject line

- Imperative mood: "Add …", "Fix …", "Update …", "Remove …" — not "Added" or "Adding"
- ≤ 72 characters including the gitmoji
- No period at the end
- If an argument was provided, use it as the subject (still add the gitmoji)

## Step 4 — Stage and commit

Stage only the files relevant to this change. Prefer specific file names over `git add .`.

```bash
git add <specific files>
git commit -m "<gitmoji> <subject>"
```

**Never** add a `Co-Authored-By` trailer.

If the diff is large or spans unrelated concerns, ask whether to split into multiple commits before proceeding.

## Step 5 — Confirm

Show the result of `git log --oneline -3` so the commit is visible.
