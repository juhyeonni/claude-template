---
name: development-flow
description: This skill should be used when the user says "let's start working", "start development", "what should I work on", "check tasks", "fetch todos from github", "show my tasks", or at the beginning of any development session. Provides GitHub Project task sync and workflow management.
---

# Development Flow Guide

This project uses GitHub Projects for task tracking with automatic sync.

## Project Configuration

**IMPORTANT:** Always read project settings from `.claude/project.json` first:

```bash
cat .claude/project.json
```

Use the values from this config file for all GitHub Project commands below.

- `PROJECT_NUMBER` = `.github.project.number`
- `PROJECT_ID` = `.github.project.id`
- `PROJECT_OWNER` = `.github.project.owner`
- `REPOSITORY` = `.github.repository`

## Task Initialization (Before Starting Work)

When starting a development session:

1. **Read project config:** `cat .claude/project.json`
2. **Check session todos first** (TodoWrite internal state)
3. **If empty, fetch from GitHub Project:**
   ```bash
   gh project item-list {PROJECT_NUMBER} --owner {PROJECT_OWNER} --format json
   ```
4. **Select task and create session todo** from GitHub Project item

See `references/task-init-flow.md` for detailed workflow.

## GitHub Project Sync

### Fetch Tasks

```bash
# List all items
gh project item-list {PROJECT_NUMBER} --owner {PROJECT_OWNER}

# List with JSON format for parsing
gh project item-list {PROJECT_NUMBER} --owner {PROJECT_OWNER} --format json
```

### Add New Task to Project

When user creates a new task:

```bash
# Create issue and add to project
gh issue create --title "Task title" --body "Description" --repo {REPOSITORY}
gh project item-add {PROJECT_NUMBER} --owner {PROJECT_OWNER} --url <issue_url>
```

### Update Task Status

When completing a task:

```bash
# Get item ID first
gh project item-list {PROJECT_NUMBER} --owner {PROJECT_OWNER} --format json | jq '.items[] | select(.title == "Task name")'

# Update status field (get field ID first)
gh project field-list {PROJECT_NUMBER} --owner {PROJECT_OWNER} --format json
gh project item-edit --project-id {PROJECT_ID} --id <ITEM_ID> --field-id <STATUS_FIELD_ID> --single-select-option-id <DONE_OPTION_ID>
```

### Close Issue

```bash
gh issue close <issue_number> --repo {REPOSITORY}
```

## Workflow States

| TodoWrite Status | GitHub Project Action |
|------------------|----------------------|
| `pending` | Item status: "Todo" |
| `in_progress` | Item status: "In Progress" |
| `completed` | Item status: "Done" + Close Issue |

## Flow References

- **Task initialization: `references/task-init-flow.md`**
- GitHub sync: `references/github-sync.md`

## Quick Reference

```bash
# Read config first
cat .claude/project.json

# Fetch tasks
gh project item-list {PROJECT_NUMBER} --owner {PROJECT_OWNER}

# Create issue
gh issue create --title "Title" --body "Body" --repo {REPOSITORY}

# Close issue
gh issue close <number> --repo {REPOSITORY}
```
