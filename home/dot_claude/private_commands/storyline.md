---
name: storyline
description: Analyze uncommitted changes and execute a Zen commit strategy
---

# Storyline Commit Strategy

Analyze all uncommitted changes, understand the intent behind them, and create atomic, meaningful commits following the Zen principle: *"Each commit should tell a single story, complete and self-contained."*

## Workflow

1. **Discover Changes**: Examine all uncommitted modifications using git status and git diff
2. **Understand Intent**: Analyze the changes to comprehend what was accomplished
3. **Identify Logical Groups**: Find related changes that tell a coherent story together
4. **Plan Commit Strategy**: Design atomic commits that each serve a single purpose
5. **Execute Commits**: Create the commits with clear, intentional messages

## Commit Philosophy

- **Atomic Commits**: Each commit does one thing well
- **Semantic Messages**: Use conventional prefixes (feat, fix, refactor, docs, style, test, chore)
- **Intent Over Implementation**: Messages explain *why*, not just *what*
- **Logical Progression**: Commits build upon each other in a sensible order
- **Clean History**: Each commit leaves the codebase in a working state

## Examples

Instead of one large commit with "various changes", create:
- `feat(mpv): add subtitle fuzzy matching with 90% threshold`
- `fix(lf): correct preview script permissions`
- `refactor(fish): extract vpn status check into function`
- `docs: update CLAUDE.md with new keybinding philosophy`

## Special Considerations

- If changes span multiple unrelated features, propose splitting into separate commits
- If changes are tightly coupled, keep them together
- Always verify tests pass after each commit (if applicable)
- Consider using `git add -p` for partial file staging when needed
- Respect existing commit message conventions in the repository

*Remember: The git history is a story. Make it worth reading.*