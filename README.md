# vergent.co.ke

The Vergent Technology Solutions website. A small, fast static site built with Astro and Tailwind, deployed to Cloudflare Pages, content-edited through Decap CMS.

This README is written for the site owner. You don't need prior experience with Node, Astro, or any of these tools — just follow the steps in order.

---

## What this is

- **Stack:** Astro + Tailwind CSS, Decap CMS at `/admin` for content editing, Web3Forms for the contact form, hosted on Cloudflare Pages.
- **Pages:** Home, About, Services, Contact. Four pages, plus the editor at `/admin`.
- **No analytics**, no cookie banner, no chat widget. Add later if you need them.

---

## Run it locally

You need Node.js 20 or higher. Check with `node --version` in Terminal — if you see `v20.x.x` or higher you're set. Otherwise install the LTS from https://nodejs.org.

```bash
# from the project folder
npm install        # one-time, downloads dependencies (~1 minute)
npm run dev        # starts the local server
```

You'll see something like:

```
  astro  v4.x.x ready in 800 ms
  Local    http://localhost:4321/
```

Open http://localhost:4321 in your browser. The site updates as you save files.

To build the production version (what gets deployed):

```bash
npm run build      # output goes to dist/
npm run preview    # serve the built site locally to double-check
```

---

## Deploy to Cloudflare Pages

The repo is set up to deploy on every push to `main`. One-time setup:

1. Sign in at https://dash.cloudflare.com.
2. **Workers & Pages → Create → Pages → Connect to Git.**
3. Authorize GitHub and select `Test-opsWFL/vergent.co.ke`.
4. Build settings:
   - **Framework preset:** Astro
   - **Build command:** `npm run build`
   - **Build output directory:** `dist`
   - **Root directory:** *(leave blank — repo root)*
5. **Environment variables** (Settings → Environment variables, "Production"):
   - `NODE_VERSION` = `20`
6. **Save and Deploy.** The first build takes ~90 seconds.

You'll get a URL like `vergent-co-ke.pages.dev`. Verify everything works before pointing your real domain.

### Custom domain (vergent.co.ke)

Don't do this until the `.pages.dev` URL is working.

1. In Cloudflare Pages → your project → **Custom domains → Set up a custom domain → vergent.co.ke**.
2. Cloudflare gives you DNS records. Add them at your domain registrar.
3. Wait 5–60 minutes for propagation.
4. Visit vergent.co.ke. Done.

---

## Update the contact form

The form posts to Web3Forms. The placeholder key needs replacing before submissions reach you.

1. Go to https://web3forms.com → enter `info@vergent.co.ke` → **Create Access Key**.
2. Check that inbox for the key.
3. Open `src/components/ContactForm.astro` in any text editor.
4. Find the line `const WEB3FORMS_KEY = 'YOUR_WEB3FORMS_KEY';` (near the top).
5. Replace `YOUR_WEB3FORMS_KEY` with the key you got. Keep the quotes.
6. Save, commit, push. Cloudflare rebuilds and the form is live within 90 seconds.

To test: visit `/contact`, submit a message, check your inbox.

---

## Edit content (Decap CMS)

Once Cloudflare Pages is live and the OAuth bridge below is configured, visit `https://vergent.co.ke/admin` (or your `.pages.dev` URL + `/admin`) to edit content visually. Changes commit to the GitHub repo and trigger a rebuild — the live site updates within ~30 seconds.

### Decap CMS — OAuth setup (one-time, ~10 minutes)

Decap needs a way to authenticate against GitHub. The simplest free option is a tiny Cloudflare Worker bridge:

1. **Create a GitHub OAuth App.** Go to https://github.com/settings/developers → **New OAuth App**.
   - Application name: `Vergent CMS`
   - Homepage URL: `https://vergent.co.ke`
   - Authorization callback URL: `https://decap-oauth.<your-workers-subdomain>.workers.dev/callback` (replace once you've created the worker in step 2)
   - Click **Register application**. You'll get a **Client ID** and **Client Secret** — keep them open in a tab.

2. **Deploy the Decap OAuth Worker.** Use this template: https://github.com/sterlingwes/decap-proxy. Follow its README. Two environment variables for the worker:
   - `OAUTH_CLIENT_ID` = the Client ID from step 1
   - `OAUTH_CLIENT_SECRET` = the Client Secret from step 1

3. **Update the GitHub OAuth App's callback URL** to match the deployed worker's `/callback` URL.

4. **Wire the worker URL into Decap.** Open `public/admin/config.yml`, find the `backend:` block, uncomment and set:
   ```yaml
   backend:
     name: github
     repo: Test-opsWFL/vergent.co.ke
     branch: main
     base_url: https://decap-oauth.<your-workers-subdomain>.workers.dev
   ```

5. **Test:** visit `/admin`, click **Login with GitHub**, authorize. You should land in the editor with all collections visible.

### What's editable

- **Site settings** — brand, nav, contact details, offices, partners, footer
- **Pages** — Home / About / Contact hero copy, headlines, paragraphs, bullets, CTAs
- **Services** — folder collection; one Markdown file per service. Add, edit, or delete services freely.

Everything else (page layouts, components, design) lives in code. Ask a developer for changes there.

---

## Project layout

```
vergent.co.ke/
├── astro.config.mjs        # Astro config (Tailwind, sitemap)
├── tailwind.config.mjs     # design tokens
├── package.json            # dependencies
├── _headers                # Cloudflare Pages cache + security headers
├── public/
│   ├── admin/              # Decap CMS shell + config
│   ├── uploads/            # CMS-uploaded media
│   ├── favicon.svg
│   └── robots.txt
└── src/
    ├── content/services/   # one Markdown file per service (CMS-editable)
    ├── data/               # site-wide settings + per-page JSON (CMS-editable)
    ├── layouts/Base.astro  # html shell, header, footer, dark-mode pre-paint
    ├── components/         # reusable bits
    ├── pages/              # one .astro file per route
    └── styles/global.css   # design tokens + Tailwind base
```

---

## When something goes wrong

- **`npm install` fails** with `EACCES` or permissions errors → run `sudo chown -R $(whoami) ~/.npm` once and retry.
- **Cloudflare build fails** with "node version" errors → confirm `NODE_VERSION=20` is set in Pages env vars.
- **Form submissions never arrive** → confirm the Web3Forms key is set (not the placeholder) and check spam.
- **`/admin` loads but login fails** → OAuth bridge isn't reachable or callback URL doesn't match. Re-check steps 1–4 in **Decap CMS — OAuth setup**.
- **Site builds locally but not on Cloudflare** → almost always a missing dependency in `package.json` or a wrong Node version. Compare local `node --version` to the Pages env var.

For anything else, paste the error into the Claude Code session and let it diagnose.

---

## Dependencies (and why)

- `astro` — site framework
- `@astrojs/tailwind` — first-party Tailwind integration
- `@astrojs/sitemap` — auto-generates `/sitemap-index.xml`
- `tailwindcss` — styling

Decap CMS loads from a CDN at `/admin/index.html` — no npm dependency. Web3Forms is a remote endpoint — no npm dependency. By design, this site has four direct dependencies. If you find yourself adding more, ask why.
