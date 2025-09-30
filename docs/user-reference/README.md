# User Reference Documentation

This directory contains comprehensive user-facing reference documentation for the dotfiles system.

## Contents

### [KEYBINDINGS.md](./KEYBINDINGS.md)
Complete semantic keybinding reference with application-specific quick reference cards.

- **Philosophy**: Semantic intentions that manifest as context-appropriate keys
- **Helix-Native**: Uses `ge`, `gh/gl` for improved navigation
- **Universal Patterns**: Same intentions across all applications
- **Quick References**: Cheat sheets for Niri, Qutebrowser, MPV, LF, Fish, Alacritty, Lazygit, and Wiremix
- **Conflict Resolution**: Documentation of intentional context-dependent meanings

### [semantic-color-architecture.md](./semantic-color-architecture.md)
Complete semantic color system architecture and reference.

- **Two-Layer System**: Themes (colors) + Semantic (meanings)
- **Theme-Agnostic**: Change themes without touching configs
- **Template Fragments**: Format converters for different syntaxes
- **Comprehensive Coverage**: 38 semantic colors across 8 categories

## For AI Assistants

If you need AI-specific context and instructions, see `../ai-context/` instead. This directory is for **human users**.

## Technical Documentation

For implementation details:
- **Implementation**: See `../../home/.chezmoidata/*.yaml` (colors.yaml, keybindings.yaml)
- **AI Context**: See `../ai-context/systems/` for technical system documentation
