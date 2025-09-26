# Chezmoi Dotfiles

> Simplicity is the ultimate sophistication

**Project**: Chezmoi-managed dotfiles following YAGNI principles
**Source**: `~/.local/share/chezmoi`
**Target**: `~` (home directory)

## Architecture Guidelines

- **CachyOS Support Only** - Package management scripts target CachyOS exclusively
- **Declarative Packages** - System packages defined in `.chezmoidata/packages.yaml`

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

## Best Practices

- **Preserve Git History** - Use `git mv` instead of delete/create when refactoring files

## Critical Files

- `.chezmoiignore` - prevent unwanted management
- `dot_gitconfig.tmpl` - templated Git identity
- `dot_config/fish/` - Fish shell configuration

## Workflow

1. `chezmoi edit ~/.config/app`
2. `chezmoi diff`
3. `chezmoi apply -v`

---

*Each configuration choice must earn its place.*