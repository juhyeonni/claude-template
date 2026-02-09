# {PROJECT_NAME}

{One-line project description}

## Skills (Required Reading)

**Before starting any work, read the relevant skill:**

| When | Skill | Path |
|------|-------|------|
| Starting a task / GitHub sync | `development-flow` | `.claude/skills/development-flow/SKILL.md` |
| Working on issues/PRs | `project-management` | `.claude/skills/project-management/SKILL.md` |
| Creating new skills | `skill-creator` | `.claude/skills/skill-creator/SKILL.md` |

### Skill Triggers

- **"let's start working"** → Read `development-flow`, sync GitHub issues
- **Creating/updating issues** → Read `project-management`
- **Creating new skills** → Read `skill-creator`

## Project Configuration

GitHub Project settings are stored in `.claude/project.json`.

```bash
cat .claude/project.json
```

## Workflow

### 1. Start Session
```
1. Read this CLAUDE.md
2. Check GitHub issues: gh issue list -R {REPOSITORY}
3. Pick an issue from current milestone
4. Read relevant skills for the task
5. Start working
```

### 2. During Development
```
1. Write tests first (TDD)
2. Implement feature
3. Run tests
4. Commit with conventional commits
```

### 3. Complete Task
```
1. Push changes
2. Close issue: gh issue close <number>
3. Notify via Telegram (see Notifications)
```

## Quick Commands

```bash
# Development (customize these for your project)
npm install         # Install dependencies
npm run dev         # Development mode
npm run build       # Build for production
npm test            # Run tests

# GitHub
gh issue list -R {REPOSITORY}
gh issue create --title "Title" -R {REPOSITORY}
gh issue close <number> -R {REPOSITORY}
```

## Tech Stack

| Area      | Technology |
| --------- | ---------- |
| Runtime   | -          |
| Framework | -          |
| Language  | -          |
| Test      | -          |

## Milestones

| Version | Focus | Key Issues |
|---------|-------|------------|
| v0.1 | Initial Setup | Setup, Core features |
| v0.2 | - | - |
| v0.3 | - | - |
| v1.0 | Production | Release |

## Notifications

Report to Juhyeon via Telegram ({TELEGRAM_USER_ID}):

```
📝 Starting #N: {title}
✅ Completed #N: {title}
❓ Question: {question}
```

## Core Rules

1. **English only** - All comments, docs, and commits in English
2. **Test-first** - Write tests before implementation (TDD)
3. **GitHub sync** - Always sync session todos with GitHub
4. **Config first** - Read `.claude/project.json` before GitHub operations
5. **Read skills** - Always check relevant skill before major work

## References

- GitHub: https://github.com/{REPOSITORY}
- Issues: `gh issue list -R {REPOSITORY}`
