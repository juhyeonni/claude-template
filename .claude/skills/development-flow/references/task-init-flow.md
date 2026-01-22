# Task Initialization Flow

## Overview

Before starting any development work, follow this flow to identify and track tasks.

```
Session Start
    |
    v
Read .claude/project.json
    |
    v
Check Session Todos (TodoWrite)
    |
    +-- Has todos? --> Continue with existing todos
    |
    +-- Empty? --> Fetch from GitHub Project
                        |
                        v
                   Select task from list
                        |
                        v
                   Create session todo
                        |
                        v
                   Start working
```

## Step 0: Read Project Config

**Always start by reading the project configuration:**

```bash
cat .claude/project.json
```

Extract these values for subsequent commands:
- `PROJECT_NUMBER` from `.github.project.number`
- `PROJECT_OWNER` from `.github.project.owner`
- `REPOSITORY` from `.github.repository`

## Step 1: Check Session Todos

Session todos are internal to Claude Code and persist within the current conversation.

If there are existing todos, continue working on them.

## Step 2: Fetch from GitHub Project (if session todos empty)

```bash
# List all project items
gh project item-list {PROJECT_NUMBER} --owner {PROJECT_OWNER}

# Filter by status (optional)
gh project item-list {PROJECT_NUMBER} --owner {PROJECT_OWNER} --format json | jq '.items[] | select(.status == "Todo")'
```

### Project Item Fields

| Field  | Description         |
| ------ | ------------------- |
| Type   | Issue / PullRequest |
| Title  | Task title          |
| Number | Issue/PR number     |
| Repo   | Repository name     |
| ID     | Project item ID     |

## Step 3: Select Task and Create Session Todo

After identifying the task from GitHub Project:

1. Read the issue details: `gh issue view <number> --repo {REPOSITORY}`
2. Break down into subtasks if needed
3. Create session todos using TodoWrite

## Example Workflow

```
User: "Let's start working"

Claude:
1. Reads: cat .claude/project.json (gets PROJECT_NUMBER)
2. Checks TodoWrite -> empty
3. Fetches: gh project item-list {PROJECT_NUMBER} --owner @me
4. Shows available tasks to user
5. User selects task (e.g., Issue #3)
6. Claude reads: gh issue view 3
7. Creates session todos based on issue requirements
8. Begins working
```

## Sync on Completion

When a task is completed:

1. Mark session todo as `completed`
2. Update GitHub Project item status to "Done"
3. Close the related issue

See `github-sync.md` for detailed sync commands.

## Notes

- Session todos are temporary (conversation-scoped)
- GitHub Project is the source of truth for task tracking
- Always sync back to GitHub when task is completed
