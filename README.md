# Dotfiles

Personal configuration files managed with [chezmoi](https://www.chezmoi.io/).

**OS Support**: CachyOS (Arch-based) only

## Quick Start

### Prerequisites
- `chezmoi` ([installation guide](https://www.chezmoi.io/install/))
- `git`

### Setup

```bash
# Initialize from this repository
chezmoi init https://github.com/yourusername/dotfiles.git

# Preview changes
chezmoi diff

# Apply configuration
chezmoi apply -v
```

### Updates

```bash
# Pull and apply latest changes
chezmoi update -v
```

## What's Included

- **Fish Shell** — Configuration and aliases
- **Git** — Global configuration with user templates
- **Claude Code** — Development environment settings
- **Package Management** — Declarative system package installation

## Common Tasks

### Add a configuration

```bash
# Add a file to chezmoi management
chezmoi add ~/.config/app

# Add with automatic templating
chezmoi add --autotemplate ~/.config/app/config.toml
```

### Edit a configuration

```bash
# Edit in source directory
chezmoi edit ~/.config/fish/config.fish

# Preview changes
chezmoi diff

# Apply changes
chezmoi apply -v
```

### Manage packages

System packages are declared in `.chezmoidata/packages.yaml`:

```yaml
packages:
  cachyos:
    pacman:
      - npm
      - ripgrep  # example: add more packages here
```

After adding packages, run `chezmoi apply` to install them.

### Manage secrets

Secrets are handled through templates and stored locally in `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
    email = "your.email@example.com"
    github_user = "yourusername"
```

## Project Structure

```
~/.local/share/chezmoi/
├── README.md                          # This file
├── CLAUDE.md                          # Development guidelines
├── .chezmoidata/
│   └── packages.yaml                  # Declarative package list
├── dot_config/                        # XDG configs
│   └── fish/
├── dot_gitconfig.tmpl                 # Templated git config
├── private_dot_gitignore              # Global gitignore (0600)
├── run_onchange_install-packages.sh.tmpl  # Package installation
└── run_after_*.sh                     # Post-apply hooks
```

## File Naming Convention

- `dot_<name>` → `.name`
- `dot_<name>.tmpl` → `.name` (with templating)
- `private_<name>` → 0600 permissions
- `executable_<name>` → executable scripts
- `run_once_` → run once on first apply
- `run_onchange_` → run when file content changes
- `run_after_` → run after each apply

## Troubleshooting

```bash
# Check configuration
chezmoi doctor

# Verify managed files
chezmoi managed

# See what would change
chezmoi apply --dry-run -v
```

## Philosophy

Simplicity over complexity. Each configuration serves a clear purpose.