# Claude Template

Reusable Claude Code project template with skills, GitHub integration, and TDD workflow.

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
├── CONTEXT.md                # Project decisions & key learnings
├── memory/                   # Daily development logs (YYYY-MM-DD.md)
├── project.json              # GitHub Project configuration
└── skills/
    ├── development-flow/     # TDD + GitHub task workflow
    ├── project-management/   # Issues, PR, Milestones
    └── skill-creator/        # Guide for creating custom skills

templates/
├── vitest.config.ts.template # Test configuration template
└── tests/
    └── example.test.ts.template
```

### Key Features

- **Skills System:** Quick Reference + detailed references (progressive disclosure)
- **Memory Layer:** Track decisions (CONTEXT.md) and daily logs (memory/)
- **GitHub Project Integration:** Auto-sync between TodoWrite and GitHub
- **TDD Workflow:** Test-first development process
- **Milestone Workflow:** Track releases and phases
- **Tech Stack Selection:** Choose your stack during setup
- **Test Templates:** Vitest configuration included

## Placeholders

| Placeholder | Location | Description |
|-------------|----------|-------------|
| `{PROJECT_NAME}` | CLAUDE.md | Project name |
| `{REPOSITORY}` | CLAUDE.md | GitHub owner/repo |
| `{TELEGRAM_USER_ID}` | CLAUDE.md | For notifications |
| `{test_command}` | skills references | e.g., `pnpm test`, `pytest` |
| `{lint_command}` | skills references | e.g., `pnpm lint`, `ruff check` |

`setup.sh` handles most placeholders automatically.

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
| `/skill-creator` | Guide for writing custom skills |

### Skill Triggers

- **"let's start working"** → development-flow
- **Creating/updating issues** → project-management
- **Creating new skills** → skill-creator

## After Setup

1. Verify Tech Stack in `CLAUDE.md`
2. Replace `{test_command}` and `{lint_command}` in skill references
3. Update Milestones table in `CLAUDE.md`
4. Delete this README (or modify for your project)
