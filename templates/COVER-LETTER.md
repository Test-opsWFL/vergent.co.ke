# COVER LETTER — Vergent Technology Solutions · source-code delivery

*Template: replace all `{{placeholders}}` with the specific values for
this delivery before sending. Keep one signed copy on file.*

---

**Vergent Technology Solutions Ltd**
Karen, Nairobi, Kenya
info@vergent.co.ke · www.vergent.co.ke

For and on behalf of:
**Vergent Technology Solutions Ltd**
Nairobi, Kenya · info@vergent.co.ke

---

**{{date}}**

**Strictly private and confidential**

**To**: {{recipient name}}
{{recipient organisation}}
{{recipient address line 1}}
{{recipient address line 2}}

**By**: {{delivery channel — email / secure transfer / hand delivery}}

---

## Subject: Vergent Technology Solutions — source-code delivery

Dear {{recipient first name or title}},

Further to our recent conversations regarding the **{{authorised purpose
— e.g. foundation board evaluation / buyer diligence / VVB
pre-assessment / source-code escrow}}**, we are pleased to provide the
attached source-code distribution of the Vergent Technology Solutions
platform.

The Software is the proprietary work of **Vergent Technology Solutions
Ltd** (the **Licensor**) and is being supplied to you under licence by
**Vergent Technology Solutions Ltd** (the **Programme Operator**), as
authorised by the Licensor.

This delivery is governed by:

1. The proprietary licence in **`LICENSE`** included in the
   distribution;
2. The signed **Source-Code Recipient Agreement** which we ask you
   to return countersigned before opening the archive;
3. The integrity-verification procedure in **`DELIVERY.md`**, which
   you should follow before relying on the contents.

## Enclosures

| # | Item | Notes |
|---|---|---|
| 1 | `vergent-co-ke-{{date}}-{{shortsha}}.tar.gz` *(or `.tar.gz.enc` if encrypted)* | The source distribution |
| 2 | `{{...}}.tar.gz.sha256` | Outer SHA-256 checksum |
| 3 | `RECIPIENT-AGREEMENT.md` | One-page agreement — countersign and return |
| 4 | This cover letter | For your records |

## Integrity-verification details

| Field | Value |
|---|---|
| **Archive filename** | `vergent-co-ke-{{date}}-{{shortsha}}.tar.gz` |
| **Archive size** | {{n}} bytes ({{n_mb}} MB) |
| **Archive SHA-256** | `{{full-sha256-of-tarball}}` |
| **Encrypted?** | ☐ No  ☐ Yes — AES-256-CBC, PBKDF2; passphrase delivered separately |
| **Internal manifest** | `MANIFEST.sha256` (verifies every file on extraction) |
| **Commit reference** | `{{short-sha}}` (Vergent retains the canonical git history) |

**Important.** The SHA-256 value in the table above is the
**verification anchor**. Please confirm it by independent means
(typically by voice, or by reading it from a different communication
channel than the one that delivered the archive) before extracting.

If the SHA-256 does not match, **do not open the archive** and notify
us immediately at `info@vergent.co.ke` and `info@vergent.co.ke`.

## What we ask of you

1. **Verify the SHA-256** of the archive against the value above.
2. **Sign and return** the enclosed `RECIPIENT-AGREEMENT.md` to
   `info@vergent.co.ke` (cc `info@vergent.co.ke`) **before opening
   the archive**.
3. On receipt of the countersigned Agreement, we will confirm the
   delivery date and the start of the evaluation Term.
4. **Restrict access** to the individuals named on the Agreement.
5. **At the end of the Term** (or on completion of the authorised
   purpose, whichever is earlier), return or destroy all copies of the
   Software and send the written confirmation required by
   `LICENSE` § 5(c).

## A note on what is in the distribution

The archive is a clean snapshot of the platform source code as of
commit `{{short-sha}}`. It contains:

- the application code (Next.js / TypeScript / React)
- the data model (Prisma schema and seed)
- the React-PDF design system and the five diligence documents
- the slipsheets, methodology memo, buyer-briefing materials,
  offset-contract template, and integrity-clause framework
- operational scripts (super-admin provisioning, password rotation,
  data-room sync, PDF generation, source packaging)

It deliberately excludes:

- live environment variables and database credentials (see
  `.env.example` for the schema only);
- `node_modules/` and build artefacts (recoverable via `npm install`
  and `npm run build`);
- the full git history (we retain it; available under separate request).

Full recipient instructions and rebuild steps are in `DELIVERY.md`
inside the archive.

## Any questions

For licensing or redistribution matters:
**Vergent Technology Solutions Ltd** — `info@vergent.co.ke`

For operational matters regarding the Vergent Technology Solutions:
**Vergent Technology Solutions Ltd** — `info@vergent.co.ke`

We look forward to your assessment.

With kind regards,

---

**{{sender name}}**
{{sender role}}
Vergent Technology Solutions Ltd *(for and on behalf of Vergent Technology Solutions Ltd)*

---

*This letter is confidential and is intended solely for the recipient
named above. If you are not the intended recipient, please notify the
sender immediately and destroy all copies.*
