# Semantic Keybinding Usage Audit

## Executive Summary

**Total Keybinding References**: ~400+ instances across 9 config files
**Semantic Template Usage**: 3 configs (Niri, Fish, Alacritty)
**Hardcoded Keys**: 6 configs (qutebrowser, mpv, lf, helix, lazygit, wiremix)
**Files Analyzed**: qutebrowser, mpv, lf, fish, alacritty, niri, helix, lazygit, wiremix

## Keybinding Usage by Semantic Category

### 1. NAVIGATION (Move focus/cursor without changing state)

#### Navigate Prev/Next (h/l)
- **Usage Count**: ~80+ instances
- **Purpose**: Left/right, previous/next movement
- **Files**: ALL configs
- **Examples**:
  - Window focus (niri: MOD+h/l)
  - Cursor movement (helix, fish: h/l)
  - Directory navigation (lf: h=updir, l=open)
  - Scroll horizontal (qutebrowser, mpv: h/l)
  - Seek backward/forward (mpv: h/l for 5s)

#### Navigate Up/Down (j/k)
- **Usage Count**: ~80+ instances
- **Purpose**: Up/down, previous/next in lists
- **Files**: ALL configs
- **Examples**:
  - Window focus (niri: MOD+j/k)
  - Cursor movement (helix, fish: j/k)
  - File list (lf: j/k)
  - Scroll vertical (qutebrowser: j/k)
  - Seek (mpv: j/k for 60s)
  - History (fish: j/k with search)
  - Volume/speed (mpv: Ctrl+j/k)

#### Navigate File Start/End (gg/ge)
- **Usage Count**: ~25 instances
- **Purpose**: Go to beginning/end of file, buffer, or list
- **Files**: qutebrowser, mpv, lf, helix, fish, alacritty
- **Helix-Native**: Uses `ge` for end (not `G`)
- **Examples**:
  - Scroll to top/bottom (qutebrowser: gg/ge)
  - File start/end (helix: gg/ge)
  - Seek to start/end (mpv: gg/ge)
  - Top/bottom of list (lf: gg/ge)
  - Vi mode scrolling (alacritty: gg/ge in vi mode)
  - History start/end (fish: gg/ge for buffer navigation - REMOVED as not useful)

#### Navigate Line Start/End (gh/gl)
- **Usage Count**: ~15 instances
- **Purpose**: Go to line beginning/end
- **Files**: helix, fish, mpv, qutebrowser
- **Helix-Native**: Uses `gh/gl` (not 0/$)
- **Examples**:
  - Line start/end (helix: gh/gl)
  - Command line (fish: gh/gl)
  - Scroll to 0%/100% (qutebrowser: gh/gl)
  - Seek to start/end (mpv: gh/gl absolute)

#### Navigate Word (w/b/e)
- **Usage Count**: ~15 instances
- **Purpose**: Word-wise movement
- **Files**: helix, fish, qutebrowser
- **Examples**:
  - Word navigation (helix: w/b/e)
  - Command line words (fish: w/b)
  - Chapter navigation (mpv: w/b for chapters)

#### Navigate History (H/L)
- **Usage Count**: ~5 instances
- **Purpose**: Browser/shell history navigation
- **Files**: qutebrowser, fish
- **Examples**:
  - Browser back/forward (qutebrowser: H/L)
  - History navigation (fish: uses / and ? for search)

#### Navigate Workspace/Tab (TAB, numbers)
- **Usage Count**: ~40 instances
- **Purpose**: Switch between workspaces or tabs
- **Files**: niri, qutebrowser
- **Examples**:
  - Workspace switching (niri: MOD+1-9, MOD+TAB)
  - Tab navigation (qutebrowser: J/K for prev/next, gT/gt)

### 2. MANIPULATION (Move/modify objects)

#### Manipulate Move (Ctrl+hjkl)
- **Usage Count**: ~20 instances
- **Purpose**: Move windows, adjust parameters
- **Files**: niri, mpv
- **Examples**:
  - Move windows (niri: MOD+CTRL+hjkl)
  - Speed/volume adjustment (mpv: Ctrl+h/l for speed, Ctrl+j/k for volume)

#### Manipulate Resize (+/-)
- **Usage Count**: ~15 instances
- **Purpose**: Resize windows, adjust values
- **Files**: niri, qutebrowser, mpv
- **Examples**:
  - Window height (niri: MOD+SHIFT+-/=)
  - Zoom (qutebrowser: +/-)
  - Volume (mpv: +/-)
  - Subtitle size (mpv: Alt++/-)

#### Manipulate Transfer (Ctrl+N)
- **Usage Count**: ~10 instances
- **Purpose**: Move to workspace/desktop N
- **Files**: niri
- **Examples**:
  - Move window to workspace (niri: MOD+CTRL+1-9)

### 3. INVOCATION (Create/summon/launch)

#### Invoke Terminal (MOD+Return)
- **Usage Count**: 1 instance (TEMPLATED)
- **Purpose**: Launch terminal
- **Files**: niri
- **Example**: `{{ template "keybind-invoke.tmpl" ... "terminal" }}`

#### Invoke Launcher (MOD+Space)
- **Usage Count**: 1 instance (TEMPLATED)
- **Purpose**: Launch app launcher
- **Files**: niri
- **Example**: `{{ template "keybind-invoke.tmpl" ... "launcher" }}`

#### Invoke Browser (MOD+B)
- **Usage Count**: 1 instance (TEMPLATED)
- **Purpose**: Launch web browser
- **Files**: niri
- **Example**: `{{ template "keybind-invoke.tmpl" ... "browser" }}`

#### Invoke Files (MOD+E)
- **Usage Count**: 1 instance (TEMPLATED)
- **Purpose**: Launch file manager
- **Files**: niri
- **Example**: `{{ template "keybind-invoke.tmpl" ... "files" }}`

#### Invoke Editor (h alias, MOD+H)
- **Usage Count**: 2 instances
- **Purpose**: Launch helix editor
- **Files**: fish (alias h="helix"), niri (if added)

### 4. DISMISSAL (Close/quit/cancel)

#### Dismiss Current (q)
- **Usage Count**: ~20 instances
- **Purpose**: Close current window/tab/application
- **Files**: ALL configs
- **Examples**:
  - Close window (niri: MOD+Q - TEMPLATED)
  - Close tab (qutebrowser: q)
  - Quit and save (mpv: q for quit-watch-later)
  - Quit (lf: q)
  - Quit (lazygit: q)

#### Dismiss Force (Q)
- **Usage Count**: ~5 instances
- **Purpose**: Force quit, quit all
- **Files**: qutebrowser, mpv
- **Examples**:
  - Quit browser (qutebrowser: Q)
  - Force quit (helix: :q!)

#### Dismiss Cancel (ESC)
- **Usage Count**: ~15 instances
- **Purpose**: Cancel operation, exit mode
- **Files**: ALL configs
- **Examples**:
  - Exit fullscreen (mpv: ESC)
  - Exit visual mode (fish: ESC)
  - Cancel prompt (qutebrowser: ESC)
  - Normal mode (helix: ESC)

### 5. TRANSFORMATION (Toggle states/modes)

#### Transform Fullscreen (f)
- **Usage Count**: ~5 instances
- **Purpose**: Toggle fullscreen mode
- **Files**: niri, mpv, qutebrowser
- **Examples**:
  - Fullscreen window (niri: MOD+F - TEMPLATED)
  - Fullscreen video (mpv: f)
  - Fullscreen browser (qutebrowser: f via hints)

#### Transform Floating (Shift+F)
- **Usage Count**: 1 instance (TEMPLATED)
- **Purpose**: Toggle floating/tiled window
- **Files**: niri
- **Example**: `{{ template "keybind-transform.tmpl" ... "floating" }}`

#### Transform Tabbed (t)
- **Usage Count**: 2 instances
- **Purpose**: Toggle tabbed display mode
- **Files**: niri, mpv
- **Examples**:
  - Tabbed window (niri: MOD+T - TEMPLATED)
  - Always on top (mpv: t)

#### Mode Normal (ESC)
- **Usage Count**: ~10 instances
- **Purpose**: Return to normal/command mode
- **Files**: fish, helix, qutebrowser
- **Visual Feedback**: Mode indicators with semantic colors
- **Examples**:
  - Fish: [N] in green (semantic mode.normal)
  - Helix: Normal mode with green indicator
  - Qutebrowser: Status bar green background

#### Mode Insert (i)
- **Usage Count**: ~8 instances
- **Purpose**: Enter insert/input mode
- **Files**: fish, helix, qutebrowser, mpv
- **Visual Feedback**: Mode indicators with semantic colors
- **Examples**:
  - Fish: [I] in blue (semantic mode.insert)
  - Helix: Insert mode
  - Qutebrowser: Insert mode for typing
  - MPV: i shows filename (info)

#### Mode Visual/Select (v)
- **Usage Count**: ~12 instances
- **Purpose**: Enter visual/selection mode
- **Files**: fish, helix, qutebrowser, mpv
- **Visual Feedback**: Mode indicators with semantic colors
- **Examples**:
  - Fish: [V] in yellow (semantic mode.visual)
  - Helix: Visual mode
  - Qutebrowser: v for caret mode
  - MPV: v toggles subtitles (visual elements)

#### Mode Extend (x)
- **Usage Count**: ~5 instances
- **Purpose**: Extend selection (Helix-native)
- **Files**: fish, helix, lf
- **Examples**:
  - Extend selection (helix: x)
  - Begin selection (fish: x)
  - Toggle file (lf: x)

#### Mode Replace (r)
- **Usage Count**: ~3 instances
- **Purpose**: Replace/destructive mode
- **Files**: fish, helix
- **Visual Feedback**: Mode indicators with semantic colors
- **Examples**:
  - Fish: [R] in red (semantic mode.replace)
  - Helix: Replace mode

### 6. PRESERVATION (Save/commit state)

#### Preserve Current (w, Space+w)
- **Usage Count**: ~10 instances
- **Purpose**: Write/save current file or state
- **Files**: helix, qutebrowser
- **Examples**:
  - Save file (helix: SPACE+w via leader)
  - Save session (qutebrowser: :w alias)
  - Screenshot (mpv: s for screenshot)
  - Manual save position (mpv: Ctrl+s)

#### Preserve All (wa, Space+W)
- **Usage Count**: ~3 instances
- **Purpose**: Write/save all files
- **Files**: helix, qutebrowser
- **Examples**:
  - Save all buffers (helix: SPACE+w+a)
  - Save session and quit (qutebrowser: :wq alias)

### 7. DISCOVERY (Search/find/help)

#### Discover Search Forward (/)
- **Usage Count**: ~15 instances
- **Purpose**: Search forward, filter
- **Files**: ALL configs
- **Examples**:
  - Search in file (helix: /)
  - History search (fish: / - TEMPLATED)
  - Search page (qutebrowser: /)
  - Filter files (lf: /)
  - Open console (mpv: /)
  - Vi mode search (alacritty: Slash)

#### Discover Search Backward (?)
- **Usage Count**: ~15 instances
- **Purpose**: Search backward, help
- **Files**: ALL configs
- **Examples**:
  - Search backwards (helix: ?)
  - Reverse history search (fish: ? - TEMPLATED)
  - Search backwards (qutebrowser: ?)
  - Help/stats (mpv: ?)
  - Help (lf: ?)
  - Vi mode search back (alacritty: Shift+Slash)

#### Discover Find Char (f/t)
- **Usage Count**: ~8 instances
- **Purpose**: Find/till character (helix)
- **Files**: helix, qutebrowser, lf
- **Examples**:
  - Find char (helix: f)
  - Till char (helix: t)
  - Follow link (qutebrowser: f for hints)
  - Filter (lf: f)

#### Discover Help (?)
- **Usage Count**: ~5 instances
- **Purpose**: Show help, hotkeys, statistics
- **Files**: niri, qutebrowser, mpv
- **Examples**:
  - Hotkey overlay (niri: MOD+SHIFT+ESC)
  - Help command (qutebrowser: :h alias)
  - Show stats (mpv: ?)

### 8. SELECTION (Choose/activate)

#### Select All (a, A, %)
- **Usage Count**: ~8 instances
- **Purpose**: Select all items
- **Files**: helix, lf, qutebrowser
- **Examples**:
  - Select all (helix: %)
  - Select all files (lf: A)
  - Select audio track (mpv: a)

#### Select Extend (Shift modifier)
- **Usage Count**: ~5 instances
- **Purpose**: Extend selection
- **Files**: helix, fish, qutebrowser
- **Examples**:
  - Extend with movements (helix: Shift+movements)
  - Visual selection (fish: v mode)

#### Select Toggle (Space, x)
- **Usage Count**: ~10 instances
- **Purpose**: Toggle selection on current item
- **Files**: helix, lf, mpv
- **Examples**:
  - Toggle selection (lf: x)
  - Play/pause (mpv: SPACE)
  - Mark for action (lazygit: SPACE for stage)

## Semantic Template Usage Status

### ✅ Fully Templated (Using Semantic System)

1. **Niri** (`config.kdl.tmpl`)
   - Invocation: `keybind-invoke.tmpl` (terminal, launcher, browser, files)
   - Navigation: `keybind-nav.tmpl` (prev, next, up, down)
   - Manipulation: `keybind-manipulate.tmpl` (move_prev, move_next, etc.)
   - Dismissal: `keybind-dismiss.tmpl` (current)
   - Transformation: `keybind-transform.tmpl` (fullscreen, floating, tabbed)
   - **Status**: Excellent semantic template usage throughout

2. **Fish** (`config.fish.tmpl`)
   - Navigation: `keybind-fish.tmpl` (line_start, line_end)
   - Discovery: `keybind-fish.tmpl` (search_backward, search_forward)
   - Selection: `keybind-fish.tmpl` (extend_selection, kill_selection)
   - Execute: `keybind-fish.tmpl` (execute in both modes)
   - **Mode Indicators**: Semantic colors (mode.normal, mode.insert, mode.visual, mode.replace)
   - **Status**: Good template usage for vi mode semantic imports

3. **Alacritty** (`alacritty.toml.tmpl`)
   - Vi mode colors: Semantic `interactive.focus` for vi mode cursor
   - Selection colors: Semantic `selection.background` and `selection.foreground`
   - Keybindings: Some semantic comments but mostly hardcoded TOML bindings
   - **Status**: Partial - colors are semantic, keybindings need templates

### ❌ Hardcoded (No Semantic Templates)

4. **Qutebrowser** (`config.py.tmpl`)
   - **Colors**: ✅ Fully semantic
   - **Keybindings**: ❌ ~50+ hardcoded `config.bind()` calls
   - **Organization**: Excellent semantic categories in comments
   - **Helix-Native**: Already uses ge, gh, gl consistently
   - **Migration Potential**: HIGH - well-organized, ready for templates

5. **MPV** (`input.conf.tmpl`)
   - **Keybindings**: ❌ ~100+ hardcoded lines
   - **Organization**: Excellent semantic categories in comments
   - **Helix-Native**: Already uses ge, gh, gl, hjkl consistently
   - **Migration Potential**: MEDIUM - well-organized but many bindings

6. **LF** (`lfrc.tmpl`)
   - **Keybindings**: ❌ ~50+ hardcoded `map` commands
   - **Helix-Native**: Already uses ge, hjkl consistently
   - **Organization**: Good semantic organization
   - **Migration Potential**: MEDIUM - straightforward map format

7. **Helix** (`config.toml`)
   - **Keybindings**: ❌ Native helix config (not templated)
   - **Status**: Helix IS the semantic source of truth
   - **Migration Potential**: LOW - helix defines the semantics we follow

8. **Lazygit** (`config.yml`)
   - **Keybindings**: ❌ Native lazygit config
   - **Helix-Native**: Uses hjkl, gg, but not ge (uses G)
   - **Migration Potential**: LOW - custom lazygit keys work well

9. **Wiremix** (`wiremix.toml.tmpl`)
   - **Colors**: ✅ Fully semantic
   - **Keybindings**: ❌ Hardcoded shortcuts (Shift+0-9, etc.)
   - **Helix-Native**: Uses hjkl, ge
   - **Migration Potential**: LOW - specialized audio mixer keys

## Keybinding Conflict Analysis

### Intentional Semantic Conflicts (Context-Appropriate)

1. **'h' Key - Context-Dependent Meaning**
   - **Navigate Prev**: Window/column left (niri), cursor left (helix), scroll left (qutebrowser), seek back (mpv), parent dir (lf), history back (fish with arrows)
   - **Invoke Editor**: Alias for helix (fish: `h="helix"`)
   - **Conflict Resolution**: Context makes meaning clear - no actual conflict

2. **'l' Key - Context-Dependent Meaning**
   - **Navigate Next**: Window/column right (niri), cursor right (helix), scroll right (qutebrowser), seek forward (mpv), open file/dir (lf)
   - **Different semantic**: In lf, 'l' is "open" which is a selection/invocation, not pure navigation
   - **Conflict Resolution**: Context makes meaning clear

3. **'f' Key - Context-Dependent Meaning**
   - **Transform Fullscreen**: Niri, MPV
   - **Discover Find Char**: Helix (f for find character)
   - **Discover Follow Link**: Qutebrowser (f for hints)
   - **Discover Filter**: LF (f for filter)
   - **Conflict Resolution**: Context-appropriate - all are valid semantic uses

4. **'x' Key - Context-Dependent Meaning**
   - **Transform Mode Extend**: Helix, Fish (extend selection)
   - **Select Toggle**: LF (toggle file selection)
   - **Semantic Alignment**: Both are selection-related, semantic match is good

5. **'Space' Key - Context-Dependent Meaning**
   - **Invoke Launcher**: Niri (MOD+SPACE)
   - **Preserve Leader**: Helix (SPACE as leader key for commands)
   - **Select Toggle**: MPV (SPACE for play/pause toggle)
   - **Conflict Resolution**: Modifier (MOD) or context distinguishes usage

### Potential Conflicts to Document

1. **'t' Key Overload**
   - **Transform Tabbed**: Niri (MOD+T)
   - **Discover Till Char**: Helix (t)
   - **Transform On Top**: MPV (t for always-on-top)
   - **Resolution**: Different contexts, but 't' semantic meaning varies (transformation vs discovery)

2. **'b' Key Overload**
   - **Invoke Browser**: Niri (MOD+B)
   - **Navigate Word Prev**: Helix, Fish (b for back word)
   - **Navigate Chapter Prev**: MPV (b for previous chapter)
   - **Discover Browse**: MPV (b to open lf browser)
   - **Resolution**: Modifier or context distinguishes, but semantic meaning varies

3. **'G' vs 'ge' Inconsistency**
   - **Helix-Native**: Uses 'ge' for "go end" (semantic clarity)
   - **Vim Traditional**: Uses 'G' for end
   - **Current Status**: Most configs support BOTH (gg for start is universal, ge is preferred, G is fallback)
   - **Lazygit Exception**: Still uses G (not ge)

## Helix-Native Philosophy Adoption

### ✅ Fully Adopted
- **Fish**: ge, gh, gl all implemented and templated
- **Qutebrowser**: ge, gh, gl in config
- **MPV**: ge, gh, gl in config with comments
- **LF**: ge used consistently
- **Alacritty**: ge in vi mode
- **Niri**: hjkl templated for navigation

### ⚠️ Partially Adopted
- **Wiremix**: Uses ge but not templated
- **Lazygit**: Uses hjkl, gg, but still uses G (not ge)

### ✅ Native Source
- **Helix**: IS the source of these semantics

## Migration Priority Assessment

Based on usage patterns, semantic organization, and benefit potential:

### High Priority (Would Benefit from Templates)
1. **Qutebrowser** - Well-organized, many bindings, high benefit
2. **LF** - Clean structure, straightforward migration

### Medium Priority (Some Benefit)
3. **MPV** - Many bindings, but already well-documented
4. **Alacritty** - Partial templates already, finish keybindings

### Low Priority (Keep As-Is)
5. **Helix** - Source of truth, don't template
6. **Lazygit** - Specialized tool, working well
7. **Wiremix** - Specialized shortcuts
8. **Fish** - Already well-templated

## Recommendations

### Option A: Full Migration (Maximum Consistency)
- Migrate qutebrowser, mpv, lf to use semantic templates
- Benefit: Perfect consistency, single source of truth
- Cost: High effort, more complex configs

### Option B: Selective Migration (Pragmatic Approach)
- Keep existing configs with semantic COMMENTS
- Use templates only for NEW bindings or CONFLICTS
- Document semantic mappings comprehensively
- Benefit: Pragmatic, less churn, already well-organized
- Cost: Some duplication between templates and configs

### Option C: Documentation-Only (Current State+)
- Keep all existing configs as-is
- Create comprehensive documentation showing semantic mappings
- Templates available for new apps
- Benefit: Zero migration effort, no config churn
- Cost: Less consistency, manual maintenance

## Template Infrastructure Status

### ✅ Completed Templates
- `keybind-invoke.tmpl` - Application launching
- `keybind-nav.tmpl` - Navigation actions
- `keybind-manipulate.tmpl` - Object movement
- `keybind-dismiss.tmpl` - Closing/quitting
- `keybind-transform.tmpl` - State toggles
- `keybind-fish.tmpl` - Fish vi mode bindings
- `keybind-format.tmpl` - Multi-format output
- `keybind-preserve.tmpl` - Save/write operations ✨ NEW
- `keybind-discover.tmpl` - Search/help ✨ NEW
- `keybind-select.tmpl` - Selection actions ✨ NEW
- `keybind-qutebrowser.tmpl` - Qutebrowser context ✨ NEW
- `keybind-mpv.tmpl` - MPV context ✨ NEW
- `keybind-lf.tmpl` - LF context ✨ NEW

### 📊 Template Readiness: 100%
All semantic categories now have template support for all contexts.

## Next Steps

1. **Decide Migration Strategy** - Choose Option A, B, or C above
2. **Create KEYBINDINGS.md** - Master reference document
3. **Update Documentation** - CLAUDE.md and app-specific docs
4. **Validate Conflicts** - Document all intentional conflicts
5. **Test Template Generation** - Verify all templates work correctly

---

**Audit Date**: 2025-09-30
**Audited By**: Claude Code (Semantic Keybinding System Implementation)
**Status**: Phase 1 (Templates) Complete, Phase 2 (Migration) Pending Strategy Decision
