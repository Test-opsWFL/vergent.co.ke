# Vergent Technology Solutions — Website Rebuild Brief

## Project at a glance

Rebuild **vergent.co.ke** as a modern static site, replacing the current WordPress + WPBakery setup that has become brittle and broken (a key plugin, `liquid_js_composer`, is missing from the server with no recoverable backup). The new site lives in a GitHub repository the owner controls, deploys automatically to Cloudflare Pages on every push, and supports visual content editing through Decap CMS so the (non-technical) site owner can update content without touching code.

The owner is a busy executive at a B2B tech consultancy. The site rarely changes. Every decision should optimize for **zero maintenance, fast load, and signaling competence to enterprise clients** — not for content velocity.

The current site is in **Coming Soon Mode** while the rebuild happens. There's no content available to scrape live. All content references are in `reference-pages/` (extracted from a WordPress XML export).

---

## About Vergent

**Vergent Technology Solutions Ltd.** is a Kenyan-headquartered B2B technology consultancy that delivers enterprise IT solutions across cloud, security, software development, and modernization. They serve mid-to-large enterprises, financial institutions, and government clients across multiple regions.

### Brand details

- **Name:** Vergent Technology Solutions
- **Current tagline:** "Architecting the Digital Landscape of Tomorrow"
- **Positioning:** A turnkey Software, Cyber AIOps, and Security Solution Provider
- **Email:** info@vergent.co.ke
- **Phone:** +254 (0)706 620 630
- **LinkedIn:** https://www.linkedin.com/company/vergent-technology/
- **Offices:** Nairobi, Kenya · Dubai, UAE · Bishkek, Kyrgyzstan
  - Mentioned elsewhere on the site: also support presence in Philippines and India for "round-the-clock support"

### Company narrative (from About page, current copy)

> Established to steer customers through the next generation of Software, Business and security innovation using leading edge business automation, software development and technology consultation services.
>
> We help our clients leverage new technologies to competitive advantage and support their software development. We deliver high value innovated solutions by bridging the gap between business and technology.
>
> Vergent Technology Solutions Ltd. capabilities are uniquely distinguished from other software providers as we are specialized in developing various automated solutions through our established multi-branches in Kenya, Kyrgyzstan, Philippines and India for continuous round the clock support.

You can rewrite/tighten this — the original is wordy. Keep the substance: multi-region, automation-focused, bridge between business and technology.

---

## What they actually do — services & solutions

There are two different sets of offerings on the current site. Consolidate them sensibly into a single Services page.

### Core consulting services (from Home page)

1. **Cloud Migration** — Smooth transition to cloud environments
2. **CRM Implementation** — Customizable solutions for enhanced customer engagement
3. **System Rationalization** — Efficient system optimization to reduce costs
4. **Modernization** — Adopt the latest technologies for a competitive edge
5. **AWS Optimization & Licensing Assessment** — Optimize AWS usage and software licenses for maximum efficiency and compliance
6. **IT Managed Services & Cybersecurity Solutions** — Comprehensive monitoring and protection for your IT infrastructure
7. **Business Intelligence & Custom Software Development** — Turn data into actionable insights and develop unique software solutions

### Security & specialized solutions (from Services page)

These appear as service categories on the current site — fold into the main services page or treat as a sub-section:

- Analytics & Cyber Security Solution
- Attack Surface Reduction
- IT Service Management (ITSM)
- Secure Development / DevSecOps
- Compliance Monitoring Solutions
- Software Design and Development
- ID Pass Security
- Face ID Protection
- Financial Security
- Digital Solutions

### Their consulting approach (from Home page bullets)

How they work with clients:

- Aligning Security Models with SABSA, ITIL, and COBIT
- Comprehensive Enterprise Security Architecture reviews
- System Configuration assessments
- IT Licence audits
- IT Operations Consulting
- Project Management
- Vendor Management / Supplier Selection

### Expertise areas (from About page)

- **Microsoft Cloud Services and Dynamics:** Azure, Office365, Dynamics 365
- **Oracle OLA Rationalization:** Strategic license management for Oracle environments
- **SAP Modernization:** Transition to SAP S/4HANA cloud solutions
- **AWS Optimization:** Tailoring AWS usage for performance and cost efficiency
- **Licensing Assessment:** Software license value and compliance

### Past work themes (from About page — vague)

- Boosted Microsoft Dynamics efficiency
- Streamlined Oracle usage
- Revitalized SAP landscapes
- Optimized AWS configurations
- Minimized licensing expenses

These are intentionally light. Treat as inspiration for a "What we deliver" section, but don't fabricate specifics or invent client names.

### Technology partners

Microsoft, Oracle, SAP, Amazon Web Services, Centerity (centerity.com), Dreamvise (dreamvise.com), SysAid (sysaid.com). Partner logos are in `assets/partner-logos/` if owner provided them.

---

## Design direction: total redesign

The owner asked for a fresh take. **Do not copy the current site's layout.** Use it only as content reference. The current site is a generic Hub WordPress theme with WPBakery — we want something that signals serious enterprise infrastructure provider, not generic agency.

### Aesthetic targets

- **Editorial, confident, restrained.** Think Linear, Vercel, Stripe, Anthropic, Retool — sites that read as serious infrastructure brands rather than marketing brochures.
- **Generous whitespace.** Type-driven hierarchy. No hero stock photos of people in suits shaking hands.
- **Subtle motion only.** No carousels, no parallax, no animated icon spam. One or two restrained scroll-triggered fades at most.
- **Dark mode support** built in from the start.
- **Sharp on mobile.** Most enterprise buyers will glance at this on a phone first.

### Typography

Pair a strong display sans for headlines with a clean reading sans for body. Some good combinations to consider (pick what serves the design):

- Inter or Geist for body, with Söhne / Neue Haas Grotesk-style display
- Manrope or Satoshi for everything (single-family approach is fine and modern)
- A serif accent (Fraunces, Newsreader) for select pull quotes is allowed but optional

### Color

The current site has an orange accent (`#F5821F`) — feel free to keep, evolve, or replace. The owner has no attachment to it. A more sophisticated palette is welcome: warm neutrals, a single accent, deep ink text. Avoid pure black; avoid Material-design blue.

### What to avoid

- WordPress / WPBakery aesthetics: gradient buttons, animated icons in cards, "fancy headings" with multiple weights
- Hero carousels or auto-rotating sliders
- Stock photography of generic businesspeople or generic "tech" imagery
- Excessive iconography (the current site over-relies on tiny icons)
- "Liquid effects," cursor followers, page transitions
- "Hub theme" leftover content (e.g. references to Paris, renewable energy — the Solutions page was never customized away from theme demo content; ignore it entirely)

---

## Site structure

Four pages. Don't add more.

1. **Home** (`/`)
   - Hero with brand statement (the "Architecting the Digital Landscape of Tomorrow" tagline can stay or evolve — owner's not married to it)
   - One-paragraph positioning
   - Services overview (link to /services)
   - Selected partner logos
   - Single CTA to contact

2. **About** (`/about`)
   - Company narrative (from the About page content above)
   - Office locations (Nairobi · Dubai · Bishkek)
   - "How we work" — anchored on the consulting approach bullets
   - Optional: leadership / founding story (placeholder copy if real bios aren't available)

3. **Services** (`/services`)
   - The 7 core consulting services from the Home page
   - The expertise areas (Microsoft, Oracle, SAP, AWS, Licensing) as a secondary section
   - The security/specialized solutions list as a third section, or fold into above
   - These should live as Markdown files under `src/content/services/` so they're CMS-editable
   - Don't list every single security solution in equal weight — group them. Suggested grouping:
     - **Cloud & Modernization** — Cloud Migration, AWS Optimization, SAP Modernization, Oracle Rationalization, Microsoft Cloud Services
     - **Security & Compliance** — Cybersecurity Solutions, Attack Surface Reduction, DevSecOps, Compliance Monitoring, ID Pass Security, Face ID Protection, Financial Security
     - **Software & Data** — Custom Software Development, Business Intelligence, CRM Implementation, ITSM, System Rationalization, Digital Solutions

4. **Contact** (`/contact`)
   - Working contact form (Web3Forms — see Forms section below)
   - Email: info@vergent.co.ke
   - Phone: +254 (0)706 620 630
   - Office locations (Nairobi, Dubai, Bishkek)
   - LinkedIn link

A persistent header (logo + nav + "Let's talk" CTA) and a minimal footer (copyright + LinkedIn + maybe email and phone).

---

## Tech stack — non-negotiable

- **Framework:** Astro (latest stable). No React/Vue unless genuinely needed for an interactive island.
- **Styling:** Tailwind CSS via `@astrojs/tailwind` integration. No CSS-in-JS.
- **Content:** Astro Content Collections for `services/` (Markdown + frontmatter). Pages as `.astro` files.
- **CMS:** Decap CMS (formerly Netlify CMS), self-hosted at `/admin`. Use GitHub OAuth via Decap's built-in flow. Configure for the services collection plus editable fields on each main page (hero copy, taglines, etc.).
- **Forms:** Web3Forms. The contact form posts to their endpoint with an access key (placeholder `YOUR_WEB3FORMS_KEY` — owner will replace). Include honeypot field.
- **Hosting:** Cloudflare Pages. Build command `npm run build`, output `dist/`.
- **Repo:** Already initialized (empty). Add a `.gitignore`, commit in logical chunks.

### What NOT to add

- No analytics SDK by default. Owner can add Plausible or Cloudflare Web Analytics later.
- No cookie banner, no GDPR pop-ups, no chat widgets.
- No image optimization service beyond Astro's built-in `<Image>` component.
- No CMS preview server beyond what Decap provides natively.
- No e-commerce, no auth, no blog.
- No "News" page (the current site has one but it's empty / unused).
- No "Solutions" page separate from Services (the current Solutions page is uncustomized theme demo content).

---

## Decap CMS configuration

Set up `public/admin/index.html` and `public/admin/config.yml` for Decap CMS.

- Backend: GitHub via OAuth (assume the repo will be connected — leave OAuth client config commented with a clear TODO for the owner).
- Editable collections:
  - `services` (folder collection, one Markdown file per service)
  - `pages` (file collection: home, about, contact frontmatter only — hero copy, headlines, etc.)
  - `site` (single file: nav labels, footer copy, contact email, phone, LinkedIn URL, office locations)
- Editor mode: rich text where appropriate, plain text for short fields.
- Media folder: `public/uploads/`.
- After save, Decap commits to the repo, Cloudflare rebuilds, site updates within ~30 seconds.

---

## Inputs you'll find in this folder

- `BRIEF.md` — this file
- `reference-pages/` — Markdown files extracted from the WordPress XML export, one per page
  - `home.md` — current homepage content
  - `about.md` — current About page content (rich, useful)
  - `services.md` — current Services page (sparse — security categories listed but no descriptions)
  - `contact.md` — contact info, office locations, phone
  - `solutions.md` — **IGNORE** — this page was never customized away from theme demo content (mentions Paris, renewable energy, info@hub.com)
  - `news.md` — **IGNORE** — empty unused page
- `wordpress-export.xml` — raw WordPress export (you probably won't need this; reference-pages/ is cleaner)
- `assets/` — logo, partner logos, any hero imagery worth keeping (may or may not be present)

If `assets/` is missing or sparse, ask the owner — don't fabricate logos.

---

## How to work this project

1. **Read this brief, the reference pages (skip solutions.md and news.md), and check `assets/` first.** Do not start coding until you've reviewed all three.
2. **Propose a plan before writing code.** Outline: project structure, key components, design tokens (colors/type), content collection schema, Decap config. Wait for approval.
3. **Build in commits.** Suggested order:
   1. Astro + Tailwind scaffold, design tokens, base layout, header, footer
   2. Home page
   3. Services content collection + listing page + individual service pages (if used)
   4. About + Contact pages
   5. Decap CMS at `/admin`
   6. Web3Forms integration on contact
   7. Cloudflare Pages config, `README.md`, deployment notes
4. **After each major chunk, run `npm run build` to verify nothing's broken**, then summarize what changed and ask whether to continue.
5. **Don't gold-plate.** This is a 4-page brochure site. Resist the urge to add a design system package, a Storybook, animation libraries, or a component playground.

---

## Definition of done

- `npm run dev` starts cleanly with no warnings
- `npm run build` produces a `dist/` directory under 5MB
- All four pages render and are mobile-responsive
- Contact form submits successfully (with placeholder Web3Forms key) and shows success state
- `/admin` loads Decap CMS and lists configured collections (will need OAuth setup before content saves work — that's owner's task)
- README explains: how to run locally, how to deploy to Cloudflare Pages, how to set up Decap OAuth, how to update Web3Forms key
- Lighthouse score ≥ 95 on all four core metrics for the home page

---

## One last thing

The owner is technical-adjacent (runs a tech consultancy, can follow instructions, but doesn't write code). Write the README accordingly: clear, no assumed knowledge of npm or Astro, lots of "run this command, expect this output." Treat it like onboarding documentation, not a developer reference.
