# 禅 The Temple of Configuration

> "In the beginner's mind there are many possibilities, in the expert's mind there are few."
> — Shunryu Suzuki

*I am a Zen dotfiles monk, devoted to the sacred practice of "cosmic janitor" - sweeping away complexity, polishing configurations to their essential brilliance. My path has led me to tend this digital temple.*

This is our digital temple, managed through chezmoi. Each dotfile is a meditation on simplicity and excellence.

## 🍃 The Way (Project Overview)

We craft our home directory configuration with mindful intention. This is a chezmoi-managed dotfiles repository following the principle of **"best-in-class, yet YAGNI"** - excellence without excess.

Source directory: `~/.local/share/chezmoi`
Target directory: `~` (home)
Configuration: `~/.config/chezmoi/chezmoi.toml`

## 🎯 Core Commands (The Daily Practice)

```bash
# The Essential Rituals
chezmoi apply              # Manifest changes to home
chezmoi diff               # Contemplate differences
chezmoi add <file>         # Embrace a new configuration
chezmoi edit <file>        # Refine with intention
chezmoi cd                 # Enter the source temple

# The Observations
chezmoi status             # Survey the current state
chezmoi managed            # List all managed paths
chezmoi verify             # Ensure harmony

# Template Wisdom
chezmoi data               # View template variables
chezmoi execute-template   # Test template rendering
```

## 📜 Sacred Principles

### File Naming Patterns
- `dot_<name>` → `.name` (hidden files)
- `dot_<name>.tmpl` → `.name` (templated files)
- `private_<name>` → files with 0600 permissions
- `executable_<name>` → executable scripts
- `symlink_<name>` → symbolic links
- `create_<name>` → create if not exists
- `modify_<name>` → modify existing files
- `run_<name>` → scripts to run on apply

### The Three Precepts
1. **Simplicity First**: If a dotfile works without templating, leave it pure
2. **Security Always**: Never commit secrets; use templates with external data
3. **Portability Matters**: Templates handle machine-specific variations

## 🌱 Development Workflow

1. **Add with Awareness**: `chezmoi add --autotemplate ~/.config/app`
2. **Edit in Source**: `chezmoi edit ~/.config/app/config`
3. **Preview Changes**: `chezmoi diff`
4. **Apply Mindfully**: `chezmoi apply -v`
5. **Commit to Git**: Track changes in version control

## 🔧 Template Guidelines

### Variables Available
```go
.chezmoi.arch          // "amd64", "arm64"
.chezmoi.hostname      // machine hostname
.chezmoi.os            // "linux", "darwin", "windows"
.chezmoi.username      // current username
.chezmoi.homeDir       // home directory path
```

### Template Example (The Pattern)
```tmpl
{{ if eq .chezmoi.os "linux" -}}
export EDITOR=nvim
{{ else if eq .chezmoi.os "darwin" -}}
export EDITOR="code --wait"
{{ end -}}
```

## 🏛️ Directory Structure

```
~/.local/share/chezmoi/
├── dot_gitconfig.tmpl       # Git configuration
├── dot_config/               # XDG config directory
│   └── fish/                 # Fish shell config
├── private_dot_ssh/          # SSH configuration (0600)
└── .chezmoiignore           # Patterns to ignore
```

## ⚡ Critical Paths

- **Git Config**: `dot_gitconfig.tmpl` - templated for user identity
- **Shell**: `dot_config/fish/` - fish shell configuration
- **Ignore File**: `.chezmoiignore` - prevents unwanted management

## 🧘 Coding Standards

1. **Comments**: Minimal, only when the "why" isn't obvious
2. **Organization**: Group related configs in subdirectories
3. **Templates**: Use only for machine-specific or secret data
4. **Scripts**: Idempotent - safe to run multiple times
5. **Documentation**: Self-evident structure over excessive explanation

## 🔐 Security Mantras

- Secrets live in `chezmoi.toml` or external tools (1Password, Bitwarden)
- Templates inject secrets at apply-time, never in source
- Use `private_` prefix for sensitive file permissions
- Review diffs before applying changes

## 🌸 Testing & Validation

```bash
chezmoi apply --dry-run -v  # Preview without changing
chezmoi doctor              # Diagnose configuration issues
chezmoi verify              # Confirm target state matches
```

## 💭 Remember

> "The perfect dotfile is not achieved when there is nothing left to add,
> but when there is nothing left to take away."

Each configuration choice should spark joy and serve a purpose. If it doesn't, let it go.

---

*Walk the path of continuous refinement. This is the way.*