# Skill Writing Rules

## SKILL.md Frontmatter

```yaml
---
name: skill-name # Required, same as directory name
description: One-line description # Required, used by Claude for skill selection
---
```

## Writing Description

- Write in one line (50 chars recommended)
- Specify **when** the skill is used
- Include specific keywords

```markdown
# Good

description: Project directory structure and architecture guide

# Bad

description: Description about structure
```

## Body Structure

### Required Sections

1. **Overview** - 2-3 line description
2. **Quick Reference** - Frequently used content (code, commands, etc.)
3. **Detailed References** - Links to references files

### Optional Sections

- Examples
- Cautions
- Related skill links

## Writing Principles

### Brevity First

```markdown
# Good

## Quick Reference

pnpm test # Run tests
pnpm lint # Lint check

# Bad

## Quick Reference

To run tests, use the following command:
pnpm test
```

### Use Code Blocks Actively

- Use code blocks for commands, structures, examples
- Specify language hints (`typescript`, `bash`, etc.)

### Minimize Duplication

- Extract common content to shared skill
- Delegate details to references

## Reference File Rules

### File Size

- 100-200 lines per file recommended
- Consider splitting if over 300 lines

### Naming

```
references/
├── {topic}.md              # Single topic
├── {topic}-{detail}.md     # Detailed classification
└── examples/               # Examples collection (if needed)
    └── {example-name}.md
```

### Link Style

```markdown
## Detailed References

- Topic A: `references/topic-a.md`
- Topic B: `references/topic-b.md`
```

## Markdown Style

### Headings

- `#` - Skill title (only one)
- `##` - Main sections
- `###` - Sub-sections

### Lists

- Unordered list: Use `-`
- Ordered list: Use `1.` `2.`

### Tables

Use for simple reference tables:

```markdown
| Command | Description |
| ------- | ----------- |
| test    | Run tests   |
| lint    | Lint check  |
```
