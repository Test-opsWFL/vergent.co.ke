# DELIVERY — Vergent Technology Solutions · source-code package

Copyright © 2026 Vergent Technology Solutions Ltd. All rights reserved.
Distributed under licence by Vergent Technology Solutions Ltd.

This document accompanies an authorised source-code delivery of the
Vergent Technology Solutions platform.

It explains what is in the archive, what is deliberately excluded, how to
verify the archive has not been tampered with, and how to rebuild the
platform from source.

Subject to the proprietary terms in [`LICENSE`](./LICENSE) and the signed
Recipient Agreement that authorised this delivery.

---

## 1. What is in this package

| Path | Contents |
|---|---|
| `app/` | Next.js App Router routes — `(public)`, `(portal)`, `(print)` |
| `components/` | React components — UI primitives, cards, charts, forms, layout |
| `lib/` | Domain logic — auth, calculations, endowment math, programme phase, pitch-notes content, benchmark profiles, integrity-clause data |
| `lib/pdf/` | React-PDF design system + the five diligence documents |
| `prisma/` | Database schema (`schema.prisma`) and seed (`seed.ts`) |
| `public/` | Static assets — fence photos, Annex 1 map, generated diligence PDFs |
| `scripts/` | Operational scripts — admin seeding, password rotation, data-room sync, PDF generation, source packaging |
| `docs/` | Internal docs — assumptions, buyer-value proposition |
| `LICENSE`, `NOTICE.md`, `DELIVERY.md` | Legal + delivery documentation |
| `package.json`, `package-lock.json` | Dependency manifest |
| `next.config.mjs`, `tsconfig.json`, `tailwind.config.ts`, etc. | Build configuration |
| `MANIFEST.sha256` | SHA-256 of every file in the package (integrity manifest) |

## 2. What is deliberately excluded

The packaging script (`scripts/package-source.sh`) uses `git archive` and
deletes any environment files before sealing. The archive therefore does
NOT contain:

- `.env`, `.env.local`, `.env.production` (database URLs, auth secrets, etc.)
- `node_modules/` (recoverable via `npm install`)
- `.next/` (build cache, recoverable via `npm run build`)
- `dist/` (output of this packaging script)
- `.git/` (full git history — see §5 if you need history)
- Operating-system artefacts (`.DS_Store`, etc.)
- Any deck QA artefacts (`slide-*.jpg`, `*.pptx`, debug PDFs)

If you require access to the live database, that is governed by a separate
agreement with the Trust. Source code does not include any live data.

## 3. Verifying integrity

Two layers of integrity:

### Per-file manifest

`MANIFEST.sha256` contains a SHA-256 hash of every file in the package.
Verify it after extraction:

```bash
cd <extracted-directory>
shasum -a 256 -c MANIFEST.sha256
```

(Every line should report `OK`. Any line reporting `FAILED` indicates a
modified or corrupted file.)

### Archive checksum

The outer `.tar.gz` (or `.tar.gz.enc` if encrypted) has its SHA-256 stored
in a sibling `.sha256` file, communicated separately by the Trust.

```bash
shasum -a 256 vergent-co-ke-<date>-<sha>.tar.gz
# Compare to the value provided alongside.
```

### Encrypted variant (optional)

If the archive was packaged with the `--encrypt` flag, it is AES-256-CBC
encrypted via OpenSSL with a PBKDF2-derived key. Decrypt with:

```bash
openssl enc -d -aes-256-cbc -pbkdf2 \
    -in vergent-co-ke-<date>-<sha>.tar.gz.enc \
    -out vergent-co-ke-<date>-<sha>.tar.gz
# Then verify SHA-256 of the decrypted .tar.gz as above.
```

The passphrase will be communicated by the Trust separately from the
encrypted archive (via voice, in person, or via a different secure
channel).

## 4. Building from source

Prerequisites: Node.js ≥ 20, npm ≥ 10, Postgres (or Neon-compatible).

```bash
tar -xzf vergent-co-ke-<date>-<sha>.tar.gz
cd vergent-co-ke-<date>-<sha>

npm install

# Provide your own database connection string + auth secret
cat > .env.local <<EOF
DATABASE_URL="postgresql://..."
AUTH_SECRET="$(openssl rand -base64 32)"
EOF

# Apply schema to your database, then seed
npx prisma db push
npx tsx prisma/seed.ts

# Provision your super-admin
SUPER_ADMIN_EMAIL=your@email.example \
SUPER_ADMIN_PASSWORD=YourStrongPassword \
SUPER_ADMIN_NAME="Your Name" \
npx tsx scripts/create-superadmin.ts

# Run
npm run dev    # http://localhost:3000
# or
npm run build && npm start
```

## 5. Git history

This package contains the working-tree HEAD only — not the git history.
The Trust retains the canonical git history. If you require access to the
history (e.g. for an IP-due-diligence trace), please raise a written
request to `info@vergent.co.ke`.

## 6. Provenance

- **Origin**: Vergent Technology Solutions Ltd · Vergent Technology Solutions
- **Packaging script**: `scripts/package-source.sh` (also included in the archive)
- **Reproducibility**: Running `npm install && npm run build` against the
  pinned `package-lock.json` produces the same build output, modulo
  per-machine timestamps and any environment-specific configuration.

## 7. Contact

For licensing, redistribution consent, or escrow release:

> Vergent Technology Solutions Ltd
> Nairobi, Kenya
> info@vergent.co.ke

For operational matters relating to the Vergent Technology Solutions:

> Vergent Technology Solutions Ltd
> Karen, Nairobi, Kenya
> info@vergent.co.ke
> www.vergent.co.ke
