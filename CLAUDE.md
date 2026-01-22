# {PROJECT_NAME}

{One-line project description}

## Project Configuration

GitHub Project settings are stored in `.claude/project.json`.

```bash
# Read project config
cat .claude/project.json
```

## Task Management

**IMPORTANT:** Always use `development-flow` skill when starting work sessions.

### Workflow

1. Run `/development-flow` or say "let's start working"
2. Fetch tasks from GitHub Project
3. Create session todos from project items
4. Sync completed tasks back to GitHub

### Quick Commands

```bash
# Fetch tasks from GitHub Project (read PROJECT_NUMBER from .claude/project.json)
gh project item-list {PROJECT_NUMBER} --owner @me

# Create new issue
gh issue create --title "Title" --repo {REPOSITORY}

# Close completed issue
gh issue close <number> --repo {REPOSITORY}
```

## Tech Stack

| Area      | Technology |
| --------- | ---------- |
| Runtime   | -          |
| Framework | -          |
| Language  | -          |
| Test      | -          |

## Commands

```bash
# dev        - Start development server
# test       - Run tests
# build      - Build for production
# lint       - Run linter
```

## Skills Reference

| Skill                | Description                                |
| -------------------- | ------------------------------------------ |
| `development-flow`   | **GitHub Project sync and task workflow**  |
| `skill-authoring`    | Skills writing and editing guide           |
| `project-management` | GitHub Project, issues, PR workflow        |

## Core Rules

- **English only**: All comments, documentation, and commit messages in English
- **GitHub Project sync**: Always sync session todos with GitHub Project
- **Config first**: Read `.claude/project.json` before GitHub operations
