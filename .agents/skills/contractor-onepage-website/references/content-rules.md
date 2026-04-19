# Content Rules Reference

## `src/CONTENT.json` — Field Reference

This is the single source of truth for ALL website text and client data.
The AI reads this file first and writes copy into every `[PLACEHOLDER]` field
following the word-count rules below.

---

## Client Data Fields (pre-filled by client/developer)

| Field | Type | Notes |
|-------|------|-------|
| `company_name` | string | Full legal or trade name |
| `company_phone` | string[] | **Array** — may have 1 or more numbers |
| `company_email` | string[] | **Array** — may have 1 or more emails |
| `company_address` | string | Full street address |
| `company_schedule` | string[] | e.g. `["Mon to Sun 6AM to 7PM"]` |
| `company_license` | string | License number or `"NO LICENSE"` |
| `company_license_insurance` | string | Insurance info or `"NO INSURANCE"` |
| `company_payment_method` | string | e.g. `"Cash, Check, Zelle"` |
| `company_estimate` | string | e.g. `"Free Estimates Available"` |
| `company_years_experience` | string | e.g. `"14 Years of Experience"` |
| `company_cover_area` | string | Comma-separated list of cities |
| `company_type_services` | string | `"Residential"`, `"Commercial"`, or both |
| `company_colors` | object | 4 hex values — see Colors section |
| `social_media` | object | See Social Media section |
| `services[*].name` | string | Real service name — AI writes description |

---

## AI-Written Copy Fields — Word Count Rules

These fields contain `[PLACEHOLDER]` — the AI must write them following these rules exactly:

| Field | Rule |
|-------|------|
| `phrases[]` | Each phrase: **min 6 words, max 8 words** |
| `home_content[]` | Each paragraph: **min 50 words, max 60 words** |
| `about_content[]` | Each paragraph: **min 50 words, max 60 words** |
| `services[*].description` | Each description: **min 30 words, max 40 words** |
| `company_mission` | Exactly **50 words** |
| `company_vision` | Exactly **50 words** |
| `company_why_choose_us` | Exactly **50 words** |

---

## Colors — `company_colors`

```json
"company_colors": {
  "primary": "#a80000",
  "accent":  "#1a458b",
  "light":   "#e3e1d4",
  "dark":    "#09234e"
}
```

After reading these values, the AI must write them into `src/styles/global.css`:

```css
@theme {
  --color-brand-primary: #a80000;
  --color-brand-accent:  #1a458b;
  --color-brand-light:   #e3e1d4;
  --color-brand-dark:    #09234e;
}
```

**Never hardcode hex values in component HTML.** Always use `brand-*` tokens.

---

## Social Media — Guard Pattern

Fields use `"NO X"` as placeholder when the client doesn't have that network:

```json
"social_media": {
  "facebook":  "https://facebook.com/...",
  "google":    "NO GOOGLE",
  "instagram": "NO INSTAGRAM",
  "youtube":   "NO YOUTUBE",
  "tiktok":    "NO TIKTOK"
}
```

**Always guard before rendering:**
```astro
{social_media.facebook !== 'NO FACEBOOK' && social_media.facebook && (
  <a href={social_media.facebook} target="_blank" rel="noopener noreferrer">
    <!-- icon -->
  </a>
)}
```

Apply same pattern to: `google`, `instagram`, `youtube`, `tiktok`.

---

## Services — Image Naming Convention

Each service image in `COMPANY-PHOTOS/services/` must be named in **kebab-case**
matching the service name:

| Service Name | Expected File |
|-------------|--------------|
| Residential Painting | `residential-painting.jpg` |
| Kitchen Cabinets Painting | `kitchen-cabinets-painting.jpg` |
| Handyman Services | `handyman-services.jpg` |

The `process-images.mjs` script uses the filename as the output name —
it does NOT derive the name from `CONTENT.json`. The developer must name files correctly.

---

## Section-by-Section Content Map

| Section | Fields Used |
|---------|------------|
| TopBar | `company_phone`, `company_email`, `social_media` |
| Navbar | `company_name`, logo image |
| Hero | `phrases[0]`, `home_content[0]`, `company_phone[0]`, services list (for select) |
| Welcome | `company_name`, `home_content[1]`, `home_content[2]` |
| Services | `services[*].name`, `services[*].description` |
| Gallery | gallery images only |
| About Us | `company_name`, `about_content[*]`, `company_years_experience` |
| Mission/Vision | `company_mission`, `company_vision`, `company_why_choose_us` |
| Contact Us | `company_address`, `company_phone`, `company_email` |
| Footer | `company_name`, `social_media`, logo image |
| Thank You | `company_phone`, `social_media.facebook` |

---

## SEO Fields (in `BaseLayout.astro`)

Populate from `CONTENT.json` — do not hardcode:

```astro
---
const title = `${content.company_type_services} Services in [City] | ${content.company_name}`;
const description = `${content.company_name} — ${content.company_estimate}. Serving ${content.company_cover_area}.`;
---
```

JSON-LD `LocalBusiness` schema — also populated from `CONTENT.json`:
```json
{
  "@context": "https://schema.org",
  "@type": "LocalBusiness",
  "name": "[company_name]",
  "telephone": "[company_phone[0]]",
  "address": { "streetAddress": "[company_address]" },
  "url": "[site URL]"
}
```
