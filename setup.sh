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

# Get Telegram User ID
read -p "Telegram User ID (for notifications, or press Enter to skip): " TELEGRAM_USER_ID
TELEGRAM_USER_ID=${TELEGRAM_USER_ID:-"{TELEGRAM_USER_ID}"}

# Tech Stack Selection
echo ""
echo "=== Tech Stack Selection ==="
echo "1) Node.js + TypeScript"
echo "2) React + TypeScript"
echo "3) Google Apps Script (GAS)"
echo "4) Python"
echo "5) Other / Skip"
echo ""
read -p "Select tech stack [1-5]: " TECH_CHOICE

case $TECH_CHOICE in
  1)
    RUNTIME="Node.js"
    FRAMEWORK="-"
    LANGUAGE="TypeScript"
    TEST_FRAMEWORK="Vitest"
    ;;
  2)
    RUNTIME="Node.js"
    FRAMEWORK="React"
    LANGUAGE="TypeScript"
    TEST_FRAMEWORK="Vitest"
    ;;
  3)
    RUNTIME="Google Apps Script"
    FRAMEWORK="-"
    LANGUAGE="TypeScript"
    TEST_FRAMEWORK="Vitest (local)"
    ;;
  4)
    RUNTIME="Python"
    FRAMEWORK="-"
    LANGUAGE="Python"
    TEST_FRAMEWORK="pytest"
    ;;
  *)
    RUNTIME="-"
    FRAMEWORK="-"
    LANGUAGE="-"
    TEST_FRAMEWORK="-"
    ;;
esac

# Test setup option
echo ""
read -p "Setup test environment with Vitest? [y/N]: " SETUP_TESTS
SETUP_TESTS=${SETUP_TESTS:-n}

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
sed -i "s/{REPOSITORY}/$REPOSITORY/g" CLAUDE.md
sed -i "s/{TELEGRAM_USER_ID}/$TELEGRAM_USER_ID/g" CLAUDE.md

# Update Tech Stack in CLAUDE.md
if [ "$RUNTIME" != "-" ]; then
  sed -i "s/| Runtime   | -          |/| Runtime   | $RUNTIME |/g" CLAUDE.md
  sed -i "s/| Framework | -          |/| Framework | $FRAMEWORK |/g" CLAUDE.md
  sed -i "s/| Language  | -          |/| Language  | $LANGUAGE |/g" CLAUDE.md
  sed -i "s/| Test      | -          |/| Test      | $TEST_FRAMEWORK |/g" CLAUDE.md
fi

# Setup test environment if requested
if [[ "$SETUP_TESTS" =~ ^[Yy]$ ]]; then
  echo "Setting up test environment..."
  
  # Create tests directory
  mkdir -p tests
  
  # Copy test templates
  if [ -d "templates" ]; then
    cp templates/vitest.config.ts.template vitest.config.ts 2>/dev/null || true
    cp templates/tests/example.test.ts.template tests/example.test.ts 2>/dev/null || true
  fi
  
  # Create basic package.json if not exists
  if [ ! -f "package.json" ]; then
    cat > package.json << EOF
{
  "name": "$PROJECT_NAME",
  "version": "0.1.0",
  "description": "$PROJECT_DESC",
  "type": "module",
  "scripts": {
    "test": "vitest run",
    "test:watch": "vitest",
    "test:coverage": "vitest run --coverage"
  },
  "devDependencies": {
    "vitest": "^2.0.0",
    "@vitest/coverage-v8": "^2.0.0",
    "typescript": "^5.0.0"
  }
}
EOF
    echo "Created package.json"
  fi
  
  echo "Test environment setup complete!"
  echo "Run 'npm install' to install dependencies"
fi

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

# Remove template files
rm -f .claude/project.json.template
rm -rf templates

# Clean up template files
echo ""
echo "Cleaning up template files..."
rm -rf .git
rm -f README.md
rm -f setup.sh

echo ""
echo "=== Setup Complete ==="
echo ""
echo "📚 First, read CLAUDE.md to understand your project structure"
echo ""
echo "Next steps:"
echo "  1. git init && git add . && git commit -m 'Initial commit'"
echo "  2. gh repo create $REPO_NAME --private --source=. --push"
if [ -z "$PROJECT_NUMBER" ]; then
  echo "  3. Create GitHub Project: gh project create --owner @me --title '$PROJECT_NAME'"
  echo "  4. Create .claude/project.json with project details"
fi
echo ""
echo "🚀 Start developing:"
echo "  • Say: 'let's start working' or '/development-flow'"
echo "  • Claude will fetch tasks from GitHub Project"
echo "  • Create session todos and begin working"
echo ""
echo "📝 Important files:"
echo "  • .claude/CONTEXT.md - Project decisions and key learnings"
echo "  • .claude/memory/YYYY-MM-DD.md - Daily development logs"
if [[ "$SETUP_TESTS" =~ ^[Yy]$ ]]; then
  echo "  • vitest.config.ts - Test configuration"
  echo "  • tests/ - Test files"
fi
