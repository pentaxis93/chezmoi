#!/usr/bin/env bash
set -euo pipefail

# Install Claude Code managed settings to /etc

SETTINGS_FILE="/etc/claude-code/managed-settings.json"

# Create the JSON with proper home directory path
cat <<EOF > /tmp/claude-managed-settings.json
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

# Check if update needed
if [ ! -f "$SETTINGS_FILE" ] || ! diff -q /tmp/claude-managed-settings.json "$SETTINGS_FILE" >/dev/null 2>&1; then
    echo "Installing Claude Code managed settings..."
    sudo mkdir -p /etc/claude-code
    sudo cp /tmp/claude-managed-settings.json "$SETTINGS_FILE"
    sudo chmod 644 "$SETTINGS_FILE"
    echo "✓ Managed settings installed"
else
    echo "✓ Managed settings already up to date"
fi

rm -f /tmp/claude-managed-settings.json