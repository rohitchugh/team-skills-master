# Pillar 2 — Website & Landing-Page Analysis

Inboxing gets the click; the landing page turns the click into revenue. A team member must be able to audit our own pages and tear down a competitor's. This is the "detailed analysis of websites" pillar.

The model: **a page either earns the conversion or leaks it.** Every audit finds the leaks.

```
Gets there fast  →  Trusted & compliant  →  Clear single action  →  Works on mobile  →  Tracked  →  Converts
   (speed)            (compliance/trust)      (conversion design)      (mobile)        (analytics)
```

---

## 1. Speed — does it load before they bounce

Slow pages bleed clicks (paid traffic especially). Targets:

| Metric | Good | Tool |
|--------|------|------|
| PageSpeed score (mobile) | > 85 | Google PageSpeed Insights |
| Largest Contentful Paint (LCP) | < 2.5s | PageSpeed / Lighthouse |
| Cumulative Layout Shift (CLS) | < 0.1 | PageSpeed |
| Interaction to Next Paint (INP) | < 200ms | PageSpeed |

Common fixes: compress/lazy-load images, defer non-critical JS, minify CSS/JS, use a CDN, cut redirect chains. For implementation hand off to `fullstack-developer`.

---

## 2. Trust & compliance — will they (and the network) accept it

For finance/lending lead-gen this is non-negotiable; missing disclosures get the page rejected by networks and create legal risk.

Checklist (always present on a live lending page):
- Privacy Policy + Terms pages, linked in footer
- Required lending disclosures (APR ranges, "not a lender", representative example, state restrictions)
- TCPA consent language on the form (express written consent, clear checkbox)
- Physical company info / contact
- SSL active (https, no mixed-content warnings)
- No deceptive claims ("guaranteed approval", fake countdowns, fake testimonials)

Run anything customer-facing through `compliance-legal-shield` before it goes live.

---

## 3. Conversion design — one clear action

A landing page has exactly one job. Score it:
- **Above the fold:** is the offer + form/CTA visible without scrolling?
- **One primary action:** one CTA, repeated; no competing links/nav that leak traffic away.
- **Message match:** does the headline match the ad/email that sent them here? Mismatch = bounce.
- **Friction:** form length — only ask what the network needs. Each extra field drops conversion.
- **Trust elements:** security badges, "your info is secure", recognizable logos, real social proof.
- **Value clarity:** what they get and what to do, in <5 seconds of reading.

For redesigns and component-level work, invoke `digital-marketing-pro` (copy/CRO) and `ui-ux-pro-max` (design system).

---

## 4. Mobile — most traffic is mobile

- Test on a real narrow viewport (~380px), not just a desktop resize.
- Form fields and CTA reachable with a thumb; tap targets large enough.
- For our prequal pages: on mobile the **form card comes first** (reorder, do not hide) — fields in order amount → first → last → email → purpose. (Team standing convention.)
- No horizontal scroll; text legible without zoom; dark-mode renders correctly.

---

## 5. Tracking — can we measure it

If it is not tracked, it did not happen.
- GA4 + GTM installed and firing (verify in real-time / DebugView).
- Conversion / form-submit event fires on success.
- Network postback / pixel fires and is received (submit a test lead end-to-end and confirm).
- UTM parameters on inbound links so source/campaign is attributable.

---

## 6. Competitor teardown — learn from who's winning

How to analyze a competitor's site systematically:

```
1. CAPTURE   — pull the page (invoke `browse` to render it, or `scrape` to extract content/structure)
2. OFFER     — what's the hook, the headline, the promise? how do they frame the offer?
3. FUNNEL    — how many steps form → submit → thank-you? what network/redirect do they use?
4. PROOF     — what trust/social proof do they lean on?
5. SPEED     — run their URL through PageSpeed; are they faster than us?
6. COMPLIANCE— what disclosures do they show (or skip)?
7. TRAFFIC   — guess the channel (SEO/ads/email) from copy + structure
8. STEAL     — list 3 things they do better that we can test on our pages
```

Use `browse` for a live render/QA, `scrape` to pull structured data, and `digital-marketing-pro` for the strategic read.

---

## The site-audit deliverable

Every audit produces a scored report: each of the 5 dimensions (speed, compliance, conversion, mobile, tracking) gets a 🟢/🟡/🔴 and a prioritized fix list. Use [templates/site-audit.md](../templates/site-audit.md). Hand fixes to `fullstack-developer`; verify the live result with `browse` / preview tools.

---

## Tools cheat sheet

| Job | Tool |
|-----|------|
| Page speed / Core Web Vitals | Google PageSpeed Insights / Lighthouse |
| Render & QA a live page | invoke `browse` |
| Extract content/structure | invoke `scrape` |
| Copy / CRO / strategy | invoke `digital-marketing-pro` |
| Design system / UI quality | invoke `ui-ux-pro-max` |
| Compliance check | invoke `compliance-legal-shield` |
| Implement fixes | invoke `fullstack-developer` |
