#!/bin/bash
# Ferri CLI Installer
# Installs ferri and sets up protocol handler

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Crab emoji for branding
CRAB="🦀"

echo -e "${BLUE}${CRAB} Ferri CLI Installer${NC}\n"

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Darwin*)    PLATFORM="macos";;
    Linux*)     PLATFORM="linux";;
    *)          PLATFORM="unknown";;
esac

if [ "$PLATFORM" = "unknown" ]; then
    echo -e "${RED}Error: Unsupported operating system: ${OS}${NC}"
    echo "Ferri currently supports macOS and Linux."
    exit 1
fi

echo -e "${BLUE}Platform:${NC} ${PLATFORM}"

# Check if Rust/Cargo is installed
if ! command -v cargo &> /dev/null; then
    echo -e "\n${YELLOW}Rust/Cargo not found.${NC}"
    echo "Ferri requires Rust to install from source."
    echo ""
    echo "Install Rust by running:"
    echo -e "  ${GREEN}curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh${NC}"
    echo ""
    echo "Then run this installer again."
    exit 1
fi

echo -e "${GREEN}✓${NC} Rust/Cargo found\n"

# Install ferri from GitHub
echo -e "${BLUE}Installing ferri...${NC}"
echo "This may take a few minutes to compile..."

if cargo install --git https://github.com/jorgeajimenez/ferri.git ferri-cli; then
    echo -e "\n${GREEN}✓${NC} Ferri installed successfully!"
else
    echo -e "\n${RED}Error: Failed to install ferri${NC}"
    exit 1
fi

# Verify installation
if command -v ferri &> /dev/null; then
    FERRI_VERSION=$(ferri --version 2>/dev/null || echo "unknown")
    echo -e "${GREEN}✓${NC} Ferri is available: ${FERRI_VERSION}\n"
else
    echo -e "\n${YELLOW}Warning:${NC} Ferri was installed but not found in PATH"
    echo "You may need to add ~/.cargo/bin to your PATH"
    echo "Add this to your ~/.bashrc or ~/.zshrc:"
    echo -e "  ${GREEN}export PATH=\"\$HOME/.cargo/bin:\$PATH\"${NC}\n"
fi

# Set up protocol handler (macOS only)
if [ "$PLATFORM" = "macos" ]; then
    echo -e "${BLUE}Setting up ferri:// protocol handler...${NC}"
    if ferri setup; then
        echo -e "${GREEN}✓${NC} Protocol handler registered\n"
    else
        echo -e "${YELLOW}Warning:${NC} Protocol handler setup failed (non-fatal)\n"
    fi
fi

# Success message
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}${CRAB} Installation complete!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

echo "Next steps:"
echo -e "  ${BLUE}1.${NC} Activate your license:"
echo -e "     ${GREEN}ferri activate <LICENSE_KEY>${NC}"
echo ""
echo -e "  ${BLUE}2.${NC} Start using Ferri:"
echo -e "     ${GREEN}ferri --help${NC}"
echo ""
echo -e "  ${BLUE}3.${NC} Check license status anytime:"
echo -e "     ${GREEN}ferri license${NC}"
echo ""
echo "Documentation: https://github.com/jorgeajimenez/ferri"
echo ""
