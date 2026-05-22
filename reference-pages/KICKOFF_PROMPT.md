# Kickoff prompt for Claude Code

Copy everything below the line and paste it as your first message to Claude Code after running `claude` in the project folder.

---

I'm rebuilding the website for Vergent Technology Solutions (vergent.co.ke). The current site is a brittle WordPress + WPBakery setup that I'm replacing with a modern static site.

Before you write any code, please:

1. Read `BRIEF.md` in full — it contains the complete project requirements, tech stack, design direction, and definition of done.
2. Read the HTML files in `reference-pages/` to understand current site content (ignore the design — that's being replaced).
3. List the files in `assets/` to see what brand assets I have.
4. Skim `wordpress-export.xml` only if `reference-pages/` is missing meaningful content — the export is mostly shortcode soup and will not be useful for layout.

Once you've done that, propose a plan in this format:

- **Project structure**: directory layout and key files
- **Design tokens**: proposed color palette, typography pairing, spacing scale, with brief rationale
- **Component inventory**: list of components you'll build and which pages use them
- **Content collection schema**: Astro Content Collections setup, especially for services
- **Decap CMS collections**: which fields will be editable and where
- **Build order**: suggested commit sequence

Wait for me to approve or refine before scaffolding the project.

A few preferences to factor into the plan:

- Surprise me on the design — total redesign, not a refresh of the current look. The brief gives aesthetic targets; lean into them.
- Keep dependencies minimal. Astro + Tailwind + Decap CMS + Web3Forms is the whole stack. Don't add anything else without flagging why.
- I will not be deploying tonight. You can write the Cloudflare Pages config and README, but I'll handle DNS cutover separately when the new site is ready.

Go ahead and start with reading everything.
