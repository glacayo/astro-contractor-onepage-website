# AGENTS.md — Contractor One Page Website Template

## What This Is

A **reusable one-page contractor website template** built with Astro v6 + Tailwind CSS v4.
Battle-tested on a real project (Wali Painting & Handyman, Delaware).

---

## Start Here

Before writing any code, load the project skill:

```
contractor-onepage-website
```

Located at: `.agents/skills/contractor-onepage-website/SKILL.md`

The skill contains:
- Pre-development hard gates (CONTENT.json + images)
- All critical architecture rules (Vite 7, Tailwind v4, Netlify Forms)
- Full section specs (TopBar → Footer + Thank You page)
- Design system tokens, accessibility rules, SEO, naming conventions

**Do not skip the skill. It encodes everything learned the hard way.**

---

## Quick Reference

| Item | Location |
|------|----------|
| Content data | `src/CONTENT.json` |
| Content module | `src/content.ts` (import this, not the JSON) |
| Global styles + tokens | `src/styles/global.css` |
| Raw client photos | `COMPANY-PHOTOS/` (DO NOT import directly) |
| Processed images | `src/assets/images/` |
| Image crop script | `node scripts/process-images.mjs` |
| Favicon script | `node scripts/generate-favicon.mjs` |

---

## Dev Commands

```bash
npm install        # Install dependencies (includes sharp + glob)
npm run dev        # Dev server → localhost:4321
npm run build      # Production build
npm run preview    # Preview production build
```
