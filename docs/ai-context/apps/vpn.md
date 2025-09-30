# VPN Configuration with OpenVPN

## Ultra-Zen Philosophy
**"The path to the network flows through the vault, authenticated and encrypted"**

## Architecture
- **OpenVPN Client** - Secure tunneling daemon for VPN connections
- **Bitwarden Integration** - Credentials retrieved from vault via templates
- **Fish Functions** - Semantic wrappers for connection management (`vpc`, `vpd`, `vps`)
  - Work both as abbreviations (interactive) and functions (scripts)
  - Abbreviations expand: `vpc` → `vpn-connect`
  - Functions call: `vpc` → `vpn-connect` directly
- **Systemd Service** - Optional user-level service for automatic connection

## Configuration Files
- **VPN Config**: `home/dot_config/private_openvpn/goosevpn.conf.tmpl` - Main OpenVPN configuration
- **Auth File**: `home/dot_local/state/private_secrets/openvpn/goosevpn-auth.tmpl` - Credentials from Bitwarden
- **Service**: `home/dot_config/systemd/user/goosevpn.service.tmpl` - Systemd service (optional)
- **Auto-loading**: `home/dot_config/fish/conf.d/00-secrets.fish.tmpl` - Loads secrets into environment

## Usage
```bash
vpc  # Connect to VPN (vpn-connect)
vpd  # Disconnect from VPN (vpn-disconnect)
vps  # Check VPN status (vpn-status)

# Or use systemd (after enabling)
systemctl --user start goosevpn
systemctl --user enable goosevpn  # Auto-connect on boot
```

## Security Features
- All config files use `private_` prefix (600 permissions)
- `auth-nocache` prevents password caching in memory
- Credentials only exist when Bitwarden is unlocked
- Secrets stored in `~/.local/state/secrets/` outside project directories
- Environment variables auto-loaded by Fish for script access