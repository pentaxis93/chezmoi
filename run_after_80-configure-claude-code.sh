#!/usr/bin/env bash

# Configure global Claude Code settings
# These settings are applied globally via the claude config command
# Only runs when content changes (onchange_ prefix)

# Disable Claude attribution in git commits
claude config set -g includeCoAuthoredBy false

# Set verbose output for better visibility
claude config set -g verbose true

# Keep auto updates enabled
claude config set -g autoUpdates true

# Ensure dark theme
claude config set -g theme dark

echo "✓ Claude Code global settings configured"