---
name: team-inboxing-mastery
description: |
  Master operating skill for the email lead-gen team. The single entry point a team member opens to learn and run the whole job: content inboxing (email deliverability), website/landing-page analysis, Excel/Google Sheets analytics, and the team operating structure that lets people grow into doing more. Use this skill whenever a team member needs to: understand how inboxing works end to end, audit a landing page or competitor site, build or read a performance sheet, follow a campaign-launch SOP, run a weekly review, or figure out what to learn next to level up. This is the hub — it routes to the four pillar deep-dives in references/ and the ready-to-use templates/ and hands off to the specialist skills for execution.
---

# Team Inboxing Mastery — the team's operating system

This is the master skill. One place a team member can open and understand **everything** about how we get content into the inbox, prove it with data, and keep getting better. It teaches the four pillars of the job and tells you which specialist skill or template to use for any given task.

If you are new: read the [PLAYBOOK.md](PLAYBOOK.md) end to end first (it is the human version of this skill). Then come back here and use it as your daily map.

---

## The four pillars

Everyone on the team learns all four. You will start strong in one and cross-train into the others (see the skill ladder below).

| # | Pillar | What it means | Deep dive | Specialist skill to execute with |
|---|--------|---------------|-----------|----------------------------------|
| 1 | **Content Inboxing (Deliverability)** | Getting the email into the inbox, not spam or promotions. Authentication, reputation, warmup, content hygiene, seed testing. | [references/01-inboxing-deliverability.md](references/01-inboxing-deliverability.md) | `email-data-analyst`, `compliance-legal-shield`, `digital-marketing-pro` |
| 2 | **Website & Landing Analysis** | Auditing our landing pages and competitor sites: speed, compliance, conversion, mobile, tracking, teardown. | [references/02-website-landing-analysis.md](references/02-website-landing-analysis.md) | `digital-marketing-pro`, `browse`, `scrape`, `fullstack-developer` |
| 3 | **Excel / Google Sheets Analytics** | Building and reading the sheets: opens, clicks, revenue, EPC, RPE, list health, A/B significance, pivots, network rotation models. | [references/03-sheets-analytics.md](references/03-sheets-analytics.md) | `database-excel-specialist`, `xlsx`, `email-data-analyst` |
| 4 | **Team Structure & Growth** | How roles, lanes, SOPs, reviews, and the skill ladder fit together so people grow into doing more. | [references/04-team-structure-growth.md](references/04-team-structure-growth.md) | `ops-manager` |

> "Content inboxing" = the discipline of pillar 1, supported by all the others. A great subject line means nothing if the message lands in spam; a perfect inbox placement means nothing if the landing page does not convert; and none of it compounds if we cannot read the numbers and improve. That is why this skill ties all four together.

---

## How to use this skill (routing)

State what you need; this skill points you to the right place.

| You need to... | Do this |
|----------------|---------|
| Learn the whole job from zero | Read [PLAYBOOK.md](PLAYBOOK.md), then shadow a senior on one live campaign |
| Understand why mail goes to spam | [references/01-inboxing-deliverability.md](references/01-inboxing-deliverability.md) |
| Launch an email campaign safely | [templates/campaign-launch-checklist.md](templates/campaign-launch-checklist.md) |
| Diagnose a deliverability drop | [templates/deliverability-audit.md](templates/deliverability-audit.md) |
| Audit a landing page or competitor | [templates/site-audit.md](templates/site-audit.md) + [references/02-website-landing-analysis.md](references/02-website-landing-analysis.md) |
| Build or fix a performance sheet | [references/03-sheets-analytics.md](references/03-sheets-analytics.md) + invoke `database-excel-specialist` or `xlsx` |
| Read the numbers / find why revenue dropped | [references/03-sheets-analytics.md](references/03-sheets-analytics.md) + invoke `email-data-analyst` |
| Run the weekly review | [templates/weekly-review.md](templates/weekly-review.md) |
| Know what to learn next / level up | [templates/skill-ladder-scorecard.md](templates/skill-ladder-scorecard.md) + [references/04-team-structure-growth.md](references/04-team-structure-growth.md) |
| Check something is legal/compliant | invoke `compliance-legal-shield` |

---

## The team operating model (recommended)

**Generalists who level up, with a rotating owned lane.** Every member is trained on all four pillars so the team has no single points of failure, but at any time each person *owns* one lane (Deliverability / Site & Landing / Analytics / Ops-coordination) and rotates lanes each quarter. This builds depth without creating silos, and means anyone can cover for anyone.

Why this over pure specialists: at our size (8-person team) specialists create bottlenecks — if the one "deliverability person" is out, sends stall. Generalists-with-a-lane keeps the bus-factor high and gives people a clear path to grow. Full rationale and the alternative tracks are in [references/04-team-structure-growth.md](references/04-team-structure-growth.md).

### The skill ladder (how people grow into doing more)

| Level | Title | Owns | Can do unsupervised |
|-------|-------|------|---------------------|
| **L1** | Operator | Following SOPs | Pull a segment, apply suppressions, run a test send, fill the tracker |
| **L2** | Analyst | One lane | Read the sheets, run a deliverability audit, audit a landing page, spot a drop |
| **L3** | Lead | One lane + reviews others | Diagnose root cause, design an A/B test, approve a campaign to send, rotate a network |
| **L4** | Owner | The whole funnel | Set strategy, own a domain portfolio's P&L, train L1/L2, decide warmup/rotation policy |

Each member has a scorecard ([templates/skill-ladder-scorecard.md](templates/skill-ladder-scorecard.md)) reviewed monthly. Promotion = demonstrate the next level's "can do unsupervised" column on real work, twice.

---

## Daily and weekly cadence (the heartbeat)

```
DAILY (per person, ~30 min)
  □ Check inbox-placement / seed results for yesterday's sends
  □ Check complaint rate + bounce rate on live campaigns
  □ Update the performance tracker with yesterday's numbers
  □ Flag anything red in the team channel

WEEKLY (team, see templates/weekly-review.md)
  Mon  Review last week's EPC/RPE by domain + plan top 3 priorities
  Wed  Mid-week check: deliverability, pacing, tech issues
  Fri  Wrap + handoff: document what moved, update trackers
```

Hard stops everyone must know (memorize these):
- Complaint rate **> 0.08%** on a live send → **pause immediately** and investigate.
- Mail-Tester / seed score **< 9/10** → do **not** send to the main list; fix content/auth first.
- Domain EPC **< 0.35 for 3 days** → trigger network rotation review.
- Never send without suppressions applied (unsubscribes, bounces, complaints).

---

## What "good" looks like (team-wide targets)

| Metric | Target | Red line |
|--------|--------|----------|
| Inbox placement (seed) | > 90% | < 80% |
| Open rate | > 18% | < 10% |
| Complaint rate | < 0.05% | > 0.08% |
| Hard bounce rate | < 1% | > 2% |
| Domain EPC | > 0.48 | < 0.35 |
| Revenue per email (RPE) | track + improve | declining 2 weeks |

Definitions, formulas, and how to compute each are in [references/03-sheets-analytics.md](references/03-sheets-analytics.md).

---

## Sharing this with the team

This whole folder is the package. To onboard a new member or hand it to the team:
1. Give them the folder (or the zip) — it is self-contained.
2. Have them read `PLAYBOOK.md` first (the human handbook / PDF).
3. They invoke `team-inboxing-mastery` in Claude Code / Odysseus as their daily map.
4. The specialist skills (`email-data-analyst`, `database-excel-specialist`, `digital-marketing-pro`, `ops-manager`, `compliance-legal-shield`, `xlsx`) do the heavy execution; this skill tells them which to use when.

Keep this skill as the **only** thing a team member has to remember the name of. Everything else routes from here.
