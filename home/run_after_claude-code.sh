#!/usr/bin/env bash
set -euo pipefail

# Configure Claude Code - installation, settings, and tools
# Runs after dotfiles are updated (no sudo required)

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
claude config set -g preferredNotifChannel terminal_bell

echo "✓ Claude Code settings configured"

# Configure context7 MCP server for enhanced capabilities
# npm/npx installed by run_once_before_nodejs.sh
echo "Configuring context7 MCP server..."
claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp@latest 2>/dev/null || \
    echo "  context7 MCP server already configured"
echo "✓ context7 MCP configured"

echo "✓ Claude Code configuration complete"

# Check managed settings status
SETTINGS_FILE="/etc/claude-code/managed-settings.json"
if [ -f "$SETTINGS_FILE" ]; then
    # Can we read it? (no sudo needed for read)
    if [ -r "$SETTINGS_FILE" ]; then
        # Create temp file with our template
        TEMP_SETTINGS="/tmp/claude-settings-check-$$"
        cat <<EOF > "$TEMP_SETTINGS"
{
  "includeCoAuthoredBy": false,
  "outputStyle": "verbose",
  "permissions": {
    "allowedPaths": ["$HOME"],
    "deniedPaths": [
      "$HOME/.ssh/id_*",
      "$HOME/.gnupg/**",
      "$HOME/.aws/credentials",
      "$HOME/.kube/config",
      "/etc/passwd",
      "/etc/shadow"
    ]
  }
}
EOF
        # Check if they differ (ignore whitespace differences with jq if available)
        if command -v jq &>/dev/null; then
            # Use jq for semantic comparison (ignores formatting differences)
            CURRENT_JSON=$(jq -S . "$SETTINGS_FILE" 2>/dev/null || cat "$SETTINGS_FILE")
            TEMPLATE_JSON=$(jq -S . "$TEMP_SETTINGS" 2>/dev/null || cat "$TEMP_SETTINGS")
            if [ "$CURRENT_JSON" != "$TEMPLATE_JSON" ]; then
                echo ""
                echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
                echo "📝 Managed settings differ from template"
                echo "   To review/update: chezmoi cd && ./scripts/setup-claude-code-managed-settings"
                echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            fi
        else
            # Fallback to simple diff if jq not available
            if ! diff -q "$TEMP_SETTINGS" "$SETTINGS_FILE" >/dev/null 2>&1; then
                echo ""
                echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
                echo "📝 Managed settings differ from template"
                echo "   To review/update: chezmoi cd && ./scripts/setup-claude-code-managed-settings"
                echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            fi
        fi
        rm -f "$TEMP_SETTINGS"
    fi
else
    # File doesn't exist
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📝 To install Claude Code managed settings (one-time setup), run:"
    echo "   chezmoi cd && ./scripts/setup-claude-code-managed-settings"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
fi