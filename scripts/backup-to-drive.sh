#!/usr/bin/env bash
# Copyright © 2026 Vergent Technology Solutions Ltd. All rights reserved.
# Proprietary and confidential - see LICENSE for terms.
#
# scripts/backup-to-drive.sh
# Sync source-code package + clean source snapshot + legal docs to an
# external encrypted APFS volume.
#
# Usage:
#   ./scripts/backup-to-drive.sh
#       -> backs up to /Volumes/RHINO_ARK_BACKUP (default)
#
#   DRIVE="/Volumes/V:ergent Platforms" ./scripts/backup-to-drive.sh
#       -> backs up to a different volume (note macOS replaces "/" with ":"
#          in volume names, so "V/ergent Platforms" mounts as "V:ergent
#          Platforms")
#
# Belt-and-braces: run twice with two DRIVE values to mirror the same
# backup to two volumes on the same physical drive - each volume is its
# own APFS unit so corruption in one doesn't affect the other.
#
# What it does:
#   1. Refuses to run unless the target volume is mounted and writable.
#   2. Mirrors legal docs (LICENSE, NOTICE, DELIVERY, templates/) - rsync,
#      so it's a no-op when nothing has changed.
#   3. Syncs every tarball in dist/ to the drive's dist/ folder, preserving
#      version history (every build kept, none overwritten).
#   4. Creates a clean source snapshot at source-snapshots/source-<date>-<sha>/
#      via `git archive HEAD` - only if a snapshot for this commit doesn't
#      already exist on the drive.
#   5. Updates INDEX.md on the drive with a row describing what was backed up.
#   6. Leaves the drive mounted (you eject manually from Finder).
#
# Run from the repo root. Mac will prompt for the drive's passphrase the
# first time you mount it after each plug-in.

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

DRIVE_VOLUME="${DRIVE:-/Volumes/RHINO_ARK_BACKUP}"
PROJECT_DIR="${PROJECT_DIR:-vergent-co-ke}"
DRIVE="$DRIVE_VOLUME/$PROJECT_DIR"
DATE=$(date +%Y-%m-%d)
SHA=$(git rev-parse --short HEAD)
SNAPSHOT_DIR_NAME="source-${DATE}-${SHA}"
SNAPSHOT_DIR="${DRIVE}/source-snapshots/${SNAPSHOT_DIR_NAME}"

# ── 1. Pre-flight checks ─────────────────────────────────────────────────────

# Check that the actual drive volume is mounted (not the project subdir,
# which is created on first run).
if [ ! -d "$DRIVE_VOLUME" ]; then
  echo "✗ Drive not mounted: $DRIVE_VOLUME"
  echo "  Plug it in, enter passphrase when prompted, then re-run this script."
  exit 1
fi

# Confirm the drive itself is writable.
if ! touch "$DRIVE_VOLUME/.write-test" 2>/dev/null; then
  echo "✗ Drive mounted but not writable: $DRIVE_VOLUME"
  echo "  Check the volume is unlocked, not read-only."
  exit 1
fi
rm -f "$DRIVE_VOLUME/.write-test"

# Create the project-specific subdir if this is the first backup.
mkdir -p "$DRIVE"

# Working-tree warning (informational only - we snapshot HEAD, not the WT)
if [ -n "$(git status --porcelain)" ]; then
  echo "⚠  Working tree has uncommitted changes."
  echo "   The source snapshot will reflect HEAD ($SHA), NOT your working tree."
  echo "   Continue? [y/N]"
  read -r CONT
  [ "$CONT" = "y" ] || [ "$CONT" = "Y" ] || { echo "Aborted."; exit 1; }
fi

# ── 2. Ensure folder structure on drive ──────────────────────────────────────

mkdir -p "$DRIVE/legal/templates"
mkdir -p "$DRIVE/dist"
mkdir -p "$DRIVE/source-snapshots"
echo "→ Drive structure ready at $DRIVE"

# ── 3. Sync legal documents ──────────────────────────────────────────────────

echo "→ Syncing legal documents…"
rsync -a LICENSE NOTICE.md DELIVERY.md "$DRIVE/legal/"
rsync -a --delete templates/ "$DRIVE/legal/templates/"
echo "  ✓ legal/ updated"

# ── 4. Sync dist/ tarballs (preserve version history) ────────────────────────

echo "→ Syncing dist/ package builds…"
if [ -d "dist" ] && [ -n "$(ls -A dist 2>/dev/null)" ]; then
  rsync -a dist/ "$DRIVE/dist/"
  DIST_COUNT=$(ls -1 "$DRIVE/dist"/*.tar.gz 2>/dev/null | wc -l | tr -d ' ')
  echo "  ✓ $DIST_COUNT package build(s) on drive"
else
  echo "  (no local dist/ - skipping)"
  DIST_COUNT=$(ls -1 "$DRIVE/dist"/*.tar.gz 2>/dev/null | wc -l | tr -d ' ')
fi

# ── 5. Source snapshot (one per commit) ──────────────────────────────────────

if [ -d "$SNAPSHOT_DIR" ]; then
  echo "→ Source snapshot for commit $SHA already exists - skipping"
  SNAPSHOT_STATUS="existing"
else
  echo "→ Creating source snapshot → source-snapshots/$SNAPSHOT_DIR_NAME/"
  mkdir -p "$SNAPSHOT_DIR"
  git archive --format=tar HEAD | tar -x -C "$SNAPSHOT_DIR"

  # Defence in depth: strip any .env that may have slipped past .gitignore
  find "$SNAPSHOT_DIR" -type f \( -name ".env" -o -name ".env.*" \) \
    ! -name ".env.example" -delete 2>/dev/null || true

  # Write backup metadata into the snapshot
  cat > "$SNAPSHOT_DIR/BACKUP_INFO.txt" <<EOF
Backup metadata
───────────────────────────────────────────────────────────────────
Snapshot taken:    $(date '+%Y-%m-%d %H:%M:%S %Z')
Source repo:       $REPO_ROOT
Git commit:        $(git rev-parse HEAD)
Short SHA:         $SHA
Git remote:        $(git config --get remote.origin.url || echo 'none')
Working tree:      $([ -z "$(git status --porcelain)" ] && echo 'clean' || echo 'dirty')
Built by host:     $(hostname)
Built by user:     $(whoami)

To verify: extract dist/vergent-assurance-${DATE}-${SHA}.tar.gz
and run \`shasum -a 256 -c MANIFEST.sha256\`.
EOF
  echo "  ✓ source snapshot created"
  SNAPSHOT_STATUS="new"
fi

# ── 6. Update INDEX.md ───────────────────────────────────────────────────────

INDEX="$DRIVE/INDEX.md"
if [ ! -f "$INDEX" ]; then
  cat > "$INDEX" <<'INDEXEOF'
# RHINO_ARK_BACKUP - IP-protection archive

This encrypted external volume holds the source code and packaged builds of
the Carbon Intelligence Programme platform.

## Contents

| Folder | What's inside |
|---|---|
| `legal/` | LICENSE, NOTICE.md, DELIVERY.md, and the recipient templates (cover letter, recipient agreement) |
| `dist/` | Every packaged source-code build, each `.tar.gz` paired with its `.sha256` checksum |
| `source-snapshots/` | Clean unpacked source trees, one per git commit, with `BACKUP_INFO.txt` recording the provenance |

## Ownership

- **Copyright holder:** Vergent Technology Solutions Ltd (Nairobi, Kenya)
- **Programme operator:** Rhino Ark (Kenya) Charitable Trust

Both governed by the proprietary terms in `legal/LICENSE`.

## Backup history

INDEXEOF
fi

LATEST_DIST=$(ls -1t "$DRIVE/dist"/*.tar.gz 2>/dev/null | head -1 | xargs -I{} basename {} 2>/dev/null || echo "none")
TARBALL_SHA=""
if [ -f "${DRIVE}/dist/${LATEST_DIST}" ]; then
  TARBALL_SHA=$(shasum -a 256 "${DRIVE}/dist/${LATEST_DIST}" | awk '{print $1}')
fi
SNAPSHOT_COUNT=$(ls -1d "$DRIVE/source-snapshots"/source-* 2>/dev/null | wc -l | tr -d ' ')

{
  echo ""
  echo "### $(date '+%Y-%m-%d %H:%M:%S %Z')"
  echo ""
  echo "- Git commit:           \`$SHA\` ($(git log -1 --pretty=%s | head -c 80))"
  echo "- Source snapshot:      \`source-snapshots/$SNAPSHOT_DIR_NAME/\` (status: $SNAPSHOT_STATUS)"
  echo "- Total snapshots:      $SNAPSHOT_COUNT"
  echo "- Total package builds: $DIST_COUNT"
  if [ -n "$TARBALL_SHA" ]; then
    echo "- Latest tarball:       \`$LATEST_DIST\`"
    echo "- Tarball SHA-256:      \`$TARBALL_SHA\`"
  fi
  echo "- Backed up by:         $(whoami) on $(hostname)"
} >> "$INDEX"

echo "  ✓ INDEX.md updated"

# ── 7. Summary ───────────────────────────────────────────────────────────────

DRIVE_USED=$(df -h "$DRIVE" 2>/dev/null | tail -1 | awk '{print $3}')
DRIVE_FREE=$(df -h "$DRIVE" 2>/dev/null | tail -1 | awk '{print $4}')

cat <<EOF

═══════════════════════════════════════════════════════════════════════════
  BACKUP COMPLETE
═══════════════════════════════════════════════════════════════════════════

  Drive:           $DRIVE
  Used / free:     ${DRIVE_USED} used · ${DRIVE_FREE} free
  Snapshots:       $SNAPSHOT_COUNT total ($SNAPSHOT_STATUS this run)
  Package builds:  $DIST_COUNT total
EOF

if [ -n "$TARBALL_SHA" ]; then
  echo "  Latest tarball:  $LATEST_DIST"
  echo "  Tarball SHA-256: $TARBALL_SHA"
fi

cat <<EOF

  Drive contents (top level):
EOF
ls -lh "$DRIVE" 2>/dev/null \
  | grep -v '^total' \
  | grep -vE '\.(Spotlight|Trashes|fseventsd|TemporaryItems|DS_Store|DocumentRevisions|VolumeIcon)' \
  | sed 's/^/    /'

cat <<EOF

  Drive left mounted. Eject from Finder (or run \`diskutil eject "$DRIVE"\`)
  when you're done.

═══════════════════════════════════════════════════════════════════════════
EOF
