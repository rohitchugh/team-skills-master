# The Team Playbook — Content Inboxing, Sites, Sheets & Growth

*The human handbook. Read this first, cover to cover, before you touch a live campaign. The `team-inboxing-mastery` skill is the same knowledge as your daily working map; this is the version you read to actually understand it.*

---

## Welcome — what this team actually does

We send email that people want, get it into the **inbox** (not spam), send them to a **landing page** that converts, and we **measure every step** so we keep getting better. Four skills make that happen, and over time you will learn all four:

1. **Content inboxing** — the craft of landing in the inbox.
2. **Website & landing analysis** — making the page earn the click.
3. **Excel / Google Sheets analytics** — proving what worked.
4. **How we work as a team** — so you grow into doing more.

The most important idea on this team: **the chain is only as strong as its weakest link.** A brilliant subject line is worthless if you land in spam. Perfect inbox placement is worthless if the page does not convert. And none of it compounds if you cannot read the numbers. So we never obsess over one link while another is broken — we work the whole chain.

---

## Part 1 — Content Inboxing (the heart of the job)

"Inboxing" means getting your email into the **Primary inbox**. Mailbox providers (Gmail, Yahoo, Outlook) decide that with a chain of checks. Learn the chain in order:

**Who are you?** (Authentication) — Providers will not trust mail they cannot verify. Three DNS records prove it: **SPF** (this server may send for us), **DKIM** (the message was not tampered with), **DMARC** (what to do if the first two fail). All three must say "pass." If you remember nothing else: open the raw email headers and confirm `spf=pass`, `dkim=pass`, `dmarc=pass`. Since 2024, Gmail and Yahoo *require* all three plus one-click unsubscribe for bulk senders, and they cut you off if spam complaints get too high.

**What's your track record?** (Reputation) — Providers score your sending IP and domain. A brand-new sender has no trust, so we **warm up**: start at ~50 emails/day to your most engaged people and ramp slowly over a few weeks, only increasing when complaints and bounces stay low. We watch reputation in **Google Postmaster Tools** and check we are not on **blocklists** (Spamhaus etc.) with MXToolbox.

**Who are you sending to?** (List quality) — This is the biggest lever. Always remove unsubscribes, bounces, and complainers before every send. Mail engaged people; sunset people who have not opened in 90+ days. A small engaged list beats a big dead one every time, because providers watch whether recipients actually engage.

**What's inside?** (Content) — Keep a healthy text-to-image balance (never all-image), a working unsubscribe link and a physical address (the law requires both), and avoid spam triggers (ALL CAPS, !!!, $$$, "FREE", "guaranteed", link shorteners). Before every campaign we run it through **Mail-Tester.com** (must score above 9/10) and a **seed list** to confirm it lands in the inbox.

**Do they care?** (Engagement) — Opens, clicks, and replies build reputation; deletes and spam-marks destroy it. We send to engaged people first and at good times (Tue–Thu, mid-morning or early evening), and we value relevance over frequency.

**When placement drops,** we do not guess. We walk the chain in order: auth → blocklist → reputation → list → content → volume → complaints. The first broken link is almost always the cause. (The deliverability-audit template walks you through it.)

---

## Part 2 — Website & Landing Analysis

The click is precious; the page either earns the conversion or leaks it. You will learn to audit five things:

- **Speed** — slow pages lose people. Mobile PageSpeed above 85, fast load.
- **Trust & compliance** — privacy/terms, lending disclosures, TCPA consent, SSL, no fake claims. For finance pages this is mandatory; networks reject pages that miss it.
- **Conversion design** — one clear offer, one action, message that matches the email that sent them, minimal form friction, visible trust signals.
- **Mobile** — most traffic is mobile; test on a real narrow screen. On our prequal pages the form card comes first on mobile.
- **Tracking** — GA4/GTM firing, conversion events firing, the network pixel actually received. If it is not tracked, it did not happen.

You will also learn the **competitor teardown**: capture their page, study the offer, the funnel steps, the proof they use, their speed, their compliance, and steal the three things they do better than us to test on our pages.

---

## Part 3 — Excel / Google Sheets Analytics

Activity is noise until you can read it. Learn these numbers cold: **Open rate, CTR, click-to-open, delivery, bounce, complaint, unsub, RPE (revenue per email), and EPC (earnings per click).** EPC and RPE are the money numbers leadership cares about; everything else explains *why* they moved.

We keep four core sheets: the **campaign performance tracker** (one row per send, rates are formulas not typed), the **domain/network rotation model**, the **list-health sheet**, and the **A/B test log**.

The single most useful habit is the **diagnostic ladder**: when revenue drops, walk *down* the funnel to find where. Revenue down → is EPC down (offer/network) or clicks down (content) or opens down (placement/subject) or delivery down (deliverability broke)? "Revenue is down" is not actionable. "Opens dropped 40% on Gmail only" points straight at the cause.

And on A/B tests: change one thing at a time, and do not be fooled by small samples — 19% vs 21% on 500 emails each is noise, not a winner. When unsure, we check statistical significance before declaring a winner.

Every report answers three questions in order: **what happened, why, and what now.** Never hand over a table with no conclusion.

---

## Part 4 — How we work, and how you grow

**Our model: everyone learns all four pillars, and at any time you own one lane** (Deliverability, Site & Landing, Analytics, or Ops-coordination), rotating lanes each quarter. Why? At our size, specialists create bottlenecks — if the one deliverability person is out, sends stall. Generalists-with-a-lane keeps us resilient and gives you a real path to grow.

**The ladder you climb:**
- **L1 Operator** — you follow the SOPs: pull a segment, apply suppressions, run a test send, fill the tracker.
- **L2 Analyst** — you own a lane: read the sheets, run audits, spot and localize a drop.
- **L3 Lead** — you diagnose root cause, design A/B tests, approve sends, rotate networks, and you have worked all four lanes.
- **L4 Owner** — you set strategy, own a portfolio's P&L, and train others.

You move up by **doing the next level's work unsupervised, on real tasks, twice** — not by time served. Every month you and your reviewer fill the scorecard: what you can now do that you couldn't, where you got stuck (that is your next lesson), and one skill to build next.

**The heartbeat:** daily you check placement, complaints, and update the tracker. Weekly the team runs Monday-plan / Wednesday-check / Friday-wrap. Monthly you review your scorecard. Quarterly we rotate lanes and run a retro.

**Your first 30 days:** Week 1 read this and shadow a senior on one live campaign. Week 2 operate under supervision. Week 3 run a site audit and a deliverability audit with the templates. Week 4 own a small send end to end under review, and set your first scorecard.

---

## The lines you never cross (memorize)

- Complaint rate above **0.08%** on a live send → **pause immediately.**
- Mail-Tester / seed score below **9/10** → do **not** send to the main list.
- Domain EPC below **0.35 for 3 days** → trigger a network-rotation review.
- **Never** send without suppressions applied.
- Never send from a cold, un-warmed domain.
- Always run finance/health copy through compliance before it goes live.

---

## Where everything lives

- **`SKILL.md`** — your daily working map (the routing table).
- **`references/`** — the four deep-dives (deliverability, site analysis, sheets, team structure).
- **`templates/`** — copy-and-use: campaign launch, deliverability audit, site audit, weekly review, scorecard, performance tracker.
- The heavy lifting is done by the specialist skills the map points you to: `email-data-analyst`, `database-excel-specialist`, `digital-marketing-pro`, `compliance-legal-shield`, `ops-manager`, `xlsx`, `browse`.

Welcome to the team. Read it again next month — it lands differently once you have run a few campaigns.
