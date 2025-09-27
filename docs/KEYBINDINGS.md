# 🧭 Ultra-Zen Semantic Keybindings Reference

> "Do not memorize keys; understand intentions. The fingers will follow."

## Philosophy: Intentions Manifest as Keys

Our keybinding system is **semantic**, not physical. You learn **intentions** once, and they manifest appropriately in each context:
- **Navigate** in niri → focus windows
- **Navigate** in fish → move cursor
- **Navigate** in alacritty → scroll view

This creates **universal muscle memory** based on Helix editor's thoughtful semantics.

## 🎯 Quick Start: Essential Patterns

```
Universal Navigation:  h j k l  (←↓↑→)
File/Buffer Jumps:     gg = top, ge = end (NOT G!)
Line Navigation:       gh = home, gl = line end
Universal Search:      / = forward, ? = backward, n/N = next/prev
Universal Exit:        ESC or q
MOD Keys:             Super (left hand), PrtSc (right hand)
```

## Core Semantic Actions

### 🧩 Navigate - Moving Focus Without Changing State
**Mnemonic**: "Where you look changes, what exists doesn't"

#### Cardinal Navigation (Universal hjkl)
- `h` - **Left** (◀ think "**h**ome" side of keyboard)
- `j` - **Down** (↓ **j** droops down)
- `k` - **Up** (↑ **k** kicks up)
- `l` - **Right** (▶ think "**l**ast" side of keyboard)

#### Jump Navigation (Helix-Native)
- `gg` - **Go to top** ("**g**o **g**et genesis")
- `ge` - **Go to end** ("**g**o **e**nd" - Helix improvement over vim's G)
- `gh` - **Go home** (line start - "**g**o **h**ome")
- `gl` - **Go line end** ("**g**o **l**ine's last")

#### Word Navigation
- `w` - **Word next** ("**w**ord")
- `b` - **Back word** ("**b**ack")
- `e` - **End of word** ("**e**nd")

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

### 🔧 Manipulate - Move Objects
**Mnemonic**: "Ctrl = Control the object's position"

| Intention | Key Pattern | Context | Action |
|-----------|-------------|---------|--------|
| `manipulate.move` | `MOD+CTRL+hjkl` | Niri | Move window in direction |
| `manipulate.resize` | `MOD+-/=` | Niri | Decrease/increase size |
| `manipulate.transfer` | `MOD+CTRL+[1-9]` | Niri | Move to workspace N |

### 🚀 Invoke - Launch/Create
**Mnemonic**: "Summon into existence"

| Intention | Key | Context | Launches |
|-----------|-----|---------|----------|
| `invoke.terminal` | `MOD+RETURN` | Niri | Alacritty terminal |
| `invoke.launcher` | `MOD+SPACE` | Niri | Application launcher (wofi) |
| `invoke.browser` | `MOD+B` | Niri | Firefox |
| `invoke.editor` | `h` | Shell | Helix editor (alias) |

### 🔄 Transform - Toggle States/Modes
**Mnemonic**: "Shape-shift what's already there"

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

### ❌ Dismiss - Close/Quit
**Mnemonic**: "Make it go away"

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

## 💻 Application References

### Niri Window Manager
**MOD Keys**: `Super` (left hand) or `PrtSc` (right hand - via keyd)

| Action | Keys | Mnemonic |
|--------|------|----------|
| **Focus** | | |
| Focus left/right | `MOD+H/L` | Navigate semantic |
| Focus up/down | `MOD+J/K` | Navigate semantic |
| Workspace switch | `MOD+TAB` / `MOD+SHIFT+TAB` | Universal convention |
| **Transform** | | |
| Fullscreen | `MOD+F` | **F**ull |
| Tabbed display | `MOD+T` | **T**abs! |
| Floating | `MOD+SHIFT+F` | Modified Full |
| Width toggle | `MOD+W` | **W**idth (50%/100%) |
| **Manipulate** | | |
| Move column | `MOD+CTRL+H/L` | Control = manipulate |
| Move window | `MOD+CTRL+J/K` | Control = manipulate |
| Move to workspace | `MOD+CTRL+[1-9]` | Control + number |
| **Special** | | |
| Screenshot | `MOD+SHIFT+S` | **S**creenshot (PrtSc is MOD) |
| Close window | `MOD+Q` | **Q**uit |

### Fish Shell (Vi Mode)
**Mode Indicators**: `[N]` Normal (green), `[I]` Insert (blue), `[V]` Visual (yellow)

| Action | Keys | Notes |
|--------|------|-------|
| **Navigation** | | |
| Move cursor | `h/j/k/l` | Vi standard |
| Word navigation | `w/b/e` | Vi standard |
| Line start/end | `gh/gl` | Helix-native (better than 0/$) |
| **Completion** | | |
| Accept suggestion | `Tab` | Primary method |
| Accept full | `Ctrl+F` | **F**ish tradition |
| **History** | | |
| Search history | `/` or `?` | Type to filter |
| Previous/next | `k/j` | Through filtered results |
| **Modes** | | |
| Enter normal | `ESC` | From any mode |
| Enter insert | `i` | Start typing |
| Enter visual | `v` or `x` | Select text |

**Intentionally Removed**: `gg/ge` (buffer navigation not useful in shells)

### Alacritty Terminal (Vi Mode)
**Toggle Vi Mode**: `Ctrl+Shift+Space` or `Ctrl+[`

| Action | Keys | What It Does |
|--------|------|--------------|
| **Scrollback Navigation** | | |
| Top of history | `g` | Oldest output |
| Bottom (current) | `Shift+E` | Newest output (Helix `ge`) |
| Bottom (alt) | `Shift+G` | Traditional vim |
| Page up/down | `Ctrl+U/D` | Half-page scrolling |
| **Search** | | |
| Search forward | `/` | Opens search |
| Search backward | `?` | Reverse search |
| Next match | `n` | Cycle forward |
| Previous match | `N` | Cycle backward |
| **Mode Control** | | |
| Exit vi mode | `ESC` | Return to normal terminal |
| Visual selection | `v` | Select text |
| Copy selection | `y` | Yank to clipboard |

## 🎯 Quick Reference Card

```
╭─────────────── UNIVERSAL ────────────────╮
│ Navigate:  h←  j↓  k↑  l→                │
│ Jump:      gg=top  ge=end  gh/gl=line    │
│ Search:    /=forward  ?=back  n/N=cycle  │
│ Exit:      ESC or q                      │
╰───────────────────────────────────────────╯

╭─────────────── NIRI (MOD+) ──────────────╮
│ Focus:     H/L=columns  J/K=windows      │
│ Transform: F=full  T=tabs  W=width       │
│ Move:      CTRL+HJKL=relocate            │
│ Workspace: TAB=switch  CTRL+[1-9]=move   │
╰───────────────────────────────────────────╯

╭─────────────── VI MODES ─────────────────╮
│ Fish:      ESC=normal  i=insert  v=visual│
│ Alacritty: Ctrl+Shift+Space=toggle       │
│            g=top  Shift+E=bottom          │
╰───────────────────────────────────────────╯
```

## 🎓 Learning Path

### Week 1: Universal Foundation
1. **Master hjkl** everywhere - this is 80% of navigation
2. **Learn gg/ge** for file jumps (forget vim's G!)
3. **Use ESC** to exit everything

### Week 2: Semantic Patterns
1. **MOD+[Letter]** for window operations (F/T/W)
2. **gh/gl** for line navigation in editing
3. **Search with /** in vi modes

### Week 3: Power Features
1. **MOD+W** for instant window sizing
2. **PrtSc as MOD** for right-hand efficiency
3. **Word navigation** with w/b/e

### Week 4: Full Fluency
1. **Tab management** with MOD+T
2. **Workspace flow** with MOD+TAB
3. **Visual selection** and copying

## 🔧 Troubleshooting

### "Why doesn't G go to bottom?"
We use Helix's semantic `ge` (go end). G is inconsistent across contexts. Train the better pattern!

### "Why MOD+TAB for workspaces, not MOD+W?"
Convention wins here - MOD+TAB is universal across window managers. MOD+W is our width toggle.

### "Why remove gg/ge from Fish?"
Buffer navigation (jumping to first/last command) isn't useful in shells. We keep what matters.

### "Why Ctrl+F for Fish completion?"
Respects Fish's native convention while Tab remains the primary method. Native sovereignty principle.

## 🧘 The Way Forward

> "The novice memorizes keybindings.
> The adept learns patterns.
> The master embodies intentions."

Our semantic system means you're not learning three different apps - you're learning one language that speaks everywhere. Trust the patterns, and your fingers will find the way.

---
*Generated from `~/.local/share/chezmoi/home/.chezmoidata/keybindings.yaml`*
*Philosophy: Helix-native, semantically pure, ergonomically sound*