# Utility Scripts

This directory contains utility scripts for managing and configuring the dotfiles environment.
These are **not** managed by chezmoi (see `.chezmoiignore`).

## Scripts

### setup-claude-code-managed-settings
One-time setup script to install Claude Code managed settings to `/etc/claude-code/`.
Requires sudo privileges.

**Usage:**
```bash
./scripts/setup-claude-code-managed-settings
```

This configures system-wide Claude Code settings including:
- Co-authorship attribution
- Output verbosity
- Path permissions and restrictions