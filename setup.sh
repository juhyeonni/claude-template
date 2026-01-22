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

# Get GitHub username
echo ""
echo "Detecting GitHub username..."
GH_USER=$(gh api user --jq '.login' 2>/dev/null || echo "")
if [ -z "$GH_USER" ]; then
  read -p "GitHub username: " GH_USER
fi
echo "GitHub user: $GH_USER"

# Get repository name
read -p "Repository name (default: $PROJECT_NAME): " REPO_NAME
REPO_NAME=${REPO_NAME:-$PROJECT_NAME}
REPOSITORY="$GH_USER/$REPO_NAME"

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

# Create project.json if project number provided
if [ -n "$PROJECT_NUMBER" ]; then
  echo "Creating .claude/project.json..."

  # Get project details
  PROJECT_INFO=$(gh project view $PROJECT_NUMBER --owner @me --format json 2>/dev/null || echo "{}")
  PROJECT_ID=$(echo "$PROJECT_INFO" | jq -r '.id // ""')
  PROJECT_URL=$(echo "$PROJECT_INFO" | jq -r '.url // ""')

  # Create project.json
  cat > .claude/project.json << EOF
{
  "github": {
    "project": {
      "number": $PROJECT_NUMBER,
      "id": "$PROJECT_ID",
      "url": "$PROJECT_URL",
      "owner": "@me"
    },
    "repository": "$REPOSITORY"
  }
}
EOF

  echo "GitHub Project configured: #$PROJECT_NUMBER"
else
  echo "Skipping GitHub Project configuration (can be set later)"
  echo "To configure later, create .claude/project.json manually"
fi

# Remove template file
rm -f .claude/project.json.template

# Clean up template files
echo ""
echo "Cleaning up template files..."
rm -rf .git
rm -f README.md
rm -f setup.sh

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. git init && git add . && git commit -m 'Initial commit'"
echo "  2. gh repo create $REPO_NAME --private --source=. --push"
if [ -z "$PROJECT_NUMBER" ]; then
  echo "  3. Create GitHub Project: gh project create --owner @me --title '$PROJECT_NAME'"
  echo "  4. Create .claude/project.json with project details"
fi
echo ""
echo "Then start working: 'let's start working' or '/development-flow'"
