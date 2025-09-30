# Shell Enhancements

## eza - Modern ls Replacement

### Architecture
- **Transparent Integration**: `ls` command transparently replaced with eza
- **Enhanced Features**: Icons, colors, git status integration
- **Zero Learning Curve**: All standard ls options pass through unchanged
- **Implementation**: Fish function wrapper at `home/dot_config/fish/functions/ls.fish.tmpl`

### Benefits
- Nerd Font icons for file types
- Automatic directory grouping
- Git-aware file listings
- Better color coding and formatting

## zoxide - Smart Directory Navigation

### Architecture
- **Frecency-Based Jumping**: Learn frequently and recently used directories
- **Commands**:
  - `z <keyword>` - Jump to best match for keyword
  - `zi <keyword>` - Interactive selection with fzf
- **Integration**: Initialized in Fish config, works alongside lfcd
- **Configuration**: Auto-initialized in `home/dot_config/fish/config.fish.tmpl`

### Philosophy
Complements visual navigation (lfcd/Ctrl+O) with quick frecency-based jumps

### Use Cases
- **Quick jumps**: `z dots` → `~/.local/share/chezmoi`
- **Partial matches**: `z conf` → `~/.config` (learns your patterns)
- **Recent directories**: Just visited ~/Videos/movies? `z mov` gets you back