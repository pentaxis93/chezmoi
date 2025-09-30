# Semantic Color Usage Audit

## Executive Summary

**Total Color References Found**: ~250+ instances across 7 config files
**Hardcoded Hex Colors**: 3 instances (waybar only)
**Files Analyzed**: waybar, qutebrowser, alacritty, niri, wiremix, wofi, fish

## Color Usage by Semantic Purpose

### 1. BACKGROUND COLORS (Container/Surface)

#### Primary Background (bg_dark)
- **Usage Count**: ~40 instances
- **Purpose**: Main application background, window background
- **Files**: waybar, qutebrowser, alacritty, wofi
- **Examples**:
  - Window background (waybar, alacritty)
  - Status bar background (qutebrowser)
  - Completion widget background (qutebrowser)
  - Menu background (wofi)

#### Elevated/Alternate Background (bg_dim, bg_medium, bg_light)
- **Usage Count**: ~25 instances
- **Purpose**: Layered surfaces, alternate rows, subtle elevation
- **Files**: qutebrowser, wofi, alacritty
- **Examples**:
  - Alternate completion rows (qutebrowser: odd/even)
  - Hover states (wofi)
  - Selected items (qutebrowser tabs)
  - Category headers (qutebrowser completion)

#### Muted/Inactive Background (bg_lighter)
- **Usage Count**: 3 instances
- **Purpose**: Disabled state, very subtle elements
- **Files**: waybar (empty window), wiremix (inactive elements)

### 2. FOREGROUND/TEXT COLORS

#### Primary Text (fg_primary)
- **Usage Count**: ~35 instances
- **Purpose**: Main text, default foreground
- **Files**: waybar, qutebrowser, alacritty, wiremix, wofi
- **Examples**:
  - Window text (waybar)
  - URL text (qutebrowser)
  - Menu items (wofi)
  - Node titles (wiremix)

#### Muted Text (fg_muted, fg_dim)
- **Usage Count**: ~15 instances
- **Purpose**: Secondary text, inactive tabs, subtle information
- **Files**: qutebrowser (inactive tabs), wiremix (labels, inactive elements)
- **Examples**:
  - Inactive tabs (qutebrowser)
  - Disabled text
  - Volume labels (wiremix)

#### Emphasis Text (bright_white)
- **Usage Count**: ~6 instances
- **Purpose**: Maximum emphasis, selected text
- **Files**: qutebrowser (selected tabs, hints)
- **Examples**:
  - Selected tab text
  - Hint match foreground

### 3. STATE/FEEDBACK COLORS

#### Error/Danger (red, bright_red)
- **Usage Count**: ~12 instances
- **Purpose**: Errors, failures, warnings, destructive actions, overload
- **Files**: waybar, qutebrowser, wiremix, fish
- **Examples**:
  - Error messages (qutebrowser)
  - Tab loading errors (qutebrowser)
  - Download errors (qutebrowser)
  - Disk usage (waybar - critical resource)
  - Audio overload/clipping (wiremix)
  - Replace mode indicator (fish)

#### Warning/Caution (yellow, bright_yellow)
- **Usage Count**: ~18 instances
- **Purpose**: Warnings, cautions, insecure states, attention needed
- **Files**: waybar, qutebrowser, fish, wiremix
- **Examples**:
  - Warning messages (qutebrowser)
  - Memory usage (waybar)
  - HTTP (not HTTPS) indicator (qutebrowser)
  - Hint backgrounds (qutebrowser - attention grabbing)
  - Visual mode indicator (fish)
  - Meter center active (wiremix)

#### Success/Confirmation (green, bright_green)
- **Usage Count**: ~20 instances
- **Purpose**: Success, confirmation, secure states, default/active indicators
- **Files**: waybar, qutebrowser, wiremix, fish
- **Examples**:
  - Download complete (qutebrowser)
  - HTTPS secure indicator (qutebrowser)
  - Audio (waybar - sound waves)
  - Tab loading complete (qutebrowser)
  - Default device/stream (wiremix - bold green)
  - Normal mode indicator (fish)
  - Active meter (wiremix)

#### Info/Neutral (blue, bright_blue)
- **Usage Count**: ~15 instances
- **Purpose**: Informational, neutral state, connectivity, loading
- **Files**: waybar, qutebrowser, wiremix, fish
- **Examples**:
  - Info messages (qutebrowser)
  - Network/VPN (waybar - connectivity)
  - Download in progress (qutebrowser)
  - Tab loading indicator (qutebrowser)
  - Passthrough mode (qutebrowser)
  - Volume bar filled (wiremix)
  - Insert mode indicator (fish)

### 4. INTERACTIVE STATES

#### Focus/Active (focus, bright_cyan)
- **Usage Count**: ~35 instances
- **Purpose**: Currently focused element, active state, ready for interaction
- **Files**: waybar, qutebrowser, alacritty, niri, wiremix, wofi
- **Examples**:
  - Workspace button text (waybar)
  - Active window title (waybar)
  - Completion selected item (qutebrowser)
  - Vi mode cursor (alacritty)
  - Active window border (niri)
  - Pinned selected tabs (qutebrowser)
  - Tab selected/active (wiremix)
  - Dropdown selected (wiremix)

#### Hover (ui_hover, ui_hover_active, HARDCODED #98a88f)
- **Usage Count**: ~8 instances
- **Purpose**: Mouse hover feedback
- **Files**: waybar, wofi
- **Examples**:
  - Workspace button hover (waybar)
  - Module hover (waybar: pulseaudio, backlight, network, bluetooth)
  - Menu item hover (wofi)
- **HARDCODED**: Waybar hover text color `#98a88f` (brighter green) - needs palette entry!

#### Selection Background (selection, selection_alt)
- **Usage Count**: ~8 instances
- **Purpose**: Selected content, selection background, borders
- **Files**: alacritty, wofi, niri, qutebrowser
- **Examples**:
  - Text selection (alacritty)
  - Menu selection (wofi)
  - Inactive border (niri)
  - Tooltip border (waybar)

#### Disabled (bright_black)
- **Usage Count**: ~5 instances
- **Purpose**: Disabled/inactive elements
- **Files**: qutebrowser, wofi
- **Examples**:
  - Disabled context menu items (qutebrowser)
  - Empty window title (waybar)

### 5. ACCENT/SPECIAL COLORS

#### Cyan (cyan)
- **Usage Count**: ~8 instances
- **Purpose**: Links, targets, profiles, secondary info
- **Files**: wiremix, wofi
- **Examples**:
  - Node targets (wiremix)
  - Profile names (wiremix)

#### Magenta (magenta, bright_magenta)
- **Usage Count**: ~6 instances
- **Purpose**: Private mode, special states, battery
- **Files**: waybar, qutebrowser
- **Examples**:
  - Battery indicator (waybar)
  - Clock (waybar - "time's mystery")
  - Private browsing mode (qutebrowser)

#### Orange
- **Usage Count**: 1 instance
- **Purpose**: CPU (waybar - "processing heat")

#### Black (for inverted text)
- **Usage Count**: ~25 instances
- **Purpose**: Inverted text on colored backgrounds
- **Files**: qutebrowser, wofi
- **Examples**:
  - Text on colored status bar modes (qutebrowser)
  - Text on hint backgrounds
  - Text on button backgrounds

### 6. SPECIAL PURPOSE COLORS

#### Border (border, selection for borders)
- **Usage Count**: ~10 instances
- **Purpose**: Borders, outlines, separators
- **Files**: niri, wiremix, qutebrowser
- **Examples**:
  - Window borders (niri)
  - Dropdown borders (wiremix)
  - Message borders (qutebrowser)

#### Shadow (shadow)
- **Usage Count**: 1 instance
- **Purpose**: Drop shadows
- **Files**: niri

#### Workspace Active (ui_active_workspace)
- **Usage Count**: 1 instance
- **Purpose**: Active workspace background
- **Files**: waybar

## Hardcoded Colors Analysis

### Waybar Hardcoded Colors (MUST BE ADDED TO PALETTE)

1. **#98a88f** - "Computed brighter green"
   - **Usage**: Workspace button hover text (lines 56, 66)
   - **Purpose**: Brighter version of focus green for hover state
   - **Semantic Need**: `interactive.hover.emphasis` or `text.hover.active`
   - **Solution**: Add to palette as `green_bright` or compute programmatically

2. **#87a96b** - "Custom blend"
   - **Usage**: Backlight module color (line 102)
   - **Purpose**: Yellow-green blend for illumination metaphor
   - **Semantic Need**: `accent.illumination` or `spectrum.yellow_green`
   - **Solution**: Add to palette as `yellow_green` or `green_lime`

3. **#7e9cd8** - "Custom weather blue"
   - **Usage**: Weather module color (line 130)
   - **Purpose**: Light blue for atmosphere/weather metaphor
   - **Semantic Need**: `accent.atmosphere` or `blue.light`
   - **Solution**: Add to palette as `blue_light` or `blue_sky`

## Semantic Category Recommendations

Based on usage patterns, we need these semantic categories:

### 1. SURFACE (backgrounds, containers)
- `surface.primary` → bg_dark (main background)
- `surface.elevated` → bg_medium (raised surfaces)
- `surface.subtle` → bg_dim (alternate rows)
- `surface.overlay` → bg_medium (dialogs, popups)
- `surface.muted` → bg_lighter (disabled areas)

### 2. TEXT (foreground, typography)
- `text.primary` → fg_primary (main text)
- `text.secondary` → fg_muted (secondary text)
- `text.muted` → fg_dim (very subtle text)
- `text.emphasis` → bright_white (maximum emphasis)
- `text.inverted` → black (text on colored backgrounds)
- `text.disabled` → bright_black (inactive text)

### 3. STATE (feedback, status)
- `state.error` → red (failures, critical)
- `state.error.emphasis` → bright_red (urgent errors)
- `state.warning` → yellow (cautions)
- `state.success` → green (confirmations)
- `state.success.emphasis` → bright_green (strong success)
- `state.info` → blue (informational)
- `state.info.emphasis` → bright_blue (highlighted info)

### 4. INTERACTIVE (user interaction feedback)
- `interactive.focus` → bright_cyan (focused elements)
- `interactive.hover.background` → ui_hover (mouse hover bg)
- `interactive.hover.text` → green_bright (NEW: hover text emphasis)
- `interactive.active` → green (active/pressed state)
- `interactive.disabled` → bright_black (disabled elements)

### 5. SELECTION
- `selection.background` → selection (selected content bg)
- `selection.background.alt` → selection_alt (alternate selection)
- `selection.foreground` → fg_default (selected text)

### 6. BORDER
- `border.default` → border (standard borders)
- `border.focus` → focus (focused element border)
- `border.subtle` → bg_light (very subtle borders)
- `border.emphasis` → bright_cyan (highlighted borders)

### 7. ACCENT (special purpose, semantic meanings)
- `accent.link` → cyan (hyperlinks, targets)
- `accent.private` → magenta (private/special modes)
- `accent.battery` → bright_magenta (energy indicators)
- `accent.time` → magenta (time-related)
- `accent.processing` → orange (CPU, processing)
- `accent.storage` → yellow (memory, disk)
- `accent.network` → blue (connectivity)
- `accent.audio` → green (sound)
- `accent.wireless` → bright_cyan (bluetooth, wifi)
- `accent.illumination` → yellow_green (NEW: backlight)
- `accent.atmosphere` → blue_light (NEW: weather)

### 8. INDICATOR (progress, status)
- `indicator.loading.start` → blue (loading begins)
- `indicator.loading.complete` → green (loading done)
- `indicator.loading.error` → red (loading failed)
- `indicator.progress` → bright_cyan (progress bars)

### 9. MODE (editor/app modes)
- `mode.normal` → green (normal/command mode)
- `mode.insert` → blue (insert/input mode)
- `mode.visual` → yellow (visual/selection mode)
- `mode.replace` → red (replace/destructive mode)
- `mode.private` → magenta (private/incognito)
- `mode.passthrough` → blue (passthrough mode)

## Semantic Color Count: 47 Total

### Breakdown by Category:
- **surface**: 5 colors
- **text**: 6 colors
- **state**: 7 colors
- **interactive**: 5 colors
- **selection**: 3 colors
- **border**: 4 colors
- **accent**: 11 colors
- **indicator**: 4 colors
- **mode**: 6 colors

## Next Steps

1. **Add Missing Colors to Palette**:
   - `green_bright: "98a88f"` (hover emphasis)
   - `yellow_green: "87a96b"` (illumination)
   - `blue_light: "7e9cd8"` (atmosphere)

2. **Create semantic_colors Section**:
   - Organize by 9 categories above
   - Map each semantic name to existing dragon colors
   - Document purpose and examples for each

3. **Validate Against Actual Usage**:
   - Ensure every config color usage maps to a semantic color
   - No orphaned semantic colors that aren't used
   - No missing semantic colors that configs need

## Files Impact Assessment

**High Impact** (many color references):
1. qutebrowser/config.py.tmpl (~120 references)
2. waybar/style.css.tmpl (~30 references)
3. wiremix/wiremix.toml.tmpl (~30 references)
4. alacritty/alacritty.toml.tmpl (~22 references)

**Medium Impact**:
5. wofi/style.css.tmpl (~8 references)
6. niri/config.kdl.tmpl (~5 references)
7. fish/config.fish.tmpl (~4 references)