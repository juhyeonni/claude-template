# Claude Template

Reusable Claude Code project template with skills and settings.

## Quick Start

```bash
git clone https://github.com/juhyeonni/claude-template.git my-project && cd my-project && ./setup.sh
```

Or step by step:
```bash
git clone https://github.com/juhyeonni/claude-template.git my-project
cd my-project
./setup.sh       # Interactive setup (auto-removes .git)
```

## What's Included

```
.claude/
├── plans/                    # Implementation plans (empty)
├── settings.local.json       # Permissions + SessionStart hook
└── skills/
    ├── development-flow/     # TDD + GitHub task workflow
    ├── project-management/   # GitHub Project, issues, PR
    └── skill-authoring/      # Skills writing guide
```

## Placeholders

| Placeholder | Location | Description |
|-------------|----------|-------------|
| `{PROJECT_NAME}` | CLAUDE.md | Project name |
| `{PROJECT_NUMBER}` | settings.local.json, skills | GitHub Project number |
| `{test_command}` | skills/development-flow | e.g., `pnpm test`, `pytest` |
| `{lint_command}` | skills/development-flow | e.g., `pnpm lint`, `ruff check` |

`setup.sh` handles `PROJECT_NAME` and `PROJECT_NUMBER` automatically.

## Finding GitHub Project Number

```bash
gh project list --owner @me
```

Output:
```
NUMBER  TITLE              STATE
7       my-project         open
```

Use the `NUMBER` value.

## Skills Usage

| Command | Description |
|---------|-------------|
| `/development-flow` | Start TDD workflow with GitHub task fetch |
| `/project-management` | Create issues, manage PR workflow |
| `/skill-authoring` | Guide for writing custom skills |

## After Setup

1. Update Tech Stack in `CLAUDE.md`
2. Replace `{test_command}` and `{lint_command}` in skill references
3. Delete this README (or keep and modify for your project)
