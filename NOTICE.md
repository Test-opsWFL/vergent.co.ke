# NOTICE — Third-party components

Copyright © 2026 Vergent Technology Solutions Ltd. All rights reserved.

The Vergent Technology Solutions platform — sole copyright held by
Vergent Technology Solutions Ltd — incorporates third-party open-source software.
Each such component is licensed under its respective terms, which remain
in force notwithstanding the terms of the proprietary LICENCE that
governs this distribution as a whole.

The list below identifies significant production dependencies. The complete,
authoritative dependency tree (with versions and resolved licences) is
recorded in **`package-lock.json`** and can be regenerated at any time with:

```bash
npm ls --all --json > sbom.json
```

## Significant production dependencies

| Component | Purpose | Licence |
|---|---|---|
| Next.js | Application framework (App Router, RSC, routing) | MIT |
| React, React DOM | UI library | MIT |
| TypeScript | Type system | Apache-2.0 |
| Tailwind CSS | Utility-first styling | MIT |
| @prisma/client, prisma | Database ORM and migrations | Apache-2.0 |
| Auth.js (NextAuth) | Authentication | ISC |
| bcryptjs | Password hashing | MIT |
| zod | Schema validation | MIT |
| @react-pdf/renderer | PDF generation (data-room diligence docs) | MIT |
| pptxgenjs | PowerPoint generation (Wyss deck) | MIT |
| recharts | Chart rendering | MIT |
| leaflet, react-leaflet | Map rendering | BSD-2-Clause / Hippocratic 2.1 |
| lucide-react | Icon set | ISC |
| Radix UI primitives (`@radix-ui/*`) | Accessible UI primitives | MIT |
| date-fns | Date utilities | MIT |
| @neondatabase/serverless | Postgres driver | Apache-2.0 |

## Development-only dependencies

Development-only components (vitest, eslint, ts-node, etc.) are listed in
`package.json` under `devDependencies` and are not part of the runtime
distribution. They are licensed under their respective open-source terms
(predominantly MIT, ISC, BSD).

## Compliance

Recipients of this source distribution who modify or redistribute the
included open-source components must continue to honour the terms of those
components' respective licences. The proprietary LICENCE governing this
distribution does not, and cannot, alter or override the rights granted by
those upstream licences.

For any uncertainty, the canonical resolution is:

1. The text of the upstream component's own LICENCE file (resolvable from
   `node_modules/<package>/LICENSE` after `npm install`).
2. The version recorded in `package-lock.json`.

Last reviewed: 2026-05.
