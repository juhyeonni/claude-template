#!/bin/bash
# Claude Template Installer
# Usage: curl -fsSL https://raw.githubusercontent.com/juhyeonni/claude-template/main/install.sh | bash -s <project-name>

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

PROJECT_NAME="${1:-}"
REPO_URL="https://github.com/juhyeonni/claude-template"

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Claude Project Template Installer  ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""

# Check project name
if [ -z "$PROJECT_NAME" ]; then
  echo -e "${YELLOW}Usage:${NC}"
  echo "  curl -fsSL https://raw.githubusercontent.com/juhyeonni/claude-template/main/install.sh | bash -s <project-name>"
  echo ""
  echo -e "${YELLOW}Example:${NC}"
  echo "  curl -fsSL https://...install.sh | bash -s my-awesome-project"
  echo ""
  read -p "Project name: " PROJECT_NAME
  if [ -z "$PROJECT_NAME" ]; then
    echo -e "${RED}Error: Project name is required${NC}"
    exit 1
  fi
fi

# Check if directory exists
if [ -d "$PROJECT_NAME" ]; then
  echo -e "${RED}Error: Directory '$PROJECT_NAME' already exists${NC}"
  exit 1
fi

# Check for git
if ! command -v git &> /dev/null; then
  echo -e "${RED}Error: git is required but not installed${NC}"
  exit 1
fi

echo -e "${GREEN}Creating project:${NC} $PROJECT_NAME"
echo ""

# Clone template (shallow)
echo -e "${BLUE}[1/4]${NC} Downloading template..."
git clone --depth 1 "$REPO_URL" "$PROJECT_NAME" 2>/dev/null
cd "$PROJECT_NAME"

# Remove git history
echo -e "${BLUE}[2/4]${NC} Cleaning up..."
rm -rf .git
rm -f install.sh

# Initialize fresh git
echo -e "${BLUE}[3/4]${NC} Initializing git..."
git init -q

# Run setup if interactive
echo -e "${BLUE}[4/4]${NC} Running setup..."
echo ""

if [ -t 0 ]; then
  # Interactive mode - run setup
  chmod +x setup.sh
  ./setup.sh
else
  # Non-interactive (piped) - show instructions
  echo -e "${YELLOW}═══════════════════════════════════════════${NC}"
  echo -e "${GREEN}✓ Template installed to:${NC} $(pwd)"
  echo ""
  echo -e "${YELLOW}Next steps:${NC}"
  echo "  cd $PROJECT_NAME"
  echo "  ./setup.sh"
  echo ""
  echo -e "${YELLOW}Or manually:${NC}"
  echo "  1. Edit CLAUDE.md (replace {PROJECT_NAME}, etc.)"
  echo "  2. Create .claude/project.json"
  echo "  3. git add . && git commit -m 'Initial commit'"
  echo -e "${YELLOW}═══════════════════════════════════════════${NC}"
fi
