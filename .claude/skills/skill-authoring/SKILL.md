---
name: skill-authoring
description: Skills writing and editing guide. Includes new skill creation, SKILL.md format, structure rules.
---

# Skill Authoring Guide

Guide for writing and managing Skills in this project.

## Quick Creation

To create a new skill:

```bash
mkdir -p .claude/skills/{skill-name}/references
```

## Required Files

```
.claude/skills/{skill-name}/
├── SKILL.md           # Required - Main description
└── references/        # Optional - Detailed docs
    └── *.md
```

## SKILL.md Template

```markdown
---
name: { skill-name }
description: One-line description. Referenced by Claude when selecting skills.
---

# {Skill Title}

Brief overview (2-3 lines)

## Quick Reference

Frequently used commands or rules

## Detailed References

- Details: `references/{file}.md`
```

## Detailed References

- Writing rules: `references/writing-rules.md`
- Structure patterns: `references/structure-patterns.md`
