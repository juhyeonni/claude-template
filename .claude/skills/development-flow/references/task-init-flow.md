# Task Initialization Flow

## Overview

Before starting any development work, follow this flow to identify and track tasks.

```
Session Start
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
                   Start TDD flow
```

## Step 1: Check Session Todos

Session todos are internal to Claude Code and persist within the current conversation.

If there are existing todos, continue working on them.

## Step 2: Fetch from GitHub Project (if session todos empty)

```bash
# List all project items
gh project item-list {PROJECT_NUMBER} --owner @me

# Filter by status (optional)
gh project item-list {PROJECT_NUMBER} --owner @me --format json | jq '.items[] | select(.status == "Todo")'
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

1. Read the issue details: `gh issue view <number>`
2. Break down into subtasks if needed
3. Create session todos using TodoWrite

## Example Workflow

```
User: "Let's start working"

Claude:
1. Checks TodoWrite -> empty
2. Fetches: gh project item-list {PROJECT_NUMBER} --owner @me
3. Shows available tasks to user
4. User selects task (e.g., Issue #3)
5. Claude reads: gh issue view 3
6. Creates session todos based on issue requirements
7. Begins TDD flow
```

## Notes

- Session todos are temporary (conversation-scoped)
- GitHub Project is the source of truth for task tracking
- Update issue status on GitHub when task is completed
