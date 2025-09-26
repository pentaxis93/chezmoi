# Chezmoi Dotfiles

> Simplicity is the ultimate sophistication

**Project**: Chezmoi-managed dotfiles following YAGNI principles
**Source**: `~/.local/share/chezmoi`
**Target**: `~` (home directory)

## Architecture Guidelines

- **CachyOS Support Only** - Package management scripts target CachyOS exclusively
- **Declarative Packages** - System packages defined in `home/.chezmoidata/packages.yaml`

## Commands

```bash
chezmoi apply              # Apply changes to home
chezmoi diff               # Preview changes
chezmoi add <file>         # Track new config
chezmoi edit <file>        # Edit source file
chezmoi cd                 # Enter source directory
chezmoi status             # Check current state
chezmoi data               # View template variables
```

## File Patterns

- `dot_<name>` → `.name`
- `dot_<name>.tmpl` → `.name` (templated)
- `private_<name>` → 0600 permissions
- `executable_<name>` → executable scripts
- `run_<name>` → scripts executed on apply

## Working Principles

1. **Template only when necessary** - machine-specific or secrets
2. **Security first** - never commit secrets, use `private_` prefix
3. **Preview before apply** - `chezmoi diff` then `chezmoi apply -v`

## Configuration Guidelines

When configuring new applications and dotfiles, follow these principles for consistency and elegance:

1. **Unified Color Theme** - Apply consistent color theme across all applications to create visual harmony
2. **Vim Keybindings** - Configure vim keybindings in every tool that supports them for universal editing muscle memory
3. **Keybinding Consistency** - Ensure all keybindings align system-wide for consistent muscle memory
   - If conflicts arise, discuss resolution with human immediately
   - Prioritize most-used actions for primary keybindings
4. **Comprehensive Documentation** - Document everything that can and should be documented
   - In-document comments for complex configs
   - Inline documentation for non-obvious settings
   - Always choose the most discoverable documentation method
5. **Zen Elegance** - Pursue best-in-class functionality while maintaining YAGNI mindfulness
   - Each configuration option must justify its inclusion
   - Prefer defaults when they align with our principles
   - Choose simplicity over complexity when outcomes are equivalent

## Best Practices

- **Preserve Git History** - Use `git mv` instead of delete/create when refactoring files
- **Documentation Synchronization** - After any code change, scan and update all relevant project documentation including:
  - `CLAUDE.md` - Update guidelines when workflows or patterns change
  - `README.md` - Update main documentation for new features or changes
  - Subdirectory `README.md` files (e.g., `scripts/README.md`) - Keep local documentation current
  - **Important**: Documentation updates and code updates are integral parts of the same action - never complete a task without updating affected documentation

## Critical Files

- `.chezmoiroot` - sets `home/` as the source directory root
- `.chezmoiignore` - prevent unwanted management
- `home/.chezmoidata/packages.yaml` - declarative package definitions
- `home/dot_gitconfig.tmpl` - templated Git identity
- `home/dot_config/fish/` - Fish shell configuration

## Workflow

1. `chezmoi edit ~/.config/app`
2. `chezmoi diff`
3. `chezmoi apply -v`
4. Update relevant documentation (CLAUDE.md, README.md, subdirectory READMEs)

---

*Each configuration choice must earn its place.*