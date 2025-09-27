# Dotfiles Migration Roadmap: Bare Git → Chezmoi

## Executive Summary

This roadmap guides the migration from your comprehensive bare git dotfiles (`~/dotfiles-review`) to the superior chezmoi architecture while preserving all functionality and adding new capabilities. The migration leverages chezmoi's templating, declarative package management, and clean separation of source/target while incorporating all the tools, scripts, and configurations from the original setup.

**Timeline**: 8 weeks (can be accelerated based on available time)
**Strategy**: Phased approach maintaining working system throughout
**Philosophy**: Keep YAGNI principles, Kanagawa Dragon theming, vim-everywhere mindset

## Core Principles

### Keep from Chezmoi
- **Clean Architecture**: Source at `~/.local/share/chezmoi`, target at `~`
- **Template System**: Machine-specific configs via Go templates
- **Centralized Colors**: Single `colors.yaml` driving all themes
- **Semantic Terminal Colors**: Ultra-Zen reverse video philosophy
- **Declarative Packages**: YAML-based package management
- **Built-in Commands**: `chezmoi diff/apply/status` workflow

### Adopt from Old Dotfiles
- **Complete Package List**: 44+ essential tools
- **Bootstrap Automation**: System setup scripts
- **Utility Scripts**: brightness, snapshots, pass management
- **Desktop Stack**: Window manager, bar, compositor
- **Media Configuration**: MPV with file browser
- **Security Tools**: Pass/GPG for API keys

### Improve Upon Both
- **Unified Keybindings**: System-wide vim consistency
- **Documentation**: Maintain docs alongside code
- **Testing**: Validate each phase before proceeding
- **Modularity**: Component-based architecture

## Phase 1: Foundation (Week 1-2)

### 1.1 Package Declaration Migration
**Goal**: Convert text-based package lists to chezmoi YAML format

```yaml
# home/.chezmoidata/packages.yaml
packages:
  cachyos:
    pacman:
      # Core system
      - base-devel
      - git
      - curl
      - wget
      - man-db
      # Terminal environment
      - alacritty
      - fish
      - tmux
      - helix
      # File management
      - thunar
      - ripgrep
      - fd
      - fzf
      - bat
      - eza
      - zoxide
      # System monitoring
      - btop
      - neofetch
      # Development
      - github-cli
      - lazygit
      - npm
      # Media
      - mpv
      - pipewire
      - pipewire-pulse
      - pipewire-alsa
      - wireplumber
      - pavucontrol
      # Security
      - bitwarden-cli
      - pass
      # Desktop (decide: niri vs bspwm)
      - niri  # or bspwm + sxhkd + polybar + picom
      - waybar  # or polybar
      - wofi  # or rofi
      # Browser
      - qutebrowser
      # Utilities
      - xclip
      - numlockx
      - gsimplecal
      - unzip
      - uv
      - python-tldextract
      - python-pyperclip

    aur:
      - ttf-meslo-nerd-font-powerlevel10k
      - ttf-font-awesome
      - noto-fonts-emoji
      - claude-code
      - gruvbox-material-gtk-theme-git  # or kanagawa theme
      - papirus-folders-git
```

### 1.2 Shell Configuration

#### Fish Shell
Port essential configs maintaining chezmoi templating:

```fish
# home/dot_config/fish/config.fish.tmpl
{{- $c := .kanagawa.dragon -}}
# Core environment
set -gx EDITOR helix
set -gx VISUAL helix
set -gx SHELL /bin/fish
set -gx TERM xterm-256color

# Vi mode (mandatory)
fish_vi_key_bindings

# Path management
contains ~/.local/bin $PATH; or set -gxa PATH ~/.local/bin $PATH

# FZF with Kanagawa colors
set -gx FZF_DEFAULT_OPTS "
  --color=bg+:{{ $c.selection }},bg:{{ $c.bg_dark }}
  --color=hl+:{{ $c.yellow }},hl:{{ $c.blue }}
  --color=fg+:{{ $c.fg_primary }},fg:{{ $c.fg_default }}
  --color=info:{{ $c.cyan }},prompt:{{ $c.green }}
  --color=pointer:{{ $c.magenta }},marker:{{ $c.red }}
  --height 40% --layout=reverse --border --info=inline"

# Initialize tools
type -q zoxide && zoxide init fish | source

# Port all abbreviations from old config...
```

#### Tmux Configuration
Create templated tmux config with Kanagawa colors:

```tmux
# home/dot_tmux.conf.tmpl
{{- $c := .kanagawa.dragon -}}
# Fish as default
set-option -g default-shell /bin/fish

# Vi mode everywhere
setw -g mode-keys vi

# Kanagawa Dragon status bar
set -g status-bg "{{ $c.bg_dark }}"
set -g status-fg "{{ $c.fg_default }}"
set -g window-status-current-style "bg={{ $c.selection }},fg={{ $c.fg_primary }}"

# Mouse support with clipboard integration
set -g mouse on
set -g set-clipboard on

# System clipboard integration
bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -i -sel clip"
```

### 1.3 Utility Scripts Migration

Create chezmoi-managed scripts in `home/dot_local/bin/`:

```bash
# home/dot_local/bin/executable_brightness
#!/usr/bin/env bash
# Brightness control script
# (Port from old dotfiles with improvements)

# home/dot_local/bin/executable_pass-refresh
#!/usr/bin/env bash
# GPG/Pass refresh utility
# (Port with Kanagawa-colored output)

# home/dot_local/bin/executable_snapshot-*
# Snapshot management suite
```

**Validation**:
- [ ] All packages install via `chezmoi apply`
- [ ] Fish shell loads with vi mode
- [ ] Tmux works with proper colors
- [ ] Utility scripts are executable and in PATH

## Phase 2: Desktop Environment (Week 3-4)

### 2.1 Window Manager Decision

**Option A: Continue with Niri (Wayland)**
- Modern scrolling compositor
- Already configured with Kanagawa
- Better for future-proofing
- Missing: Some X11-only tools

**Option B: Migrate to BSPWM (X11)**
- All old configs work immediately
- Polybar integration tested
- Full script ecosystem
- Missing: Wayland benefits

**Recommendation**: Stick with Niri, port essential features

### 2.2 Niri Configuration Enhancement

Enhance existing config with missing features:

```kdl
// home/dot_config/niri/config.kdl.tmpl
{{- $c := .kanagawa.dragon -}}

// Port BSPWM workspace concepts
workspace-defaults {
    border-color {{ template "color-hex.tmpl" $c.selection }}
    gaps 0  // Like BSPWM config
}

// Add all keybindings from sxhkdrc
binds {
    // Application launches
    MOD+Return { spawn-sh "alacritty"; }
    MOD+D { spawn-sh "wofi --show drun"; }

    // Port polybar-like functionality to waybar
    MOD+B { spawn-sh "pkill -SIGUSR1 waybar"; }  // Toggle bar

    // Media controls from old setup
    MOD+M { spawn-sh "mpv ~/Videos"; }
}
```

### 2.3 Waybar Configuration

Enhance waybar to match polybar functionality:

```css
/* home/dot_config/waybar/style.css.tmpl */
/* Port window title widget */
#window {
    /* Implement polybar's window-title-daemon behavior */
}

/* Add all missing modules */
#custom-media {
    /* MPV integration */
}
```

**Validation**:
- [ ] Desktop environment starts correctly
- [ ] All keybindings work
- [ ] Bar shows all needed information
- [ ] Window management feels natural

## Phase 3: Applications (Week 5-6)

### 3.1 Terminal Applications

#### Helix Editor
Enhance current config with missing features:

```toml
# home/dot_config/helix/config.toml.tmpl
theme = "kanagawa"  # Create custom Kanagawa theme

[editor]
line-number = "relative"
cursorline = true
color-modes = true

[editor.lsp]
display-messages = true
display-inlay-hints = true

# Port any vim muscle memory bindings
[keys.normal]
# ... extensive keybinding port
```

#### Lazygit
Port with Kanagawa theme:

```yaml
# home/dot_config/lazygit/config.yml.tmpl
gui:
  theme:
    lightTheme: false
    activeBorderColor:
      - "{{ .kanagawa.dragon.green }}"
    inactiveBorderColor:
      - "{{ .kanagawa.dragon.selection }}"
```

### 3.2 Browser Configuration

#### Qutebrowser
Full configuration with vim bindings and Kanagawa:

```python
# home/dot_config/qutebrowser/config.py.tmpl
# Kanagawa Dragon theme
c.colors.completion.category.bg = '{{ .kanagawa.dragon.bg_dark }}'
c.colors.completion.category.fg = '{{ .kanagawa.dragon.fg_primary }}'

# Vim bindings (already default in qutebrowser)
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')
```

### 3.3 Media Setup

#### MPV with File Browser
Port complete MPV configuration:

```conf
# home/dot_config/mpv/mpv.conf.tmpl
# Resume playback
save-position-on-quit=yes
watch-later-directory=~/.local/state/mpv/watch_later/

# UI theme
osd-color='{{ .kanagawa.dragon.fg_primary }}'
osd-border-color='{{ .kanagawa.dragon.selection }}'
```

Install file browser script:
```bash
# home/run_once_install-mpv-scripts.sh
#!/bin/bash
mkdir -p ~/.config/mpv/scripts
curl -L https://github.com/CogentRedTester/mpv-file-browser/raw/master/file-browser.lua \
  -o ~/.config/mpv/scripts/file-browser.lua
```

**Validation**:
- [ ] All editors use vim bindings
- [ ] Consistent Kanagawa theme everywhere
- [ ] MPV file browser works with MENU/b key
- [ ] Browser configured and functional

## Phase 4: Security & Automation (Week 7)

### 4.1 Pass/GPG Setup

Create chezmoi-managed GPG and Pass configuration:

```bash
# home/run_once_setup-pass.sh.tmpl
#!/bin/bash
# Initialize pass with GPG
pass init {{ .gpg.key_id }}

# Setup GPG agent with proper caching
cat > ~/.gnupg/gpg-agent.conf <<EOF
default-cache-ttl 604800
max-cache-ttl 2592000
pinentry-program /usr/bin/pinentry-curses
EOF
```

### 4.2 API Key Management

Port pass-refresh and integrate with chezmoi secrets:

```bash
# home/dot_local/bin/executable_pass-refresh
#!/usr/bin/env bash
# Enhanced pass refresh with chezmoi integration
# ... (port from old dotfiles)
```

### 4.3 MCP Server Setup

Configure MCP servers with chezmoi templates:

```bash
# home/run_once_setup-mcp.sh.tmpl
#!/bin/bash
# Install MCP servers
# Configure with API keys from pass
```

**Validation**:
- [ ] GPG keys work properly
- [ ] Pass can store/retrieve secrets
- [ ] API keys accessible to MCP servers
- [ ] Claude Code configuration complete

## Phase 5: Polish & Integration (Week 8)

### 5.1 Theme Consistency Audit

Verify Kanagawa Dragon everywhere:
- [ ] Terminal (alacritty)
- [ ] Shell prompt (fish)
- [ ] Editor (helix)
- [ ] Multiplexer (tmux)
- [ ] Window manager (niri)
- [ ] Bar (waybar)
- [ ] Browser (qutebrowser)
- [ ] Media player (mpv)
- [ ] Git tools (lazygit)
- [ ] System monitor (btop)

### 5.2 Keybinding Consistency

Ensure vim bindings everywhere possible:
- [ ] Shell (fish vi-mode)
- [ ] Editor (helix)
- [ ] Browser (qutebrowser)
- [ ] File manager (if applicable)
- [ ] Window manager navigation

### 5.3 Documentation Update

Update all documentation:
- [ ] Update CLAUDE.md with new workflows
- [ ] Update README.md with setup instructions
- [ ] Create component-specific docs in subdirectories
- [ ] Document all custom scripts

### 5.4 Testing Checklist

Complete system validation:
- [ ] Fresh `chezmoi init` works
- [ ] All packages install correctly
- [ ] Desktop environment starts
- [ ] All keybindings function
- [ ] Colors consistent everywhere
- [ ] Scripts have proper permissions
- [ ] Secrets properly managed
- [ ] Documentation complete

## Migration Commands Reference

```bash
# Phase 1: Foundation
chezmoi edit ~/.chezmoidata/packages.yaml
chezmoi apply --dry-run  # Test package installation
chezmoi apply  # Execute

# Phase 2: Desktop
chezmoi add ~/.config/niri
chezmoi add ~/.config/waybar

# Phase 3: Applications
chezmoi add ~/.config/helix
chezmoi add ~/.config/qutebrowser
chezmoi add ~/.config/mpv

# Phase 4: Security
chezmoi execute-template < ~/.local/share/chezmoi/home/run_once_setup-pass.sh.tmpl | bash

# Phase 5: Validation
chezmoi diff  # Review all changes
chezmoi doctor  # Check system
```

## Success Metrics

- **Architecture**: Clean separation maintained
- **Functionality**: All old features work + new improvements
- **Performance**: System feels snappier than before
- **Maintainability**: Changes easier than bare git
- **Documentation**: Self-documenting configuration
- **Theme**: Perfect Kanagawa consistency
- **Workflow**: Muscle memory preserved

## Next Steps After Migration

1. **Optimize**: Remove unused features (YAGNI)
2. **Enhance**: Add Wayland-specific improvements
3. **Share**: Publish refined dotfiles
4. **Iterate**: Continuous improvement cycle

---

*"Simplicity is the ultimate sophistication" - Now with complete functionality*
