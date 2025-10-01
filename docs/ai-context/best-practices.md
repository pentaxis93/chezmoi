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

1. **Semantic Color System (MANDATORY)** - ALL new configs must use semantic color templates
   - NEVER hardcode hex colors
   - ALWAYS use `{{ template "color-hex.tmpl" (index $theme $s.semantic.category) }}`
   - Define semantic meaning first, let theme provide color
   - See @docs/ai-context/systems/colors.md

2. **Semantic Keybinding System (MANDATORY)** - ALL new configs must use keybinding templates for core actions
   - NEVER hardcode semantic keybindings (navigate, discover, dismiss, transform, preserve, select, manipulate)
   - ALWAYS use `{{ template "keybind-<app>.tmpl" dict ... }}`
   - Create app-specific template if needed (follow existing patterns)
   - Hardcode ONLY application-specific non-semantic bindings
   - See @docs/ai-context/systems/keybindings.md

3. **Helix-Native Navigation** - Configure Helix-native vi keybindings in every tool that supports them
   - Follow Helix's semantic improvements (e.g., `ge` for end, not `G`)
   - Prioritize semantic clarity over vim tradition
   - Use `gh/gl` for line start/end

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
- **Semantic Organization** - Packages grouped by intention, not just proximity
  - Each category reveals purpose (System & Security, Media, Development, etc.)
  - Comments explain **why** a package exists, not just **what** it does
  - Dependencies stay cohesive (e.g., lf + all its preview tools in one block)
  - Flow: System → User Applications → Development Tools