# Skill Structure Patterns

## Basic Pattern

When single SKILL.md is sufficient:

```
.claude/skills/{skill-name}/
└── SKILL.md
```

**When to use**: Content is 50 lines or less, detailed explanation not needed

## Reference Pattern

When detailed documentation is needed:

```
.claude/skills/{skill-name}/
├── SKILL.md
└── references/
    ├── {topic-a}.md
    └── {topic-b}.md
```

**When to use**: Deep explanation needed for each topic

## Example Pattern

When there are many code examples:

```
.claude/skills/{skill-name}/
├── SKILL.md
└── references/
    ├── rules.md
    └── examples/
        ├── basic.md
        └── advanced.md
```

**When to use**: Various usage examples needed

## Skill Classification Guide

### When to create a new skill?

1. **Independent topic** - Does not overlap with other skills
2. **Repeated reference** - Needed in multiple tasks
3. **Sufficient content** - SKILL.md 20+ lines

### When to add to existing skill?

1. **Related topic** - Extension of existing skill
2. **Small content** - Not enough for independent skill

## Naming Convention

### Skill Names

```
# Good
code-standards
development-flow
project-structure

# Bad
codeStandards      # No camelCase
Code_Standards     # No underscore
standards          # Too vague
```

### Reference Filenames

```
# Good
eslint-rules.md
tdd-process.md
module-structure.md

# Bad
ESLintRules.md     # No camelCase
rules.md           # Too vague
```

## Inter-skill References

When referencing other skills:

```markdown
## Related Skills

- Code standards: `.claude/skills/code-standards/SKILL.md`
- Development flow: `.claude/skills/development-flow/SKILL.md`
```
