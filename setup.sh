#!/bin/bash

# Claude Template Setup Script
# Replaces placeholders with actual project values

set -e

echo "=== Claude Template Setup ==="
echo ""

# Get project name
read -p "Project name: " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
  echo "Error: Project name is required"
  exit 1
fi

# Get project description
read -p "Project description (one line): " PROJECT_DESC
PROJECT_DESC=${PROJECT_DESC:-"Project description"}

# Get GitHub Project number
echo ""
echo "Fetching your GitHub Projects..."
gh project list --owner @me 2>/dev/null || echo "Could not fetch projects (gh CLI not configured)"
echo ""
read -p "GitHub Project number (or press Enter to skip): " PROJECT_NUMBER

# Replace placeholders in CLAUDE.md
echo ""
echo "Updating CLAUDE.md..."
sed -i "s/{PROJECT_NAME}/$PROJECT_NAME/g" CLAUDE.md
sed -i "s/{One-line project description}/$PROJECT_DESC/g" CLAUDE.md

# Replace PROJECT_NUMBER if provided
if [ -n "$PROJECT_NUMBER" ]; then
  echo "Updating GitHub Project number..."
  sed -i "s/{PROJECT_NUMBER}/$PROJECT_NUMBER/g" .claude/settings.local.json
  sed -i "s/{PROJECT_NUMBER}/$PROJECT_NUMBER/g" .claude/skills/development-flow/SKILL.md
  sed -i "s/{PROJECT_NUMBER}/$PROJECT_NUMBER/g" .claude/skills/development-flow/references/task-init-flow.md
else
  echo "Skipping GitHub Project number (can be set later)"
fi

# Clean up template files
echo ""
echo "Cleaning up template files..."
rm -rf .git
rm -f README.md
rm -f setup.sh

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Remaining placeholders to configure manually:"
echo "  - {test_command}  : e.g., 'pnpm test', 'npm test'"
echo "  - {lint_command}  : e.g., 'pnpm lint', 'npm run lint'"
if [ -z "$PROJECT_NUMBER" ]; then
  echo "  - {PROJECT_NUMBER}: Run 'gh project list --owner @me' to find it"
fi
