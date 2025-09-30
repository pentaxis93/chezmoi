# Semantic Keybinding System

## Ultra-Zen Philosophy: Semantic Actions

**"Do not define keybindings; define intentions. Let the intention manifest as the appropriate key."**

Just as colors became semantic purposes, keybindings are semantic **intentions** that manifest contextually:

```yaml
# Instead of: MOD+H = move left
# We define: navigate.prev = context-appropriate leftward movement
```

## Architecture
- **Single Source of Truth**: All semantic actions defined in `home/.chezmoidata/keybindings.yaml`
- **Helix-Native**: Follow Helix's thoughtful semantic improvements as our foundation
- **Context Manifestation**: Same intention manifests appropriately per application
- **Vi Mode Everywhere**: Fish shell, Alacritty terminal, and Helix editor all use vi modes

## Core Semantic Categories
- **Navigate**: Move focus without changing state (hjkl universally)
- **Manipulate**: Move/modify objects (MOD+CTRL+hjkl for windows)
- **Invoke**: Create/summon/launch (MOD+key for apps)
- **Transform**: Toggle states/modes (f for fullscreen, i/v/ESC for modes)
- **Preserve**: Save state (SPACE+W for write)
- **Dismiss**: Close/quit (q/Q universally)
- **Discover**: Search/help (/ for search, ? for help)

## Helix-Native Navigation
- `ge` instead of `G`: "Go end" is semantically clearer
- `gh/gl` for line start/end: "Go home/line" is intuitive
- `x` for extend: Direct selection without mode change
- `g` prefix groups all "go to" operations

## Benefits
- **Muscle Memory Unity**: Same semantic action = same key pattern everywhere
- **No Conflicts**: Semantic layer prevents accidental overlaps
- **Self-Documenting**: Intentions explain themselves
- **Extensibility**: New apps inherit semantic patterns automatically

## Vi-Mode Enabled Applications
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

## Documentation
- **Reference**: See `home/KEYBINDINGS.md` for complete semantic mappings
- **Definition**: `home/.chezmoidata/keybindings.yaml` contains all semantic actions