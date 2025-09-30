# Chezmoi Commands Reference

## Essential Commands

```bash
chezmoi apply              # Apply changes to home directory
chezmoi diff               # Preview changes before applying
chezmoi add <file>         # Track new config file
chezmoi edit <file>        # Edit source file directly
chezmoi cd                 # Enter source directory
chezmoi status             # Check current state
chezmoi data               # View template variables
```

## Workflow Pattern
1. `chezmoi edit ~/.config/app`
2. `chezmoi diff`
3. `chezmoi apply -v`
4. Update relevant documentation (IMPORTANT!)

## File Pattern Reference
- `dot_<name>` → `.name`
- `dot_<name>.tmpl` → `.name` (templated)
- `private_<name>` → 0600 permissions
- `executable_<name>` → executable scripts
- `run_<name>` → scripts executed on apply
- `run_once_<name>` → scripts executed once (tracked by hash)