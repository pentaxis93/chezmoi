# Best Practices

## Git History Preservation
- **IMPORTANT**: Use `git mv` instead of delete/create when refactoring files
- Preserves git blame and file history
- Makes tracking changes easier

## Documentation Synchronization
**CRITICAL RULE**: After any code change, scan and update all relevant project documentation including:
- `CLAUDE.md` - Update guidelines when workflows or patterns change
- `README.md` - Update main documentation for new features or changes
- Subdirectory `README.md` files (e.g., `scripts/README.md`) - Keep local documentation current
- **Important**: Documentation updates and code updates are integral parts of the same action - never complete a task without updating affected documentation

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

## Working Principles

1. **Template only when necessary** - machine-specific or secrets
2. **Security first** - never commit secrets, use `private_` prefix
3. **Preview before apply** - `chezmoi diff` then `chezmoi apply -v`

## Package Management Philosophy
- **CachyOS Support Only** - Package management scripts target CachyOS exclusively
- **Declarative Packages** - System packages defined in `home/.chezmoidata/packages.yaml`