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
- `home/.chezmoidata/colors.yaml` - centralized Kanagawa Dragon color palette
- `home/dot_gitconfig.tmpl` - templated Git identity
- `home/dot_config/fish/config.fish.tmpl` - Templated Fish shell configuration
- `home/.chezmoitemplates/` - Reusable template fragments
  - `color-hex.tmpl` - Convert color to #hex format (CSS/KDL)
  - `color-quoted.tmpl` - Convert color to "#hex" format (TOML)
  - `color-rgb.tmpl` - Convert hex to rgb() format
  - `color-rgba.tmpl` - Convert hex to rgba() with alpha
  - `color-index.tmpl` - Map color names to terminal indices
  - `newt-colors-kanagawa.tmpl` - Legacy NEWT_COLORS (deprecated)
  - `newt-colors-dynamic.tmpl` - Dynamic NEWT_COLORS from colors.yaml

## Color Template System

### Architecture
- **Single Source of Truth**: All Kanagawa Dragon colors defined in `home/.chezmoidata/colors.yaml`
- **Format Converters**: Template fragments handle format conversions for different config syntaxes
- **Templated Configs**: Waybar CSS, Alacritty TOML, and Niri KDL use centralized colors
- **Ultra-Zen Terminal Colors**: Terminal colors (0-15) map to actual theme colors, not traditional ANSI

### Usage
```go-template
{{- $c := .kanagawa.dragon -}}
color: {{ template "color-hex.tmpl" $c.green }}     # CSS: #8a9a7b
color = {{ template "color-quoted.tmpl" $c.red }}   # TOML: "#c4746e"
```

### Ultra-Zen Philosophy: Semantic Terminal Colors

**"Do not define colors; define intentions. Let the intention manifest as color."**

Terminal colors are semantic purposes, not hues:
- `color0` (background) = `#181616` - Our actual background, not darkest black
- `color7` (foreground) = `#c5c9c5` - Our actual foreground, not brightest white
- `color8` (inactive) = `#625e5a` - Comments/disabled, not just "bright black"
- `color14` (selection) = `#2d4f67` - Primary highlight, not "bright cyan"
- `color11` (highlight) = `#393836` - Subtle emphasis, not "bright yellow"

Each terminal color slot has a PURPOSE:
- **0-7**: Primary semantic roles (background, error, success, warning, etc.)
- **8-15**: Enhanced semantic roles (inactive, urgent, selection, emphasis, etc.)
- Apps express themselves through intentions, not raw colors

### Benefits
- **Perfect Unity**: nmtui background = Waybar background = Alacritty background (#181616)
- **No Jarring Highlights**: Lazygit selection uses muted `#2d4f67` instead of bright cyan
- **Semantic Consistency**: Apps using color14 for selection all get proper highlight color
- **Maintainability**: Change theme by updating single file
- **Extensibility**: Easy to add new apps with consistent theming
- **Semantic Truth**: Colors represent intentions, not traditional ANSI meanings

## Application Configurations

### Color-Templated Applications
- **Waybar** (`style.css.tmpl`) - Full spectrum color usage for module theming
- **Alacritty** (`alacritty.toml.tmpl`) - Terminal base colors (0-15 + extended)
- **Niri** (`config.kdl.tmpl`) - Focus ring and selection colors
- **nmtui** (via `fish/config.fish.tmpl`) - NEWT UI components with semantic mappings

### NetworkManager TUI (nmtui)
- **Color Scheme**: Kanagawa theme from centralized palette
- **Template Architecture**: NEWT_COLORS dynamically generated from `colors.yaml`
- **Theme Mapping**: Semantic color names mapped to terminal indices (color0-color15)
- **Integration**: NEWT component mappings defined in `colors.yaml` under `newt:` section
- **Fish Integration**: Custom wrapper function provides navigation reference
- **Waybar Integration**: Click wifi widget to launch nmtui in Alacritty
- **Limitations**: No vim keybinding support; limited to 16 terminal colors (not RGB)

## Workflow

1. `chezmoi edit ~/.config/app`
2. `chezmoi diff`
3. `chezmoi apply -v`
4. Update relevant documentation (CLAUDE.md, README.md, subdirectory READMEs)

---

*Each configuration choice must earn its place.*