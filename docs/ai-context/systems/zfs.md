# ZFS Time Machine & Data Integrity System

## Ultra-Zen Philosophy
**"Storage becomes a time machine; every moment preserved, every change reversible, integrity guaranteed"**

## Architecture
- **ZFS Pool** - `zpcachyos` with automatic snapshots and integrity checking
- **Automated Snapshots** - Layered time retention from 15-minute to monthly intervals
- **Automated Scrubbing** - Monthly integrity verification with checksum validation
- **Fish Functions** - Semantic snapshot management commands
- **Copy-on-Write** - Snapshots consume zero space initially, growing only with changes

## Current Pool Structure
```
zpcachyos (236G pool)
├── ROOT/cos/home (11.2G) - User files with snapshot protection
├── ROOT/cos/root (4.69G) - System files with rollback capability
├── ROOT/cos/varcache (2.90G) - Package cache with separate lifecycle
└── ROOT/cos/varlog (204K) - System logs isolated for management
```

## Automated Snapshot Schedule

Time is layered - recent history in fine detail, distant past in broader strokes:

- **Frequent**: Every 15 minutes, keep 4 (last hour)
- **Hourly**: Every hour, keep 24 (last day)
- **Daily**: Every day, keep 31 (last month)
- **Weekly**: Every week, keep 8 (last 2 months)
- **Monthly**: Every month, keep 12 (last year)

Snapshots are named automatically: `@auto-2025-09-30-15h00`

## Data Integrity Guarantee

**Monthly Scrub**: Automated checksum verification of entire pool
- Detects silent data corruption
- Auto-repairs with redundancy (when available)
- Runs on systemd timer: `zfs-scrub-monthly@zpcachyos.timer`

Check scrub status: `zfsstatus`

## Snapshot Management Functions

### `zsnap <dataset> <name>` - Create Manual Snapshot

Create a named snapshot for important moments:

```bash
zsnap zpcachyos/ROOT/cos/home before-upgrade
zsnap zpcachyos/ROOT/cos/home before-cleanup
zsnap zpcachyos/ROOT/cos/root pre-systemd-changes
```

**Safety**: Read-only operation. Cannot destroy data.

**What it does**: Runs `zfs snapshot <dataset>@<name>` transparently.

### `zlist [dataset]` - View Snapshot Timeline

List all snapshots or filter by dataset:

```bash
zlist                              # All snapshots across all datasets
zlist zpcachyos/ROOT/cos/home     # Only /home snapshots
```

**Output shows**:
- Snapshot name and age
- Space consumed (changes since snapshot)
- Creation timestamp

**Safety**: Pure read operation. Just displays information.

### `zclean [days]` - Prune Old Auto-Snapshots

Interactive cleanup of old automatic snapshots (default: 90 days):

```bash
zclean       # Clean auto-snapshots older than 90 days
zclean 30    # More aggressive: 30 days
```

**Safety mechanisms**:
- Only touches `@auto-*` snapshots (manual snapshots ignored)
- Shows complete list before acting
- Requires typing "yes" to confirm
- Can be cancelled at any time

**What it does**:
1. Finds snapshots matching `@auto-*` pattern
2. Filters by age threshold
3. Shows list with space usage
4. Requires explicit confirmation
5. Only then runs `zfs destroy` on each

### `zfsstatus` - Pool Health Summary

Comprehensive health check showing:
- Pool status and errors
- Capacity and fragmentation
- Recent scrub results
- Snapshot count and recent snapshots

```bash
zfsstatus
```

**Safety**: Read-only health check.

## Time Travel: Accessing Snapshots

The most powerful feature - **read-only time travel** through `.zfs/snapshot/`:

### Manual Snapshots
```bash
# You created: zsnap zpcachyos/ROOT/cos/home before-cleanup

# Access old files directly (read-only)
ls /home/.zfs/snapshot/before-cleanup/pentaxis93/.config/
cp /home/.zfs/snapshot/before-cleanup/pentaxis93/.bashrc ~/.bashrc

# Compare current vs snapshot
diff ~/.config/foo.conf /home/.zfs/snapshot/before-cleanup/pentaxis93/.config/foo.conf
```

### Automatic Snapshots
```bash
# Find available auto-snapshots
ls /home/.zfs/snapshot/

# Access yesterday's files
ls /home/.zfs/snapshot/auto-2025-09-29-15h00/pentaxis93/

# Restore a single file from yesterday
cp /home/.zfs/snapshot/auto-2025-09-29-15h00/pentaxis93/important.txt ~/
```

### Why This Approach?

**Selective restore** instead of full rollback:
- ✅ Copy specific files back
- ✅ Compare before/after
- ✅ No risk of destroying current work
- ✅ Read-only access prevents accidents

**Full rollback** (use with extreme caution):
```bash
# This DESTROYS all changes since snapshot!
# Only use when absolutely necessary
zfs rollback zpcachyos/ROOT/cos/home@before-cleanup
```

Prefer the `.zfs/snapshot/` approach for safety.

## Understanding Snapshot Space Usage

**Copy-on-Write Magic**: Snapshots don't copy data - they reference it.

```bash
# Create snapshot (instant, 0 bytes initially)
zsnap zpcachyos/ROOT/cos/home clean-state

# Modify 1GB of files
# Snapshot now shows ~1GB used (old versions it preserves)

# Check space usage
zlist zpcachyos/ROOT/cos/home
```

**Space consumption**:
- New snapshot: 0 bytes (just references)
- As you modify files: snapshot grows (preserves old blocks)
- Delete snapshot: space freed (if no other snapshots need those blocks)

This is why hundreds of snapshots can exist with minimal space cost.

## Manual Recovery Procedures

### Recover Accidentally Deleted File
```bash
# File deleted: ~/Documents/important.pdf

# Find recent snapshot
ls /home/.zfs/snapshot/ | tail -5

# Check if file exists in snapshot
ls /home/.zfs/snapshot/auto-2025-09-30-14h00/pentaxis93/Documents/

# Restore it
cp /home/.zfs/snapshot/auto-2025-09-30-14h00/pentaxis93/Documents/important.pdf ~/Documents/
```

### Recover from Bad Config Change
```bash
# Broke Helix config

# Find snapshot before change
zlist zpcachyos/ROOT/cos/home | grep -B5 "$(date +%Y-%m-%d)"

# Access old config
cat /home/.zfs/snapshot/auto-2025-09-30-13h00/pentaxis93/.config/helix/config.toml

# Restore if good
cp /home/.zfs/snapshot/auto-2025-09-30-13h00/pentaxis93/.config/helix/config.toml ~/.config/helix/
```

### Recover Entire Directory
```bash
# Accidentally deleted ~/Videos/project/

# Find snapshot
ls /home/.zfs/snapshot/auto-2025-09-30-12h00/pentaxis93/Videos/

# Restore whole directory
cp -r /home/.zfs/snapshot/auto-2025-09-30-12h00/pentaxis93/Videos/project ~/Videos/
```

## Advanced Capabilities

### Create Clone (Writable Snapshot)
```bash
# Clone a snapshot for testing
zfs clone zpcachyos/ROOT/cos/home@clean-state zpcachyos/test-environment

# Mount at /mnt/test-env
zfs set mountpoint=/mnt/test-env zpcachyos/test-environment

# Test changes safely, destroy when done
zfs destroy zpcachyos/test-environment
```

### Send/Receive (Backup/Replication)
```bash
# Backup to external drive
zfs send zpcachyos/ROOT/cos/home@backup | pv | zfs receive backup-pool/home

# Incremental backup (only changes)
zfs send -i @last-backup zpcachyos/ROOT/cos/home@new-backup | zfs receive backup-pool/home
```

## Configuration Files
- **Package**: `home/.chezmoidata/packages.yaml` - zfs-auto-snapshot
- **Setup Script**: `home/run_once_setup-zfs-automation.sh.tmpl` - Timer configuration
- **Functions**: `home/dot_config/fish/functions/z*.fish.tmpl` - Management commands

## ZFS Properties (Current)
- **Compression**: zstd (intelligent space savings)
- **Checksums**: sha256 (automatic integrity verification)
- **Dedup**: off (performance over deduplication)
- **Recordsize**: 128K (balanced for mixed workloads)

## Benefits Summary

**Time Machine**:
- 15-minute granularity for recent changes
- Year-long retention of monthly snapshots
- Instant, zero-cost snapshot creation
- Selective file restoration

**Data Integrity**:
- Every block checksummed automatically
- Monthly scrubs detect silent corruption
- Copy-on-write prevents write holes
- Atomic operations prevent partial writes

**Operational Safety**:
- Transparent functions (see exact commands)
- Interactive confirmations for destructive ops
- Manual snapshots before risky changes
- Read-only time travel via `.zfs/snapshot/`

---

*"The river flows forward, but ZFS remembers every drop. Walk backward through time whenever wisdom requires it."*
