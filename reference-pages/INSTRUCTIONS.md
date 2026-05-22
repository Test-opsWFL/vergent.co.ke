# Vergent Rebuild — Your Step-by-Step Guide

You'll do these in order. Each section ends with a clear "you're done" checkpoint. Estimated total active time: 4–6 hours, mostly in Step 5 (working with Claude Code).

---

## Step 1: Finish the WordPress fix (15 min — do this first)

Before anything else, get your current site back online so it's not broken in public.

1. Log into wp-admin → click **UpdraftPlus** in the sidebar
2. Scroll to **Existing Backups**
3. On the **Mar 11, 2024** backup row, click the blue **Restore** button
4. In the popup, tick **only "Plugins"** — leave everything else unchecked
5. Click **Next**, wait for it to fetch from Dropbox, then click **Restore**
6. Wait for "Restore successful!" message
7. Open vergent.co.ke in a private browser window and confirm the site renders properly

**Done when:** vergent.co.ke shows your normal homepage, not raw shortcodes.

---

## Step 2: Export your WordPress content (10 min)

1. In wp-admin, go to **Tools → Export**
2. Select **All content**
3. Click **Download Export File**
4. Save the resulting `.xml` file somewhere you can find it

**Also save the rendered pages** (these are what Claude Code will actually use):

5. Open vergent.co.ke in your browser
6. For each of the four pages (Home, About, Services, Contact):
   - Visit the page
   - File menu → **Save Page As…** → choose **"Webpage, Complete"**
   - Save with names like `home.html`, `about.html`, etc.

**Done when:** You have one `.xml` file and four `.html` files saved on your computer.

---

## Step 3: Grab your brand assets (10 min)

1. From your current site, save these images by right-clicking → Save Image As:
   - The Vergent logo (top-left of the site)
   - Each partner logo near the bottom (Centerity, Dreamvise, etc.)
   - Any hero/background image you actually like (most are stock — be selective)
2. Put them all in a folder called `assets/`. Inside, make a subfolder `partner-logos/` for the partner logos.

**Done when:** You have an `assets/` folder with the logo, partner logos, and any imagery worth keeping.

---

## Step 4: Set up the project folder and install Claude Code (20 min)

### 4a. Create the project folder

Open Terminal (press Cmd+Space, type "Terminal", hit Enter). Then:

```bash
cd ~/Documents
mkdir vergent-rebuild
cd vergent-rebuild
```

### 4b. Clone your existing GitHub repo into it

If you've already created a `vergent-site` repo on GitHub (empty is fine), clone it:

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git .
```

Replace `YOUR_USERNAME` and `YOUR_REPO_NAME` with your actual values. The trailing `.` clones into the current folder.

### 4c. Move your inputs into the folder

Move the files you saved in Steps 2 and 3 into the project folder:

- `BRIEF.md` (provided in this handoff package — see below)
- `wordpress-export.xml` (from Step 2)
- `reference-pages/` folder containing the four `.html` files (from Step 2)
- `assets/` folder (from Step 3)

The folder structure should look like:

```
vergent-rebuild/
├── BRIEF.md
├── KICKOFF_PROMPT.md
├── wordpress-export.xml
├── reference-pages/
│   ├── home.html
│   ├── about.html
│   ├── services.html
│   └── contact.html
└── assets/
    ├── vergent_logo.png
    └── partner-logos/
        └── ...
```

### 4d. Install Claude Code

In Terminal:

```bash
curl -fsSL https://claude.ai/install.sh | bash
```

When it finishes, **close Terminal completely and reopen it** (this refreshes the PATH so the `claude` command is recognized).

Then verify:

```bash
claude --version
```

You should see a version number.

### 4e. Check Node.js

Claude Code can use Node.js for running the Astro project. Check:

```bash
node --version
```

If you see `v18.x.x` or higher, you're good. If you see "command not found" or an old version, install the LTS from https://nodejs.org (download the macOS installer, double-click, follow prompts).

**Done when:** `claude --version` and `node --version` both work, and your project folder has all the inputs.

---

## Step 5: Run Claude Code and build the site

### 5a. Start a Claude Code session

```bash
cd ~/Documents/vergent-rebuild
claude
```

The first time, it'll ask you to authenticate. Sign in with your Claude account (Pro subscription or higher needed).

### 5b. Paste the kickoff prompt

Open `KICKOFF_PROMPT.md` (in this handoff package), copy everything below the `---` line, and paste it as your first message to Claude Code.

### 5c. Review the proposed plan

Claude Code will read your inputs and propose a structure. Read it carefully. If anything looks off (wrong design direction, missing requirements), say so in plain English. Examples:

- "I want the orange dropped, use a different accent color"
- "Skip the about page for now, just do home + services + contact"
- "Use a darker palette overall"

When you're happy: reply "Looks good, please proceed."

### 5d. Build, review, iterate

Claude Code will build in chunks. After each chunk it'll summarize what it did. To preview the site:

```bash
npm run dev
```

This starts a local server at http://localhost:4321 — open that URL in your browser. Refresh after each change.

Common feedback patterns:
- "The hero is too cramped — give it more vertical space"
- "Use a smaller font size for body text"
- "The services cards should stack on mobile, not stay in a grid"
- "Add a bit more spacing between sections"

When the site looks right and the contact form works (it'll need a Web3Forms key — see Step 6), you're done with the build.

**Done when:** The site looks great running locally at localhost:4321.

---

## Step 6: Get a Web3Forms key (5 min)

1. Visit https://web3forms.com
2. Enter your email (info@vergent.co.ke) → click "Create Access Key"
3. Check that email inbox for the key
4. In Claude Code, say: "Replace the Web3Forms placeholder key with this one: [paste key]"
5. Test the form locally — submit a test message and confirm it arrives at info@vergent.co.ke

**Done when:** Form submissions land in your inbox.

---

## Step 7: Commit and push to GitHub (5 min)

In Claude Code, just say:
> Commit everything with a clear message and push to GitHub.

Claude Code will run the git commands. Approve them when it asks.

**Done when:** Your GitHub repo on github.com shows the new project files.

---

## Step 8: Deploy to Cloudflare Pages (15 min)

1. Sign up / log in at https://dash.cloudflare.com
2. Left sidebar → **Workers & Pages** → **Create** → **Pages** → **Connect to Git**
3. Authorize GitHub access, select your `vergent-site` repo
4. Build settings:
   - Framework preset: **Astro**
   - Build command: `npm run build`
   - Output directory: `dist`
5. Click **Save and Deploy**

In about 90 seconds, you'll get a temporary URL like `vergent-site.pages.dev`. Open it. Verify everything works.

**Done when:** Your new site is live at the .pages.dev URL.

---

## Step 9: Set up Decap CMS OAuth (15 min)

This is the only part that requires a few extra clicks. The CMS code is already in place; it just needs an OAuth bridge to talk to GitHub.

The simplest path: use **Decap's free OAuth helper**. Claude Code's README will have detailed instructions, but the gist is:

1. Create a GitHub OAuth App at https://github.com/settings/developers
2. Set callback URL to Decap's hosted OAuth handler
3. Paste the client ID into `public/admin/config.yml`
4. Test login at `vergent-site.pages.dev/admin`

If you get stuck, paste the error into Claude Code and it'll walk you through.

**Done when:** You can log into `/admin`, see your services collection, edit a service, click save, and watch the change appear on the live site within 30 seconds.

---

## Step 10: Switch DNS (1 hour, when you're ready)

Don't do this until everything else works on the .pages.dev URL.

1. In Cloudflare Pages, go to your project → **Custom domains** → **Set up a custom domain** → enter `vergent.co.ke`
2. Cloudflare will give you DNS records to add
3. Log into your domain registrar (wherever you bought vergent.co.ke)
4. Update DNS records as Cloudflare instructs
5. Wait 5–60 minutes for propagation
6. Visit vergent.co.ke — you should now see the new site

**Done when:** vergent.co.ke serves your new Astro site.

---

## Step 11: Decommission WordPress (after 30 days)

Wait at least a month. Then:

1. Final UpdraftPlus backup, downloaded to your computer for archive
2. Cancel cPanel hosting subscription
3. Delete the WordPress files (or let them stay until your hosting expires)

**Done when:** You're paying $0/month for hosting (just domain renewal).

---

## If anything goes wrong

- **WordPress restore fails:** The most common issue is Dropbox auth expired. UpdraftPlus → Settings → click "Reset" on Dropbox, re-authenticate, retry restore.
- **Claude Code throws errors:** Paste the full error into the Claude Code chat. It will diagnose and fix.
- **Site builds locally but not on Cloudflare:** Usually a Node version mismatch. Add `NODE_VERSION=20` to Cloudflare Pages environment variables.
- **Decap CMS won't authenticate:** OAuth callback URL must match exactly. Double-check both ends.
- **Stuck:** Come back to me with the specific error. Don't suffer alone.

---

## Files in this handoff package

- `BRIEF.md` — drop into the project folder before running Claude Code
- `KICKOFF_PROMPT.md` — copy-paste source for your first message to Claude Code
- `INSTRUCTIONS.md` — this file (your runbook)

Good luck. The hardest step is the first one (UpdraftPlus restore). Everything after that is downhill.
