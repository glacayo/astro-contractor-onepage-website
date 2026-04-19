```
                                    .
                               .    |    .
                              /|    |    |\
                             / |    |    | \
                            /  '----'----'  \
                           /   |        |   \
                          / .--'--------'--, \
                 _       /.-'   __        '`-.\
                ( \     //    .~  ~.   ___    \\
                 \ \   //   ./      \ /   \    \\
                  \ \ //   /   /~~\  V /~\ \    \\
                   \ V/   / \ / '' \ / '' \/     V
                    V    |   V  __  V  __  |
                         |    \/  \/  \/   |
                          \     \    /     /
                     _,--. '.    '  '    .' .--.
                   .'     \  '.        .'  /     '.
                  /   .-.  \   '------'   /  .-.  \
                 |  ./   \  \            /  /   \  |
                  \  \   /  /\          /\  \   /  /
                   '._'--'_.'  '------'  '._'--'_.'
```

# astro-contractor-onepage-website

> Reusable one-page lead generation website template for contractors.  
> Built with **Astro v6** + **Tailwind CSS v4**. Battle-tested on real client projects.

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
![Astro](https://img.shields.io/badge/Astro-v6-FF5D01?logo=astro&logoColor=white)
![Tailwind CSS](https://img.shields.io/badge/Tailwind-v4-06B6D4?logo=tailwindcss&logoColor=white)
![Netlify](https://img.shields.io/badge/Deploy-Netlify-00C7B7?logo=netlify&logoColor=white)

---

## What Is This

A production-ready template for building contractor lead generation websites — painters, handymen, plumbers, landscapers, you name it. Clone it, fill in the client data, hand it off to an AI agent, and get a fully built site ready to deploy.

Every pattern in this template was validated on a real project (**Wali Painting & Handyman**, Delaware). Nothing here is theory.

---

## Features

- **One-page scrollable layout** with anchor navigation
- **Lead capture forms** (Hero + Contact) wired to Netlify Forms
- **Google Maps embed** in the Contact section
- **Gallery** with Load More (vanilla JS, no framework)
- **Thank You page** — Netlify redirects here after form submission
- **Image pipeline** — crop & resize raw client photos to correct aspect ratios
- **Favicon generator** — resizes company logo → `public/favicon.png`
- **SEO ready** — JSON-LD LocalBusiness schema, Open Graph, canonical URLs
- **4 AI agent skills** pre-installed so the agent knows exactly what to do

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Astro v6 |
| Styling | Tailwind CSS v4 — CSS-first config, no `tailwind.config.mjs` |
| Vite Plugin | `@tailwindcss/vite` (NOT `@astrojs/tailwind`) |
| Images | Astro `<Image />` from `astro:assets` |
| Image Processing | `sharp` + `glob` |
| Forms | Netlify Forms |
| Maps | Google Maps Embed API |
| Fonts | Google Fonts — Montserrat + Inter |
| Deploy | Netlify |

---

## Project Structure

```
/
├── COMPANY-PHOTOS/               # ⚠️ Drop raw client photos here
│   ├── logo/                     # Company logo (PNG preferred)
│   ├── hero/                     # 1-2 landscape photos
│   ├── welcome/                  # 1 team or job-site photo
│   ├── about/                    # 1 founder or project photo
│   ├── services/                 # 1 photo per service (kebab-case filename)
│   └── gallery/                  # All remaining project photos
├── scripts/
│   ├── setup.sh                  # One-command project bootstrap
│   ├── predeploy.sh              # Build check before every push
│   ├── process-images.mjs        # Crop/resize COMPANY-PHOTOS → src/assets/images/
│   └── generate-favicon.mjs      # Logo → public/favicon.png
├── src/
│   ├── assets/images/            # ✅ Processed images (Astro optimizes these)
│   ├── components/
│   │   ├── layout/               # TopBar, Navbar, Footer
│   │   ├── sections/             # Hero, Welcome, Services, Gallery, AboutUs...
│   │   └── ui/                   # ServiceCard, GalleryGrid, LeadForm
│   ├── layouts/
│   │   └── BaseLayout.astro
│   ├── pages/
│   │   ├── index.astro
│   │   └── thank-you.astro
│   ├── styles/
│   │   └── global.css            # @import "tailwindcss" + @theme tokens
│   ├── CONTENT.json              # ✅ Single source of truth for all content
│   └── content.ts                # Re-exports CONTENT.json for components
├── .agents/skills/               # AI agent skills (see below)
├── AGENTS.md                     # Entry point for AI agents
├── astro.config.mjs
└── package.json
```

---

## Page Sections

| # | Section | Purpose |
|---|---------|---------|
| 1 | TopBar | Phone + email + social media links |
| 2 | Navbar | Logo + anchor navigation, sticky on scroll |
| 3 | Hero | Full-screen background image + lead capture form |
| 4 | Welcome | Company introduction + trust signals |
| 5 | Services | 3-column service card grid |
| 6 | Gallery | Project photos with Load More |
| 7 | About Us | Company story + key stats |
| 8 | Mission / Vision / Why Us | Values in 3 columns |
| 9 | Contact | Form + Google Maps embed |
| 10 | Footer | Logo + copyright + social icons |
| 11 | Thank You | Post-form-submission confirmation page |

---

## AI Agent Skills

Four skills are pre-installed in `.agents/skills/` — the agent uses them automatically at the right moment:

| Skill | When it's used |
|-------|---------------|
| `contractor-onepage-website` | Core skill — architecture, sections, critical patterns |
| `astro` | Astro API reference — `<Image />`, routing, components |
| `seo-content-writer` | Writing all copy in `CONTENT.json` (phrases, paragraphs, descriptions) |
| `seo` | Building `BaseLayout.astro` — meta tags, JSON-LD schema, canonical URLs |

---

## Getting Started

### 1. Clone the template

```bash
git clone https://github.com/glacayo/astro-contractor-onepage-website.git my-client-name
cd my-client-name
```

### 2. Fill in client data

Open `src/CONTENT.json` and fill every field under `__CLIENT_DATA__`:

```json
"company_name": "Acme Painting LLC",
"company_phone": ["+1 (302) 555-0123"],
"company_email": ["info@acmepainting.com"],
"company_address": "123 Main St, Wilmington, DE 19801",
"company_years_experience": "12",
"services": [
  { "name": "Interior Painting", "description": "[PLACEHOLDER — agent writes this]" },
  ...
]
```

Leave all `[PLACEHOLDER]` fields under `__AI_COPY__` untouched — the agent writes those.

### 3. Add client photos

Drop photos into the correct `COMPANY-PHOTOS/` subfolders:

| Subfolder | Content | Aspect Ratio |
|-----------|---------|-------------|
| `logo/` | Company logo | as-is |
| `hero/` | 1-2 landscape photos | 16:9 |
| `welcome/` | 1 team or job-site photo | 4:3 |
| `about/` | 1 founder or project photo | 4:3 |
| `services/` | 1 photo per service (kebab-case filename) | 4:3 |
| `gallery/` | All remaining project photos | 1:1 |

### 4. Hand off to the agent

```
"Read the AGENTS.md and start the project"
```

The agent will:
1. Validate `CONTENT.json` is complete
2. Run the image processing scripts
3. Write all copy using the `seo-content-writer` skill
4. Build all components following the `contractor-onepage-website` skill
5. Wire up SEO metadata using the `seo` skill

### 5. Deploy to Netlify

```bash
bash scripts/predeploy.sh   # verify the build passes
git push origin main        # Netlify auto-deploys
```

---

## CONTENT.json Structure

The file has two clearly separated sections:

**`__CLIENT_DATA__`** — you fill before starting:
- Company name, phone, email, address
- Years of experience, service areas, payment methods
- Brand colors, social media URLs
- Service names

**`__AI_COPY__`** — the agent writes based on client data:
- Hero phrases and paragraphs
- Welcome and About Us content
- Service descriptions
- Mission, Vision, Why Choose Us

---

## Critical Architecture Rules

Things that will break the build silently if ignored:

1. **`CONTENT.json` must live inside `src/`** — Vite 7 blocks imports from outside `src/`
2. **Always import from `content.ts`**, never directly from `CONTENT.json`
3. **No `tailwind.config.mjs`** — Tailwind v4 uses CSS `@theme {}` tokens
4. **Use `@tailwindcss/vite`**, not the deprecated `@astrojs/tailwind`
5. **`company_phone` is an array** — always loop it with `.map()`
6. **Social media guards** — check for `"NO FACEBOOK"` before rendering icons
7. **Netlify Forms need `action="/thank-you"`** — without it users see a generic Netlify page
8. **Favicon: use `fit: 'contain'`** — `cover` crops portrait logos

---

## Commands

```bash
# First time setup
bash scripts/setup.sh

# Individual steps
npm install                        # Install dependencies
node scripts/process-images.mjs   # Process client photos
node scripts/generate-favicon.mjs # Generate favicon from logo
npm run dev                        # Dev server → localhost:4321

# Before every deploy
bash scripts/predeploy.sh          # Build check + preview
```

---

## License

This project is licensed under the **GNU General Public License v3.0**.  
See the [LICENSE](LICENSE) file for details.

You are free to use, modify, and distribute this template. Any derivative work must also be released under the same GPL v3 license.

---

<p align="center">
  Built with ☕ and stubbornness by <a href="https://github.com/glacayo">glacayo</a>
</p>
