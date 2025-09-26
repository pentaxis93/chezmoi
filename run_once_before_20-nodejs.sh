#!/usr/bin/env bash
set -euo pipefail

# Setup Node.js ecosystem (npm/npx)
# Runs once before dotfiles are updated

# Check if npm is already installed
if command -v npm &> /dev/null; then
    echo "✓ npm already installed ($(npm --version))"
    exit 0
fi

# Node.js is installed but npm is missing
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v | sed 's/v//' | cut -d. -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        echo "⚠ Node.js version too old (v$NODE_VERSION, need >= 18)"
        exit 1
    fi

    echo "Installing npm for Node.js $(node -v)..."
    # Install npm via package manager based on OS
    if [ -f /etc/arch-release ] || [ -f /etc/artix-release ]; then
        # Arch-based (including CachyOS)
        sudo pacman -S --noconfirm npm
    elif [ -f /etc/debian_version ]; then
        # Debian/Ubuntu
        sudo apt-get update && sudo apt-get install -y npm
    elif [ -f /etc/fedora-release ]; then
        # Fedora
        sudo dnf install -y npm
    else
        echo "⚠ Unable to detect package manager for npm installation"
        echo "Please install npm manually"
        exit 1
    fi

    echo "✓ npm installed ($(npm --version))"
else
    echo "⚠ Node.js not installed. Please install Node.js >= 18 first"
    exit 1
fi