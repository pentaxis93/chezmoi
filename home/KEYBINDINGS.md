# Ultra-Zen Semantic Keybinding System

> "Do not define keybindings; define intentions. Let the intention manifest as the appropriate key."

## Philosophy

Just as our terminal colors became semantic purposes (background, error, success), our keybindings are semantic **intentions** that manifest contextually. Each keybinding represents an intention, not a physical key.

## Core Semantic Actions

### Navigate - Move focus without side effects

| Intention | Universal Key | Niri (WM) | Helix (Editor) | Fish (Shell) |
|-----------|---------------|-----------|----------------|--------------|
| `navigate.prev` | `h` | Focus left window | Move cursor left | Move cursor left |
| `navigate.next` | `l` | Focus right window | Move cursor right | Move cursor right |
| `navigate.up` | `k` | Focus upper window | Move line up | Previous command |
| `navigate.down` | `j` | Focus lower window | Move line down | Next command |
| `navigate.line_start` | `gh` | - | Go to line start | Beginning of line |
| `navigate.line_end` | `gl` | - | Go to line end | End of line |
| `navigate.file_start` | `gg` | - | Go to first line | Beginning of buffer |
| `navigate.file_end` | `ge` | - | **Go to last line** (Helix-native) | End of buffer |

**Note**: We follow Helix's semantic `ge` (go end) instead of Vim's `G` for consistency.

### Manipulate - Relocate or reshape objects

| Intention | Key Pattern | Context | Action |
|-----------|-------------|---------|--------|
| `manipulate.move` | `MOD+CTRL+hjkl` | Niri | Move window in direction |
| `manipulate.resize` | `MOD+-/=` | Niri | Decrease/increase size |
| `manipulate.transfer` | `MOD+CTRL+[1-9]` | Niri | Move to workspace N |

### Invoke - Bring into existence

| Intention | Key | Context | Launches |
|-----------|-----|---------|----------|
| `invoke.terminal` | `MOD+RETURN` | Niri | Alacritty terminal |
| `invoke.launcher` | `MOD+SPACE` | Niri | Application launcher (wofi) |
| `invoke.browser` | `MOD+B` | Niri | Firefox |
| `invoke.editor` | `h` | Shell | Helix editor (alias) |

### Transform - Change state while preserving identity

| Intention | Key | Context | Transformation |
|-----------|-----|---------|----------------|
| `transform.mode` | `ESC/i/v` | Editor/Shell | Normal/Insert/Visual mode |
| `transform.fullscreen` | `MOD+F` | Niri | Toggle fullscreen |
| `transform.floating` | `MOD+T` | Niri | Toggle floating/tiled |
| `transform.tabbed` | `MOD+W` | Niri | Toggle window tabs |

### Preserve - Persist current state

| Intention | Key | Context | Saves |
|-----------|-----|---------|-------|
| `preserve.current` | `SPACE+W` | Helix | Write current file |
| `preserve.all` | `SPACE+SHIFT+W` | Helix | Write all files |

### Dismiss - Remove from current context

| Intention | Key | Context | Action |
|-----------|-----|---------|--------|
| `dismiss.current` | `MOD+Q` | Niri | Close window |
| `dismiss.current` | `SPACE+Q` | Helix | Quit editor |
| `dismiss.cancel` | `ESC` | Universal | Cancel operation |

### Discover - Reveal information

| Intention | Key | Context | Shows |
|-----------|-----|---------|-------|
| `discover.search` | `/` | Editor/Shell | Search forward |
| `discover.reverse` | `?` | Editor/Shell | Search backward |
| `discover.help` | `MOD+SHIFT+ESC` | Niri | Hotkey overlay |

## Modifier Patterns

### System-Wide Consistency

- **`MOD`** (Super/Win): Window manager operations
- **`SPACE`**: Editor leader key
- **`CTRL`**: Terminal/shell operations
- **`SHIFT`**: Extend/modify action
- **`ALT`**: Alternative action

### Contextual Modifiers

| Context | Primary | Manipulate | System |
|---------|---------|------------|--------|
| Niri (WM) | `MOD` | `MOD+CTRL` | `CTRL+ALT` |
| Helix | `SPACE` (leader) | `g` (goto) | `z` (view) |
| Alacritty | `CTRL` | `CTRL+SHIFT` | `ALT` |
| Fish | None (normal mode) | `CTRL` | `ALT` |

## Vi Mode Everywhere

### Enabled Vi Modes

- **Fish Shell**: Vi mode with Helix-native keybindings
  - Mode indicator: `[N]` (green), `[I]` (blue), `[V]` (yellow)
  - Cursor changes: Block (normal), Line (insert), Underscore (visual)

- **Alacritty Terminal**: Vi mode with visual feedback
  - Toggle: `CTRL+SHIFT+SPACE`
  - Vi cursor: Green block when active
  - Supports Helix `ge` for end navigation

- **Helix Editor**: Native modal editing (already perfect)

### Mode Indicators

All modes use semantic colors from our Kanagawa Dragon palette:

| Mode | Color | Semantic Meaning |
|------|-------|------------------|
| Normal | Green (`focus`) | Ready for action |
| Insert | Blue (`info`) | Accepting input |
| Visual | Yellow (`warning`) | Selection active |
| Replace | Red (`error`) | Destructive change |

## Helix-Native Philosophy

We embrace Helix's thoughtful semantic improvements:

- **`ge`** instead of `G`: "Go end" is semantically clearer than arbitrary `G`
- **`gh/gl`** for line navigation: "Go home/line-end" is more intuitive
- **`x`** for extend: Direct selection extension without mode change
- **Goto mode (`g` prefix)**: Groups all "go to" operations semantically

## Benefits

1. **Muscle Memory Unity**: Same intention = same key everywhere
2. **Discoverability**: Actions named by intention, not key
3. **No Conflicts**: Semantic layer prevents overlaps
4. **Self-Documenting**: Intention names explain themselves
5. **Extensibility**: New apps inherit the pattern

## Quick Reference Card

```
Universal Navigation (hjkl)
├─ h/j/k/l: left/down/up/right
├─ gg: start  ge: end (Helix-native)
└─ gh: line start  gl: line end

Modal Operations
├─ ESC: normal  i: insert  v: visual
├─ x: extend selection (Helix)
└─ /: search  ?: reverse search

Window Manager (MOD key)
├─ MOD+hjkl: focus windows
├─ MOD+CTRL+hjkl: move windows
├─ MOD+[1-9]: workspace N
├─ MOD+Q: close  MOD+F: fullscreen
└─ MOD+RETURN: terminal

Editor (SPACE leader)
├─ SPACE+W: write  SPACE+Q: quit
├─ g prefix: goto operations
└─ m prefix: match operations

Terminal (CTRL modifier)
├─ CTRL+SHIFT+V: paste
├─ CTRL+SHIFT+C: copy
└─ CTRL+SHIFT+SPACE: toggle vi mode
└─ CTRL+L: clear
```

## Implementation Status

- ✅ Semantic definition system (`keybindings.yaml`)
- ✅ Fish vi mode with Helix keybindings
- ✅ Alacritty vi mode enhancements
- ✅ Mode indicators with semantic colors
- ✅ Documentation and quick reference

## Future Considerations

When adding new applications:

1. Check `keybindings.yaml` for semantic patterns
2. Map application actions to semantic intentions
3. Preserve muscle memory consistency
4. Document any app-specific limitations
5. Update this reference

---

*Each keybinding must justify its existence through clear intention.*