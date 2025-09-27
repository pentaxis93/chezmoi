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

- **Fish Shell** — Configuration and aliases with vi mode
- **Git** — Global configuration with user templates
- **Bitwarden CLI** — Secure password management integration
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
      - bitwarden-cli  # Password manager
      - ripgrep  # example: add more packages here
```

After adding packages, run `chezmoi apply` to install them.

### Manage secrets

#### Configuration Data
Non-sensitive configuration is stored in `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
    email = "your.email@example.com"
    github_user = "yourusername"
```

#### Secure Secrets with Bitwarden
Sensitive data is managed through Bitwarden CLI integration:

```bash
# Unlock vault (creates session)
bwu  # or: bw-unlock

# Copy password to clipboard
bwc  # or: bw-copy

# Generate secure password
bwg  # or: bw-generate --copy

# Lock vault when done
bwl  # or: bw-lock
```

Secrets are referenced in templates:
```go-template
# SSH key from secure note
{{ template "bitwarden-note.tmpl" "ssh-private-key" }}

# Password field
{{ template "bitwarden-password.tmpl" "github-pat" }}
```

See example templates in `home/private_dot_ssh/` and `home/private_dot_aws/`.

## Project Structure

```
~/.local/share/chezmoi/
├── README.md                          # This file
├── CLAUDE.md                          # Development guidelines
├── .chezmoidata/
│   └── packages.yaml                  # Declarative package list
├── .chezmoitemplates/                 # Reusable templates
│   ├── bitwarden-*.tmpl               # Secret retrieval helpers
│   └── color-*.tmpl                   # Color format converters
├── dot_config/                        # XDG configs
│   ├── chezmoi/
│   │   └── chezmoi.toml.tmpl          # Chezmoi configuration
│   └── fish/
│       ├── config.fish.tmpl           # Shell configuration
│       └── functions/
│           └── bw-*.fish.tmpl         # Bitwarden utilities
├── dot_gitconfig.tmpl                 # Templated git config
├── private_dot_ssh/                   # SSH keys (examples)
├── private_dot_aws/                   # AWS credentials (examples)
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