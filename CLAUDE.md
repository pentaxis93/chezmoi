# Chezmoi Dotfiles - AI Instructions

> Simplicity is the ultimate sophistication

**Project**: Chezmoi-managed dotfiles following YAGNI principles
**Source**: `~/.local/share/chezmoi` → **Target**: `~` (home directory)

## Quick Reference

@docs/ai-context/chezmoi-commands.md
@docs/ai-context/project-structure.md

---

## CRITICAL DIRECTIVES

### Package Management (IMPORTANT)

**NEVER** use `pacman`, `yay`, or other package managers directly.
**ALWAYS** edit `home/.chezmoidata/packages.yaml` declaratively.
**User runs** `chezmoi apply` to install packages.

**Workflow**:
1. Edit `home/.chezmoidata/packages.yaml` to add/remove packages
2. Inform user that packages have been added to the manifest
3. User runs `chezmoi apply` to trigger installation

### Security Rules (IMPORTANT)

**NEVER** commit secrets to git repository.
**ALWAYS** use `private_` prefix for sensitive files (600 permissions).
**Secrets flow** through Bitwarden templates only (`@bitwarden-*.tmpl`).

See: @docs/ai-context/apps/bitwarden.md

### Core Workflow (IMPORTANT)

```bash
1. chezmoi edit <file>
2. chezmoi diff
3. chezmoi apply -v
4. Update documentation (CRITICAL!)
```

**Documentation Synchronization**: After any code change, update all relevant docs including `CLAUDE.md`, `README.md`, and subdirectory READMEs. Documentation updates and code updates are **integral parts of the same action** - never complete a task without updating affected documentation.

---

## ARCHITECTURE PRINCIPLES

### YAGNI Philosophy
**Each configuration option must justify its existence.**
- Prefer defaults when they align with our principles
- Choose simplicity over complexity when outcomes are equivalent
- Delete before adding

### Helix-Native Keybindings Everywhere
- Use `ge` for end (not `G`) - "go end" is semantically clearer
- Use `gh/gl` for line start/end - "go home/line" is intuitive
- Prioritize semantic clarity over vim tradition
- Apply consistently across all applications that support vi-mode

See: @docs/ai-context/systems/keybindings.md

### Semantic Actions Over Physical Keys
Keybindings represent **intentions**, not keys:
- `navigate.prev` = context-appropriate leftward movement
- Same intention manifests appropriately per application
- Maintain consistency through `home/.chezmoidata/keybindings.yaml`
- If conflicts arise, **discuss with human immediately**

### Centralized Color System
**Single source of truth**: `home/.chezmoidata/colors.yaml`
- Terminal colors are semantic purposes, not hues
- `color0` = background, `color7` = foreground, `color14` = focus
- Use template fragments: `color-hex.tmpl`, `color-quoted.tmpl`, etc.
- **NEVER** hardcode colors outside the centralized system

See: @docs/ai-context/systems/colors.md

### Reverse Video Selections Philosophy
*"Do not paint the water to make the fish visible. Let the fish and water exchange places."*

Selections use **reverse video** (fg/bg swap), not colored backgrounds:
- Perfect contrast always guaranteed
- No configuration complexity
- Universal solution for all TUI apps

---

## THINGS NOT TO DO

**DON'T** create duplicate configs outside chezmoi source directory.
**DON'T** hardcode colors (use color templates from `colors.yaml`).
**DON'T** break git history (use `git mv` for refactoring, not delete+create).
**DON'T** skip documentation updates after code changes (CRITICAL).
**DON'T** install packages directly (use declarative `packages.yaml`).
**DON'T** commit secrets (use Bitwarden templates).

---

## APPLICATION CONFIGURATIONS

### Core Applications
- @docs/ai-context/apps/mpv.md - Media player with LF browser integration
- @docs/ai-context/apps/qutebrowser.md - Keyboard-driven web browser
- @docs/ai-context/apps/weechat.md - IRC client with XDCC support
- @docs/ai-context/apps/transmission.md - BitTorrent with VPN killswitch
- @docs/ai-context/apps/lf.md - Terminal file manager
- @docs/ai-context/apps/lazygit.md - Git TUI with reverse video

### System Tools
- @docs/ai-context/apps/vpn.md - OpenVPN with Bitwarden secrets
- @docs/ai-context/apps/wiremix.md - PipeWire audio mixer TUI
- @docs/ai-context/apps/shell-enhancements.md - eza, zoxide, Fish shell

---

## SYSTEM ARCHITECTURES

- @docs/ai-context/systems/colors.md - Semantic color system & reverse video
- @docs/ai-context/systems/keybindings.md - Semantic keybinding architecture
- @docs/ai-context/systems/spectrum.md - Algorithmic color spectrum generation

---

## REFERENCE FILES

- @docs/ai-context/critical-files.md - Key files and their purposes
- @docs/ai-context/best-practices.md - Development guidelines

---

## WORKING PRINCIPLES

1. **Template only when necessary** - machine-specific or secrets
2. **Security first** - never commit secrets, use `private_` prefix
3. **Preview before apply** - `chezmoi diff` then `chezmoi apply -v`
4. **Document everything** - in-document comments, inline docs, discoverable methods
5. **Git history matters** - use `git mv`, not delete+create
6. **YAGNI mindfulness** - justify every configuration option

---

*Each configuration choice must earn its place.*