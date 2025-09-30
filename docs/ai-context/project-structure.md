# Project Structure

## Overview
- **Project**: Chezmoi-managed dotfiles following YAGNI principles
- **Source**: `~/.local/share/chezmoi`
- **Target**: `~` (home directory)
- **Root Setting**: `.chezmoiroot` sets `home/` as the source directory root

## Key Directories

### `home/`
Source directory containing all dotfiles (mapped to `~`)

### `home/.chezmoidata/`
Data files for templates:
- `packages.yaml` - Declarative package definitions
- `colors.yaml` - Centralized Kanagawa Dragon color palette
- `keybindings.yaml` - Semantic keybinding definitions

### `home/.chezmoitemplates/`
Reusable template fragments:
- `color-*.tmpl` - Color format converters
- `bitwarden-*.tmpl` - Secret retrieval helpers

### `home/dot_config/`
Application configurations (→ `~/.config/`)
- `fish/` - Fish shell with vi-mode
- `helix/` - Helix editor
- `mpv/` - Media player
- `qutebrowser/` - Web browser
- `niri/` - Wayland compositor
- And many more...

### `home/dot_local/bin/`
Executable scripts (→ `~/.local/bin/`)
- Wrapper scripts for applications
- VPN binding utilities
- Custom tool wrappers

### `scripts/`
Build-time scripts (not deployed):
- `generate-spectrum.py` - Color spectrum generation
- Package management scripts

### `docs/`
Project documentation:
- `docs/ai-context/` - Modular AI context files
- `docs/semantic-color-architecture.md` - Color system docs

## Special Files
- `.chezmoiignore` - Prevent unwanted management
- `CLAUDE.md` - AI assistant instructions
- `README.md` - User-facing documentation