# Zen MCP Server - AI Model Access for Claude Code

## Ultra-Zen Philosophy
**"Through one gateway, access to many minds; through one key, passage to infinite conversations"**

## Architecture
- **Zen MCP Server** - Python-based MCP server providing AI model access via OpenRouter
- **OpenRouter Integration** - Single API key for access to multiple AI models (Claude, GPT, Gemini, etc.)
- **uvx Execution** - Runs directly from git repository via uvx (no local installation needed)
- **Bitwarden Secrets** - API key stored securely in Bitwarden vault, never in git
- **Fish Auto-loading** - API key loaded as environment variable on shell startup

## Configuration Files
- **Secrets File**: `home/dot_local/state/private_secrets/env/openrouter-api.tmpl` - API key from Bitwarden
- **Fish Auto-loader**: `home/dot_config/fish/conf.d/00-secrets.fish.tmpl` - Loads secrets into environment
- **Package Dependency**: `home/.chezmoidata/packages.yaml` - Includes `uv` package for uvx

## MCP Server Configuration
Added to Claude Code via `claude mcp add-json` command:
```json
{
  "command": "uvx",
  "args": [
    "--from",
    "git+https://github.com/BeehiveInnovations/zen-mcp-server.git",
    "zen-mcp-server"
  ],
  "env": {
    "OPENROUTER_API_KEY": "${OPENROUTER_API_KEY}",
    "DEFAULT_MODEL": "auto"
  }
}
```

## Security Architecture

**Secrets Flow:**
```
Bitwarden Vault ("OpenRouter API" item)
  → Chezmoi Template (bitwarden-password.tmpl)
    → ~/.local/state/secrets/env/openrouter-api
      → Fish conf.d auto-load on startup
        → $OPENROUTER_API_KEY environment variable
          → Claude Code zen-mcp-server process
```

**Security Guarantees:**
- ✅ API key never stored in git repository
- ✅ Key encrypted at rest in Bitwarden vault
- ✅ Follows existing secrets management pattern (VPN credentials)
- ✅ Environment variable only exists in shell session
- ✅ Auto-loads on shell startup, no manual intervention needed

## Setup Requirements

### 1. Bitwarden Vault Entry
Create a Bitwarden login item:
- **Name**: "OpenRouter API"
- **Password field**: Your OpenRouter API key (from https://openrouter.ai)

### 2. Package Installation
The `uv` package must be installed (declaratively managed via `packages.yaml`):
```yaml
- uv  # Astral's fast Python package manager (provides uvx for MCP servers)
```

### 3. Chezmoi Apply
Run `chezmoi apply` to:
- Install uv package
- Deploy OpenRouter API key secret file to `~/.local/state/secrets/env/openrouter-api`

### 4. Shell Restart
Restart Fish shell to load the API key into environment:
```bash
exec fish
```

### 5. MCP Server Registration
Add zen-mcp-server to Claude Code:
```bash
claude mcp add-json zen '{"command":"uvx","args":["--from","git+https://github.com/BeehiveInnovations/zen-mcp-server.git","zen-mcp-server"],"env":{"OPENROUTER_API_KEY":"${OPENROUTER_API_KEY}","DEFAULT_MODEL":"auto"}}'
```

## Usage

Once configured, zen-mcp-server provides AI model access within Claude Code sessions:
- Access to multiple models through OpenRouter (Claude, GPT-4, Gemini, etc.)
- Model selection via "auto" defaults to best available
- Seamless integration within Claude Code conversations

## Verification

Check MCP server status:
```bash
claude mcp list         # Show all configured MCP servers
claude mcp get zen      # Show zen-mcp-server details
```

Expected output:
```
zen: uvx ... - ✓ Connected
```

## Benefits

- **No Local Installation** - Server runs directly from git via uvx
- **Auto-updates** - uvx fetches latest version on each run
- **Secure Secrets** - API key managed via existing Bitwarden infrastructure
- **Multiple Models** - One API key, many model choices via OpenRouter
- **YAGNI Compliance** - Minimal configuration, maximum capability

## OpenRouter Integration

OpenRouter (https://openrouter.ai) provides:
- Unified API for multiple AI model providers
- Pay-per-use pricing across different models
- Automatic fallback and retry logic
- Model availability transparency
- Single API key management

This aligns perfectly with our Ultra-Zen philosophy: one simple key unlocks many powerful capabilities.
