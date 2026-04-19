---
name: contractor-onepage-website
description: >
  Build a one-page lead generation website for contractors using Astro v6 + Tailwind v4.
  Trigger: When starting or continuing development of a contractor one-page website project.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
---

## When to Use

- Starting a new contractor one-page website project
- Adding or modifying any Astro component in the site
- Configuring Tailwind, Astro, or Vite for this project
- Processing client photos or generating the favicon
- Setting up Netlify Forms and the thank-you page
- Filling or validating `src/CONTENT.json`

## Pre-Development Checklist — HARD GATES

Before writing any code, verify ALL of these in order:

### GATE 1 — `src/CONTENT.json` is complete
All required fields must have real client values (no `[PLACEHOLDER]`):

| Field | Required |
|-------|----------|
| `company_name` | Real company name |
| `company_phone` | Array — at least one real number |
| `company_email` | Array — at least one real email |
| `company_address` | Real street address |
| `company_colors` | 4 hex values: primary, accent, light, dark |
| `services[*].name` | All service names must be real |
| `social_media` | At least one real URL (rest can be `"NO X"`) |

If incomplete → output which fields are missing and STOP.

Once complete → copy `company_colors` values into `src/styles/global.css` under `@theme {}`.

### GATE 2 — `COMPANY-PHOTOS/` subfolders are populated
Each subfolder must have at least one image. Run:
```bash
node scripts/process-images.mjs
node scripts/generate-favicon.mjs
```

### GATE 3 — Only then begin development

## Critical Patterns

### Content — always from `src/content.ts`
```ts
// Every component imports like this — NEVER import CONTENT.json directly
import content from '../../content.ts';
const { company_name, company_phone, social_media } = content;
```

### Phone — it's an ARRAY, loop it
```astro
{content.company_phone.map((phone) => (
  <a href={`tel:${phone.replace(/[^0-9+]/g, '')}`}>{phone}</a>
))}
```

### Social media — guard against "NO X" values
```astro
{social_media.facebook !== 'NO FACEBOOK' && social_media.facebook && (
  <a href={social_media.facebook} target="_blank" rel="noopener noreferrer">...</a>
)}
```

### Services grid — handle orphan last card
If `services.length % 3 !== 0`, the last card renders as full-width horizontal layout:
```astro
{services.map((service, index) => {
  const isOrphan = index === services.length - 1 && services.length % 3 !== 0;
  return isOrphan ? <HorizontalCard /> : <VerticalCard />;
})}
```

### Netlify Forms — both forms need these three attributes
```html
<form name="lead-form" method="POST" data-netlify="true" action="/thank-you">
  <input type="hidden" name="form-name" value="lead-form" />
</form>
```

### Favicon — use `fit: 'contain'` NOT `fit: 'cover'`
Portrait logos get cropped with `cover`. Always use `contain` + transparent background.

## Page Sections (in order)

| # | Component | ID | Background |
|---|-----------|-----|-----------|
| 1 | `TopBar.astro` | — | `bg-brand-dark` |
| 2 | `Navbar.astro` | — | `bg-white sticky top-0 z-50` |
| 3 | `Hero.astro` | `#hero` | Full-width image + dark overlay |
| 4 | `Welcome.astro` | `#welcome` | `bg-white` |
| 5 | `Services.astro` | `#services` | `bg-brand-light` |
| 6 | `Gallery.astro` | `#gallery` | `bg-white` |
| 7 | `AboutUs.astro` | `#about` | `bg-brand-light` |
| 8 | `MissionVisionValues.astro` | `#values` | `bg-brand-dark text-white` |
| 9 | `ContactUs.astro` | `#contact` | `bg-white` |
| 10 | `Footer.astro` | — | `bg-brand-dark` |
| 11 | `thank-you.astro` | (page) | `bg-brand-light` |

## Commands

```bash
# ── New project setup (run once) ──────────────────────────────
bash scripts/setup.sh

# ── Individual steps (if needed separately) ───────────────────
npm install                       # Install all dependencies
node scripts/process-images.mjs   # Crop/resize COMPANY-PHOTOS → src/assets/images/
node scripts/generate-favicon.mjs # Logo → public/favicon.png (50x50, fit:contain)
npm run dev                       # Dev server at localhost:4321

# ── Before every push to main ─────────────────────────────────
bash scripts/predeploy.sh         # Build check + preview server
```

**Deploy workflow (manual):**
1. `bash scripts/predeploy.sh` — verify build passes, review visually
2. `git push origin main`
3. Go to Netlify → New project → select repo → wait for deploy URL
4. Send URL to client for approval
5. Client approves → buy domain → link to Netlify project

## Companion Skills — When to Use Each

This project has three additional skills installed in `.agents/skills/`. Use them at these specific moments:

| Skill | When to load |
|-------|-------------|
| `seo-content-writer` | When writing copy for `CONTENT.json` — phrases, home_content, about_content, service descriptions, mission, vision, why_choose_us |
| `seo` | When building `BaseLayout.astro` — title tag, meta description, Open Graph tags, JSON-LD LocalBusiness schema, canonical URL, sitemap |
| `astro` | When you need to check Astro API details — `<Image />`, content collections, SSR, routing |

### Workflow with companion skills

```
STEP 1 — Fill CONTENT.json copy
  → Load: seo-content-writer
  → Use for: all [PLACEHOLDER] text fields
  → Follow word-count rules in references/content-rules.md

STEP 2 — Process images + build components
  → Use: this skill (contractor-onepage-website)
  → Load astro skill if you need API reference

STEP 3 — Build BaseLayout.astro head section
  → Load: seo
  → Use for: <title>, <meta>, Open Graph, JSON-LD schema, canonical
```

## Resources

- **Setup & Architecture**: See [references/setup.md](references/setup.md)
- **Content Rules**: See [references/content-rules.md](references/content-rules.md)
- **CONTENT.json template**: See [templates/CONTENT.json](templates/CONTENT.json)
- **global.css template**: See [templates/global.css](templates/global.css)
