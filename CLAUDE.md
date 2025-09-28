# Chezmoi Dotfiles

> Simplicity is the ultimate sophistication

**Project**: Chezmoi-managed dotfiles following YAGNI principles
**Source**: `~/.local/share/chezmoi`
**Target**: `~` (home directory)

## Architecture Guidelines

- **CachyOS Support Only** - Package management scripts target CachyOS exclusively
- **Declarative Packages** - System packages defined in `home/.chezmoidata/packages.yaml`

## Package Installation

- **Declarative Only** - All packages must be added to `home/.chezmoidata/packages.yaml`
- **No Direct Installation** - Never use `pacman`, `yay`, or other package managers directly
- **User Applies Changes** - Only the user should run `chezmoi apply` to install packages
- **Workflow**:
  1. Edit `home/.chezmoidata/packages.yaml` to add/remove packages
  2. Inform user that packages have been added to the manifest
  3. User runs `chezmoi apply` to trigger installation

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
2. **Helix-Native Keybindings** - Configure Helix-native vi keybindings in every tool that supports them for universal editing muscle memory
   - Follow Helix's semantic improvements (e.g., `ge` for end, not `G`)
   - Prioritize semantic clarity over vim tradition
3. **Semantic Keybinding System** - All keybindings represent intentions, not physical keys
   - Define semantic actions that manifest contextually
   - Maintain consistency through `keybindings.yaml`
   - If conflicts arise, discuss resolution with human immediately
4. **Comprehensive Documentation** - Document everything that can and should be documented
   - In-document comments for complex configs
   - Inline documentation for non-obvious settings
   - Always choose the most discoverable documentation method
5. **Zen Elegance** - Pursue best-in-class functionality while maintaining YAGNI mindfulness
   - Each configuration option must justify its inclusion
   - Prefer defaults when they align with our principles
   - Choose simplicity over complexity when outcomes are equivalent

## Secrets Management with Bitwarden

### Ultra-Zen Philosophy: Secure Intentions
**"Secrets flow from vault to configuration through semantic templates"**

### Architecture
- **Bitwarden CLI** (`bw`) - Password manager for secure secret storage
- **Chezmoi Templates** - Reference secrets without storing plaintext
- **Fish Functions** - Semantic wrapper functions for vault operations
- **Auto-lock Security** - Vault locks automatically on terminal exit

### Configuration
- **Vault Config**: `home/dot_config/chezmoi/chezmoi.toml.tmpl` enables auto-unlock
- **Template Helpers**: `home/.chezmoitemplates/bitwarden-*.tmpl` provide reusable secret retrieval
- **Fish Integration**: Custom functions with semantic abbreviations (`bwu`, `bwc`, `bwg`)

### Usage Patterns
```go-template
# SSH Private Key
{{ template "bitwarden-note.tmpl" "ssh-private-key" }}

# Password Field
{{ template "bitwarden-password.tmpl" "github-pat" }}

# Custom Fields
{{ (bitwardenFields "item" "api-keys").api_key.value }}
```

### Security Guarantees
- Vault remains encrypted at rest (`~/.config/Bitwarden CLI/data.json`)
- Session keys are ephemeral (environment variable only)
- No secrets in git repository (only template references)
- Auto-lock on terminal exit prevents session persistence

### Example Files
- `home/private_dot_ssh/private_id_rsa.tmpl.example` - SSH key management
- `home/private_dot_aws/credentials.tmpl.example` - AWS credentials
- `home/dot_config/env.tmpl.example` - Environment variables with secrets

## VPN Configuration with OpenVPN

### Ultra-Zen Philosophy: Secure Tunneling
**"The path to the network flows through the vault, authenticated and encrypted"**

### Architecture
- **OpenVPN Client** - Secure tunneling daemon for VPN connections
- **Bitwarden Integration** - Credentials retrieved from vault via templates
- **Fish Functions** - Semantic wrappers for connection management (`vpc`, `vpd`, `vps`)
- **Systemd Service** - Optional user-level service for automatic connection

### Configuration Files
- **VPN Config**: `home/dot_config/private_openvpn/goosevpn.conf.tmpl` - Main OpenVPN configuration
- **Auth File**: `home/dot_local/state/private_secrets/openvpn/goosevpn-auth.tmpl` - Credentials from Bitwarden
- **Service**: `home/dot_config/systemd/user/goosevpn.service.tmpl` - Systemd service (optional)
- **Auto-loading**: `home/dot_config/fish/conf.d/00-secrets.fish.tmpl` - Loads secrets into environment

### Usage
```bash
vpc  # Connect to VPN (vpn-connect)
vpd  # Disconnect from VPN (vpn-disconnect)
vps  # Check VPN status (vpn-status)

# Or use systemd (after enabling)
systemctl --user start goosevpn
systemctl --user enable goosevpn  # Auto-connect on boot
```

### Security Features
- All config files use `private_` prefix (600 permissions)
- `auth-nocache` prevents password caching in memory
- Credentials only exist when Bitwarden is unlocked
- Secrets stored in `~/.local/state/secrets/` outside project directories
- Environment variables auto-loaded by Fish for script access

## Secure Secrets Architecture

### Ultra-Zen Philosophy: Isolated Secrets
**"Secrets dwell in their own realm, beyond the reach of wandering eyes"**

### Architecture
- **Secrets Directory**: `~/.local/state/secrets/` - All secrets outside project paths
- **Auto-loading**: Fish conf.d loads secrets into environment on shell startup
- **Environment Variables**: Secrets available as `GOOSE_VPN_USER`, `GOOSE_VPN_PASS`, etc.

### Directory Structure
```
~/.local/state/secrets/
├── openvpn/          # VPN credentials
│   └── goosevpn-auth
├── env/              # Environment variable files
│   └── vpn-config    # VPN configuration vars
└── ssh/              # Future: SSH keys
```

### Security Benefits
- Secrets isolated from project directories and Git repositories
- Single location for all sensitive data
- Foundation for future enhancements (encryption, systemd-creds)
- Works around Claude Code's broken deny permissions

## Transmission BitTorrent with VPN Killswitch

### Ultra-Zen Philosophy: Secure Torrenting
**"The river flows only through the secure tunnel; when the tunnel closes, the river stops"**

### Architecture
- **Transmission Daemon** - BitTorrent client bound to VPN interface IP
- **VPN Killswitch** - Transmission stops automatically if VPN disconnects
- **Minimal Seeding** - Ultra-low upload limits (10KB/s, 0.1 ratio, 5min idle)
- **Security Hardened** - Required encryption, no DHT/PEX/LPD, blocklist enabled
- **Tremc TUI** - Kanagawa-themed terminal interface with vi keybindings

### Configuration Files
- **Daemon Config**: `home/dot_config/transmission-daemon/settings.json.tmpl` - Security-focused settings
- **VPN Binding**: `home/dot_local/bin/executable_transmission-vpn-bind.tmpl` - Dynamic IP updater
- **Systemd Service**: `home/dot_config/systemd/user/transmission-daemon.service.tmpl` - VPN-dependent service
- **Fish Functions**: `home/dot_config/fish/functions/t*.fish.tmpl` - Semantic management commands
- **Tremc Config**: `home/dot_config/tremc/settings.cfg.tmpl` - Kanagawa theme and vi navigation

### Usage
```bash
tstart   # Start transmission (checks VPN, updates binding)
tstop    # Stop transmission daemon
tstatus  # Show daemon and VPN binding status
tadd     # Add torrent file or magnet link
tlist    # List active torrents
tremove  # Remove torrent by ID
tui      # Launch tremc interface
```

### Security Features
- **Bind to VPN IP** - Only works when VPN is connected (bind-address-ipv4)
- **Auto-stop on VPN disconnect** - Killswitch via systemd BindsTo
- **Minimal upload** - 10KB/s limit, 0.1 ratio, 5-minute idle timeout
- **Full encryption** - Peer connections require encryption
- **No discovery** - DHT, PEX, LPD all disabled for privacy
- **Random ports** - New peer port on each start
- **Download to ~/Videos** - Organized media storage

### VPN Integration
- Transmission service depends on goosevpn.service
- VPN IP dynamically detected and bound on startup
- Fish conf.d hook monitors VPN status
- Manual `tstart` includes automatic VPN check

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
- `home/.chezmoidata/keybindings.yaml` - semantic keybinding definitions
- `home/dot_gitconfig.tmpl` - templated Git identity
- `home/dot_config/chezmoi/chezmoi.toml.tmpl` - Chezmoi configuration with Bitwarden integration
- `home/dot_config/fish/config.fish.tmpl` - Templated Fish shell configuration
- `home/dot_config/fish/functions/bw-*.fish.tmpl` - Bitwarden wrapper functions
- `home/dot_config/fish/functions/vpn-*.fish.tmpl` - VPN management functions
- `home/dot_config/private_openvpn/` - OpenVPN configuration files
- `home/dot_config/systemd/user/goosevpn.service.tmpl` - VPN systemd service
- `home/dot_config/transmission-daemon/settings.json.tmpl` - Transmission daemon configuration
- `home/dot_config/fish/functions/t*.fish.tmpl` - Transmission management functions
- `home/dot_config/systemd/user/transmission-daemon.service.tmpl` - Transmission systemd service
- `home/dot_config/tremc/settings.cfg.tmpl` - Tremc TUI configuration
- `home/dot_local/bin/executable_transmission-vpn-bind.tmpl` - VPN binding script
- `home/dot_config/fish/conf.d/10-transmission-vpn.fish.tmpl` - Transmission VPN monitor
- `home/.chezmoitemplates/` - Reusable template fragments
  - `color-hex.tmpl` - Convert color to #hex format (CSS/KDL)
  - `color-quoted.tmpl` - Convert color to "#hex" format (TOML)
  - `color-rgb.tmpl` - Convert hex to rgb() format
  - `color-rgba.tmpl` - Convert hex to rgba() with alpha
  - `color-index.tmpl` - Map color names to terminal indices
  - `newt-colors-kanagawa.tmpl` - Legacy NEWT_COLORS (deprecated)
  - `newt-colors-dynamic.tmpl` - Dynamic NEWT_COLORS from colors.yaml
  - `bitwarden-item.tmpl` - Retrieve complete Bitwarden item
  - `bitwarden-password.tmpl` - Extract password field from item
  - `bitwarden-username.tmpl` - Extract username field from item
  - `bitwarden-note.tmpl` - Extract secure note content

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

### Ultra-Zen Philosophy: Semantic Terminal Colors & Reverse Video

**"Do not define colors; define intentions. Let the intention manifest as color."**

Terminal colors are semantic purposes, not hues:
- `color0` (background) = `#181616` - Our actual background, not darkest black
- `color7` (foreground) = `#c5c9c5` - Our actual foreground, not brightest white
- `color8` (inactive) = `#625e5a` - Comments/disabled, not just "bright black"
- `color14` (focus) = `#8a9a7b` - Focus/active indicator (our green), NOT selection bg
- `color11` (warning_bright) = `#c4b28a` - Actual yellow for warnings/emphasis

**The Master's Wisdom on Selection:**
*"Do not paint the water to make the fish visible. Let the fish and water exchange places."*

Selections use **reverse video**, not colored backgrounds. This ensures:
- Perfect contrast always (fg/bg swap)
- No configuration complexity
- Universal solution for all TUI apps

Each terminal color slot has a PURPOSE:
- **0-7**: Primary semantic roles (background, error, success, warning, etc.)
- **8-15**: Enhanced semantic roles (inactive, urgent, focus, emphasis, etc.)
- Apps express themselves through intentions, not raw colors

### Benefits
- **Perfect Unity**: nmtui background = Waybar background = Alacritty background (#181616)
- **Perfect Contrast**: Lazygit selections use reverse video - always readable
- **Semantic Consistency**: color14 is focus/active (green), not selection background
- **Maintainability**: Change theme by updating single file
- **Extensibility**: Easy to add new apps with consistent theming
- **Semantic Truth**: Colors represent intentions, not traditional ANSI meanings

## Semantic Keybinding System

### Ultra-Zen Philosophy: Semantic Actions

**"Do not define keybindings; define intentions. Let the intention manifest as the appropriate key."**

Just as colors became semantic purposes, keybindings are semantic **intentions** that manifest contextually:

```yaml
# Instead of: MOD+H = move left
# We define: navigate.prev = context-appropriate leftward movement
```

### Architecture
- **Single Source of Truth**: All semantic actions defined in `home/.chezmoidata/keybindings.yaml`
- **Helix-Native**: Follow Helix's thoughtful semantic improvements as our foundation
- **Context Manifestation**: Same intention manifests appropriately per application
- **Vi Mode Everywhere**: Fish shell, Alacritty terminal, and Helix editor all use vi modes

### Core Semantic Categories
- **Navigate**: Move focus without changing state (hjkl universally)
- **Manipulate**: Move/modify objects (MOD+CTRL+hjkl for windows)
- **Invoke**: Create/summon/launch (MOD+key for apps)
- **Transform**: Toggle states/modes (f for fullscreen, i/v/ESC for modes)
- **Preserve**: Save state (SPACE+W for write)
- **Dismiss**: Close/quit (q/Q universally)
- **Discover**: Search/help (/ for search, ? for help)

### Helix-Native Navigation
- `ge` instead of `G`: "Go end" is semantically clearer
- `gh/gl` for line start/end: "Go home/line" is intuitive
- `x` for extend: Direct selection without mode change
- `g` prefix groups all "go to" operations

### Benefits
- **Muscle Memory Unity**: Same semantic action = same key pattern everywhere
- **No Conflicts**: Semantic layer prevents accidental overlaps
- **Self-Documenting**: Intentions explain themselves
- **Extensibility**: New apps inherit semantic patterns automatically

### Documentation
- **Reference**: See `home/KEYBINDINGS.md` for complete semantic mappings
- **Definition**: `home/.chezmoidata/keybindings.yaml` contains all semantic actions

## Application Configurations

### Color-Templated Applications
- **Waybar** (`style.css.tmpl`) - Full spectrum color usage for module theming
- **Alacritty** (`alacritty.toml.tmpl`) - Terminal base colors (0-15 + extended)
- **Niri** (`config.kdl.tmpl`) - Focus ring and selection colors
- **nmtui** (via `fish/config.fish.tmpl`) - NEWT UI components with semantic mappings

### Vi-Mode Enabled Applications
- **Fish Shell** (`config.fish.tmpl`) - Vi mode with Helix-native keybindings
  - Mode indicators: `[N]` green, `[I]` blue, `[V]` yellow
  - Cursor changes per mode: block/line/underscore
  - Custom bindings: `ge` for end, `gh/gl` for line navigation
- **Alacritty Terminal** (`alacritty.toml.tmpl`) - Vi mode with visual feedback
  - Toggle: `CTRL+SHIFT+SPACE`
  - Green block cursor in vi mode
  - Supports Helix-native navigation
- **Helix Editor** (`config.toml`) - Native modal editing
  - SPACE leader for commands
  - Full Helix semantic navigation

### NetworkManager TUI (nmtui)
- **Color Scheme**: Kanagawa theme from centralized palette
- **Template Architecture**: NEWT_COLORS dynamically generated from `colors.yaml`
- **Theme Mapping**: Semantic color names mapped to terminal indices (color0-color15)
- **Integration**: NEWT component mappings defined in `colors.yaml` under `newt:` section
- **Fish Integration**: Custom wrapper function provides navigation reference
- **Waybar Integration**: Click wifi widget to launch nmtui in Alacritty
- **Limitations**: No vim keybinding support; limited to 16 terminal colors (not RGB)

### Transmission BitTorrent (`transmission-daemon`)
- **VPN Binding**: Bound to VPN interface IP (killswitch if VPN disconnects)
- **Security Hardened**: Required encryption, minimal seeding, no peer discovery
- **Download Location**: `~/Videos` with incomplete files in `.incomplete` subdirectory
- **Fish Functions**: `tstart`, `tstop`, `tstatus`, `tadd`, `tlist`, `tremove`
- **Systemd Integration**: Depends on goosevpn.service, auto-stops if VPN fails
- **Dynamic IP Binding**: `transmission-vpn-bind` script updates bind address

### Tremc TUI (`tremc`)
- **Kanagawa Theme**: Full color customization from centralized palette
- **Vi Keybindings**: Helix-native navigation (hjkl, ge for end)
- **Launch Command**: `tui` function auto-starts daemon if needed
- **Profile Support**: Pre-configured filters for active/downloading/seeding
- **Confirmation Dialogs**: Protects against accidental removal/deletion

## Workflow

1. `chezmoi edit ~/.config/app`
2. `chezmoi diff`
3. `chezmoi apply -v`
4. Update relevant documentation (CLAUDE.md, README.md, subdirectory READMEs)

---

*Each configuration choice must earn its place.*