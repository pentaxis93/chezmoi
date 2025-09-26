# Waybar Widget Apps Connection Roadmap

## Overview
This roadmap outlines the plan to connect appropriate applications to waybar widgets for enhanced interactivity while maintaining the ultrathink aesthetic with Kanagawa Dragon theme on niri/Wayland.

## Current Status
- **System**: niri compositor on Wayland
- **Theme**: Kanagawa Dragon (minimalist, monospace aesthetic)
- **Existing connections**:
  - ✅ `pulseaudio` → pavucontrol
  - ✅ `backlight` → scroll actions (brightness control)

## Roadmap for Widget Applications

### Priority 1: System Monitoring
| Widget | Proposed App | Alternative | Rationale |
|--------|--------------|-------------|-----------|
| `cpu` | btop | htop (install) | Terminal-based, matches aesthetic, already installed |
| `memory` | btop | htop (install) | Same app handles both CPU and memory elegantly |
| `disk` | ncdu (install) | nautilus | TUI disk analyzer fits minimal theme better |

### Priority 2: Network & Connectivity
| Widget | Proposed App | Alternative | Rationale |
|--------|--------------|-------------|-----------|
| `network` | nmtui | iwgtk (install) | Built-in with NetworkManager, terminal-based |
| `bluetooth` | bluetuith (install) | blueman (install) | TUI Bluetooth manager matches aesthetic |

### Priority 3: Power & Time
| Widget | Proposed App | Alternative | Rationale |
|--------|--------------|-------------|-----------|
| `battery` | Custom script | powertop (install) | Show battery health, cycles, detailed stats |
| `clock` | `cal` in terminal | gnome-calendar (install) | Minimal calendar view in terminal |

### Priority 4: Information
| Widget | Proposed App | Alternative | Rationale |
|--------|--------------|-------------|-----------|
| `custom/weather` | xdg-open wttr.in | Custom weather app | Opens detailed forecast in browser |

## Implementation Plan

### Phase 1: Install Required Packages
```bash
# Terminal-based utilities for minimal aesthetic
sudo pacman -S ncdu htop
yay -S bluetuith  # AUR package for TUI Bluetooth

# Optional GUI alternatives
# sudo pacman -S blueman iwgtk gnome-calendar powertop
```

### Phase 2: Update Waybar Configuration
Add `on-click` actions to each widget in `~/.config/waybar/config`:

```json
"cpu": {
    "format": "[cpu:{usage}%]",
    "interval": 2,
    "on-click": "alacritty -e btop",
    "tooltip": false
},

"memory": {
    "format": "[mem:{percentage}%]",
    "interval": 5,
    "on-click": "alacritty -e btop",
    "tooltip": false
},

"disk": {
    "interval": 30,
    "format": "[/:{percentage_used}%]",
    "path": "/",
    "on-click": "alacritty -e ncdu /",
    "tooltip": false
},

"network": {
    "format-wifi": "[wifi:{signalStrength}%]",
    "format-ethernet": "[eth]",
    "format-linked": "[no ip]",
    "format-disconnected": "[offline]",
    "on-click": "alacritty -e nmtui",
    "tooltip": false
},

"bluetooth": {
    "format": "[bt:on]",
    "format-disabled": "[bt:off]",
    "format-connected": "[bt:{device_alias}]",
    "on-click": "alacritty -e bluetuith",
    "tooltip": false
},

"battery": {
    "format": "[bat:{capacity}%]",
    "format-charging": "[bat:{capacity}%⚡]",
    "format-plugged": "[bat:{capacity}%🔌]",
    "on-click": "alacritty -e bash -c 'upower -i /org/freedesktop/UPower/devices/battery_BAT0; read'",
    "states": {
        "warning": 30,
        "critical": 15
    },
    "tooltip": false
},

"clock": {
    "format": "{:%a %d %b | %H:%M}",
    "on-click": "alacritty -e bash -c 'cal -3; read'",
    "tooltip": false
},

"custom/weather": {
    "format": "{}",
    "exec": "curl -s 'wttr.in/?format=[%c+%t]' | sed 's/+//' | sed 's/°C/°/'",
    "interval": 3600,
    "on-click": "xdg-open 'https://wttr.in'",
    "tooltip": false
}
```

### Phase 3: Update CSS for Interactive Hover States
Update `~/.config/waybar/style.css` to show hover effects only on clickable widgets:

```css
/* Hover effects only for widgets with on-click actions */
#cpu:hover,
#memory:hover,
#disk:hover,
#network:hover,
#bluetooth:hover,
#battery:hover,
#clock:hover,
#custom-weather:hover,
#pulseaudio:hover,
#backlight:hover {
    background-color: #2a2a37;
    transition: background-color 0.2s ease;
}
```

### Phase 4: Test and Apply
```bash
# Apply changes via chezmoi
chezmoi apply --force ~/.config/waybar/

# Restart waybar
killall -9 waybar; waybar &
```

## Custom Scripts (Optional Enhancements)

### Battery Health Script
Create `~/.config/waybar/scripts/battery-info.sh`:
```bash
#!/bin/bash
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | \
  grep -E "state|time to empty|percentage|capacity|cycles"
echo ""
echo "Press any key to exit..."
read
```

### Network Details Script
Create `~/.config/waybar/scripts/network-info.sh`:
```bash
#!/bin/bash
echo "Network Status:"
ip addr show
echo ""
echo "WiFi Networks:"
nmcli dev wifi
echo ""
echo "Press any key to exit..."
read
```

## Design Principles
1. **Consistency**: All apps should match the terminal-based, minimal aesthetic
2. **Functionality**: Each widget should provide quick access to relevant controls
3. **Visual Feedback**: Hover states only on interactive elements
4. **Performance**: Lightweight apps that don't impact system resources
5. **Keyboard-Friendly**: TUI apps support keyboard navigation

## Future Enhancements
- [ ] Create unified color scheme for all TUI apps
- [ ] Add keyboard shortcuts for launching widget apps
- [ ] Implement widget grouping for related functions
- [ ] Add custom scripts for system information dashboards
- [ ] Consider rofi/wofi integration for app launchers

## Notes
- All terminal apps launch in alacritty (detected as available)
- Hover colors (#2a2a37) match the existing workspace hover theme
- Apps chosen prioritize TUI over GUI to maintain aesthetic consistency
- The plan maintains the existing Kanagawa Dragon color progression