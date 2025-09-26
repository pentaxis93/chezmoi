#!/usr/bin/env bash
set -euo pipefail

# Configure Claude Code - installation, settings, and tools
# Runs after dotfiles are updated

# Ensure Claude Code is installed/updated
if command -v claude &> /dev/null; then
    CURRENT_VERSION=$(claude --version | cut -d' ' -f1)
    echo "Claude Code v$CURRENT_VERSION found"
    # Auto-update is handled by the autoUpdates setting below
else
    echo "Installing Claude Code (native)..."
    curl -fsSL https://claude.ai/install.sh | bash
    echo "✓ Claude Code installed"
fi

# Configure global settings
claude config set -g verbose true
claude config set -g autoUpdates true
claude config set -g theme dark

echo "✓ Claude Code settings configured"

# Configure context7 MCP server for enhanced capabilities
# npm/npx installed by run_once_before_20-nodejs.sh
echo "Configuring context7 MCP server..."
claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp@latest 2>/dev/null || \
    echo "  context7 MCP server already configured"
echo "✓ context7 MCP configured"

echo "✓ Claude Code configuration complete"