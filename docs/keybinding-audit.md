# Current Keybinding Audit - Pre-Template Analysis

## Niri Window Manager (config.kdl.tmpl)

### Navigation (Focus)
- `MOD+H` / `MOD+LEFT` → focus-column-left
- `MOD+L` / `MOD+RIGHT` → focus-column-right
- `MOD+K` / `MOD+UP` → focus-window-up
- `MOD+J` / `MOD+DOWN` → focus-window-down
- `MOD+HOME` → focus-column-first
- `MOD+END` → focus-column-last
- `MOD+SHIFT+LEFT/RIGHT/UP/DOWN` → focus-monitor-{direction}
- `MOD+1-9` → focus-workspace {N}
- `MOD+TAB` → focus-workspace-previous

### Manipulation (Move)
- `MOD+CTRL+H` / `MOD+CTRL+LEFT` → move-column-left
- `MOD+CTRL+L` / `MOD+CTRL+RIGHT` → move-column-right
- `MOD+CTRL+K` / `MOD+CTRL+UP` → move-window-up
- `MOD+CTRL+J` / `MOD+CTRL+DOWN` → move-window-down
- `MOD+CTRL+HOME` → move-column-to-first
- `MOD+CTRL+END` → move-column-to-last
- `MOD+SHIFT+CTRL+LEFT/RIGHT/UP/DOWN` → move-column-to-monitor-{direction}
- `MOD+CTRL+1-9` → move-column-to-workspace {N}

### Invocation (Launch)
- `MOD+RETURN` → spawn alacritty
- `MOD+SPACE` → spawn wofi (launcher)
- `MOD+B` → spawn firefox
- `MOD+E` → spawn nautilus
- `MOD+ALT+L` → spawn swaylock

### Transformation (Mode/State)
- `MOD+T` → toggle-window-floating
- `MOD+F` → fullscreen-window
- `MOD+W` → toggle-column-tabbed-display
- `MOD+O` → toggle-overview

### Dismissal
- `MOD+Q` → close-window
- `CTRL+ALT+DELETE` → quit
- `MOD+ESCAPE` → toggle-keyboard-shortcuts-inhibit

### Resize/Layout
- `MOD+MINUS` → set-column-width "-10%"
- `MOD+EQUAL` → set-column-width "+10%"
- `MOD+SHIFT+MINUS` → set-window-height "-10%"
- `MOD+SHIFT+EQUAL` → set-window-height "+10%"
- `MOD+C` → center-column
- `MOD+CTRL+C` → center-visible-columns
- `MOD+CTRL+F` → expand-column-to-available-width

### Column Management
- `MOD+COMMA` → consume-window-into-column
- `MOD+PERIOD` → expel-window-from-column
- `MOD+BRACKETLEFT` → consume-or-expel-window-left
- `MOD+BRACKETRIGHT` → consume-or-expel-window-right

### System
- `MOD+SHIFT+P` → power-off-monitors
- `CTRL+SHIFT+1/2/3` → screenshot variants
- `MOD+SHIFT+ESCAPE` → show-hotkey-overlay

### Wheel/Scroll
- `MOD+WHEELSCROLL*` → Various workspace/column navigation

## Fish Shell (config.fish.tmpl)

### Vi Mode Navigation
- `ge` → end-of-buffer (Helix-native, replaces G)
- `gg` → beginning-of-buffer
- `gh` → beginning-of-line (Helix-native)
- `gl` → end-of-line (Helix-native)

### Search/Discovery
- `/` → history-search-backward
- `?` → history-search-forward

### Mode Transformation
- `ESC` → normal mode (implicit)
- `i` → insert mode (implicit)
- `v` → visual mode (implicit)
- `x` → begin-selection (Helix extend)

### Actions
- `\r` (Enter) → execute (both modes)
- `\cf` (Ctrl-F) → forward-char (accept suggestion)
- `x` in visual → kill-selection

## Alacritty Terminal (alacritty.toml.tmpl)

### System Clipboard
- `CTRL+SHIFT+V` → Paste
- `CTRL+SHIFT+C` → Copy
- `Paste/Copy` keys → Paste/Copy

### Search
- `CTRL+SHIFT+F` → SearchForward
- `CTRL+SHIFT+B` → SearchBackward

### Vi Mode
- `CTRL+SHIFT+SPACE` → ToggleViMode
- `SHIFT+G` → Last (traditional)
- `E` → Last (Helix ge semantic)

### Scroll
- `SHIFT+PageUp/Down` → ScrollPage
- `SHIFT+Home/End` → ScrollToTop/Bottom

### Other
- `CTRL+L` → ClearLogNotice / form-feed
- `CTRL+0` → ResetFontSize
- `Middle Mouse` → PasteSelection

## Syntax Patterns Discovered

### KDL (Niri)
```kdl
MOD+KEY { action; }
MOD+KEY property=value { action "arg"; }
```

### Fish Shell
```fish
bind -M mode KEY action
```

### TOML (Alacritty)
```toml
[[keyboard.bindings]]
key = "KEY"
mods = "Mod1|Mod2"
action = "Action"
```

## Conflicts & Observations

### Semantic Alignment Issues
1. **File End Navigation**:
   - Fish: `ge` (Helix-native)
   - Alacritty: `E` in vi mode (attempts Helix ge)
   - Traditional: `G` still supported in Alacritty

2. **Vi Mode Toggle**:
   - Alacritty: `CTRL+SHIFT+SPACE`
   - No equivalent in Niri (not modal)

3. **Search Semantics**:
   - Fish: `/` and `?` for history
   - Alacritty: `CTRL+SHIFT+F/B` for buffer search
   - Niri: No search (window manager)

### Modifier Patterns
- **Niri**: MOD (Super), MOD+CTRL, MOD+SHIFT, MOD+SHIFT+CTRL
- **Alacritty**: CTRL+SHIFT primary, some standalone keys in vi mode
- **Fish**: Mostly unmodified keys in vi normal mode

### Special Cases
- Audio/Media keys use XF86* names
- Screenshot keys use CTRL+SHIFT+[1-3]
- Emergency escape: MOD+ESCAPE with allow-inhibiting=false

## Template Requirements

1. **Context-aware key expansion**:
   - Same semantic action → different key per context
   - Example: `navigate.prev` → `h` (vi mode) vs `MOD+H` (Niri)

2. **Modifier composition**:
   - Build complex modifiers from semantic parts
   - Example: `manipulate` → `MOD+CTRL` prefix

3. **Format converters**:
   - KDL: `MOD+H { action; }`
   - TOML: `key = "H", mods = "Mod"`
   - Fish: `bind -M default h action`

4. **Conflict resolution**:
   - Document when semantic ideal conflicts with reality
   - Provide context-specific overrides

5. **Special key handling**:
   - Media keys (XF86*)
   - Function keys
   - Special chars (RETURN, SPACE, TAB)