---
name: development-flow
description: This skill should be used when the user says "let's start working", "start development", "what should I work on", "check tasks", "fetch todos from github", "show my tasks", or at the beginning of any development session. Provides TDD process and GitHub Project task initialization workflow.
---

# Development Flow Guide

This project follows a **TDD Required** policy.

## Task Initialization (Before Starting Work)

When starting a development session:

1. **Check session todos first** (TodoWrite internal state)
2. **If empty, fetch from GitHub Project:**
   ```bash
   gh project item-list {PROJECT_NUMBER} --owner @me
   ```
3. **Select task and create session todo** from GitHub Project item

See `references/task-init-flow.md` for detailed workflow.

## Core Principles

- Cannot complete implementation without tests
- RED → GREEN → REFACTOR cycle
- Never break existing tests

## Flow References

- **Task initialization: `references/task-init-flow.md`**
- Basic TDD process: `references/tdd-process.md`
- Bug fix flow: `references/bug-fix-flow.md`

## Quick Reference

```bash
# test         - Run tests
# test:watch   - Watch mode
# lint         - Lint check
```
