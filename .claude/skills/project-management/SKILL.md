---
name: project-management
description: GitHub Project workflow guide. Includes issue creation, PR workflow, labels usage.
---

# Project Management Guide

This project uses GitHub Projects for task tracking and workflow management.

## Quick Reference

### Creating Issues

```bash
# Feature request
gh issue create --template feature.yml

# Bug report
gh issue create --template bug.yml

# General task
gh issue create --template task.yml
```

### Labels

| Category | Labels                                                  |
| -------- | ------------------------------------------------------- |
| Type     | `type:feature`, `type:bug`, `type:task`                 |
| Priority | `priority:high`, `priority:medium`, `priority:low`      |
| Status   | `status:in-progress`, `status:blocked`, `status:review` |

### Workflow

1. Create Issue (auto-added to Project)
2. Assign milestone and labels
3. Create branch from issue
4. Submit PR (references issue)
5. Review and merge

## Detailed References

- Issue workflow: `references/issue-workflow.md`
- PR workflow: `references/pr-workflow.md`
