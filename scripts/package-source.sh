#!/usr/bin/env bash
# Copyright © 2026 Vergent Technology Solutions Ltd. All rights reserved.
# Proprietary and confidential - see LICENSE for terms.
#
# scripts/package-source.sh
# Build a clean, verifiable, optionally-encrypted source distribution of the
# Rhino Ark Carbon Intelligence Programme platform.
#
# Usage:
#   ./scripts/package-source.sh                # plaintext .tar.gz
#   ./scripts/package-source.sh --encrypt      # plaintext .tar.gz + AES-256 .tar.gz.enc
#
# Output lands in ./dist/ - gitignored.
#
# Behaviour:
#   1. Uses `git archive HEAD` to snapshot ONLY tracked files (respects .gitignore).
#   2. Strips any .env files that may have slipped in (belt-and-braces).
#   3. Writes MANIFEST.sha256 - SHA-256 of every file in the staging dir.
#   4. Tarballs into ./dist/<name>-<date>-<short-sha>.tar.gz.
#   5. Writes the outer .tar.gz's SHA-256 to a sibling .sha256 file.
#   6. If --encrypt is passed, AES-256-CBC encrypts the tarball (passphrase
#      prompted interactively; never written to disk).
#
# Run from the repo root.

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

# ── Args ──────────────────────────────────────────────────────────────────────
ENCRYPT=0
for arg in "$@"; do
  case "$arg" in
    --encrypt|-e) ENCRYPT=1 ;;
    --help|-h)
      sed -n '2,20p' "$0" | sed 's|^# ||;s|^#||'
      exit 0
      ;;
    *)
      echo "✗ Unknown argument: $arg" >&2
      echo "  Use --encrypt to AES-256 encrypt, or --help for usage." >&2
      exit 1
      ;;
  esac
done

# ── Working-tree cleanliness check ────────────────────────────────────────────
if [ -n "$(git status --porcelain)" ]; then
  echo "⚠  Working tree is not clean. Uncommitted changes will NOT be included"
  echo "   in the package (only HEAD is archived). Continue? [y/N]"
  read -r CONT
  [ "$CONT" = "y" ] || [ "$CONT" = "Y" ] || { echo "Aborted."; exit 1; }
fi

# ── Naming ────────────────────────────────────────────────────────────────────
DATE=$(date +%Y-%m-%d)
SHA=$(git rev-parse --short HEAD)
PACKAGE_BASENAME="vergent-co-ke-${DATE}-${SHA}"

OUT_DIR="$REPO_ROOT/dist"
STAGE="$OUT_DIR/$PACKAGE_BASENAME"
TARBALL="$OUT_DIR/${PACKAGE_BASENAME}.tar.gz"

mkdir -p "$OUT_DIR"
rm -rf "$STAGE" "$TARBALL" "${TARBALL}.sha256" "${TARBALL}.enc" "${TARBALL}.enc.sha256"

# ── 1. Snapshot tracked files via git archive ────────────────────────────────
echo "→ Archiving HEAD (commit ${SHA}) - tracked files only…"
mkdir -p "$STAGE"
git archive --format=tar HEAD | tar -x -C "$STAGE"

# ── 2. Belt-and-braces: strip any .env that slipped past .gitignore ──────────
echo "→ Stripping any .env files (defence in depth)…"
find "$STAGE" -type f \( -name ".env" -o -name ".env.*" \) \
  ! -name ".env.example" -delete 2>/dev/null || true

# ── 3. Per-file SHA-256 manifest ──────────────────────────────────────────────
# The manifest must not list itself: at the moment `find` runs, the redirect
# below has already created an empty MANIFEST.sha256, whose hash would not
# match the file's later filled-in content. Exclude it from the listing.
echo "→ Generating MANIFEST.sha256…"
(
  cd "$STAGE"
  find . -type f ! -name "MANIFEST.sha256" -print0 \
    | LC_ALL=C sort -z \
    | xargs -0 shasum -a 256
) > "$STAGE/MANIFEST.sha256"

# Count files
FILE_COUNT=$(wc -l < "$STAGE/MANIFEST.sha256" | tr -d ' ')
echo "  ✓ ${FILE_COUNT} files manifested"

# ── 4. Tarball ───────────────────────────────────────────────────────────────
echo "→ Compressing → ${TARBALL}…"
(cd "$OUT_DIR" && tar -czf "${PACKAGE_BASENAME}.tar.gz" "$PACKAGE_BASENAME")

# ── 5. Outer checksum ────────────────────────────────────────────────────────
shasum -a 256 "$TARBALL" | awk '{print $1}' > "${TARBALL}.sha256"
TARBALL_SHA=$(cat "${TARBALL}.sha256")
TARBALL_SIZE=$(du -h "$TARBALL" | awk '{print $1}')

# ── 6. Optional encryption ───────────────────────────────────────────────────
ENC_BLOCK=""
if [ "$ENCRYPT" -eq 1 ]; then
  echo "→ Encrypting with AES-256-CBC (PBKDF2)…"
  echo "  You will be prompted for a passphrase. Communicate it separately"
  echo "  from the encrypted archive (voice, in person, or a different channel)."
  echo
  openssl enc -aes-256-cbc -pbkdf2 -salt \
    -in "$TARBALL" \
    -out "${TARBALL}.enc"

  shasum -a 256 "${TARBALL}.enc" | awk '{print $1}' > "${TARBALL}.enc.sha256"
  ENC_SHA=$(cat "${TARBALL}.enc.sha256")
  ENC_SIZE=$(du -h "${TARBALL}.enc" | awk '{print $1}')

  ENC_BLOCK="
  encrypted artefact: ${TARBALL}.enc
  size:               ${ENC_SIZE}
  sha-256:            ${ENC_SHA}
"
fi

# Clean up staging directory (the tarball is the deliverable)
rm -rf "$STAGE"

# ── Summary ──────────────────────────────────────────────────────────────────
cat <<EOF

═══════════════════════════════════════════════════════════════════════════
  RHINO ARK CARBON INTELLIGENCE PROGRAMME · SOURCE PACKAGE READY
═══════════════════════════════════════════════════════════════════════════

  commit:     ${SHA}
  files:      ${FILE_COUNT}

  artefact:   ${TARBALL}
  size:       ${TARBALL_SIZE}
  sha-256:    ${TARBALL_SHA}
${ENC_BLOCK}
  Distribute the .tar.gz (or .tar.gz.enc) AND the corresponding .sha256
  via separate channels. Recipients should verify the SHA-256 before
  extracting, then run:

      shasum -a 256 -c MANIFEST.sha256

  inside the extracted directory to verify file-level integrity.

  See DELIVERY.md inside the archive for full recipient instructions.

═══════════════════════════════════════════════════════════════════════════
EOF
