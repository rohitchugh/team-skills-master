# Pillar 4 — Team Structure & Growth

How the people fit together so the team can "do multiple things" and keep improving. This is the structure recommendation, the reasoning behind it, and the machinery (lanes, ladder, reviews) that makes it run.

---

## The recommended model: generalists who level up, with a rotating owned lane

Every member is trained on all four pillars. At any time each person **owns one lane**; lanes rotate each quarter.

The four lanes:
1. **Deliverability** — owns auth, warmup, reputation, seed tests, the deliverability audit.
2. **Site & Landing** — owns page audits, competitor teardowns, conversion fixes (with dev/design handoff).
3. **Analytics** — owns the performance sheets, the diagnostics, the weekly numbers, A/B significance.
4. **Ops-coordination** — owns the cadence, trackers, SOPs, handoffs, "what's live vs paused".

### Why this model (the reasoning)

| Option | Pro | Con | Verdict |
|--------|-----|-----|---------|
| Pure specialists | Deep expertise | Bottlenecks; if the one deliverability person is out, sends stall; low bus-factor; people plateau | ✗ risky at 8 people |
| Pure generalists (no lanes) | Total coverage | No one owns anything deeply; quality drifts; no clear growth path | ✗ shallow |
| **Generalists + rotating lane** | Depth where it matters + coverage everywhere + clear growth path + high bus-factor | Needs disciplined cross-training and rotation | ✓ **recommended** |

At our size the failure mode to avoid is the single point of failure. Rotation forces cross-training (you cannot rotate into a lane you cannot do), which is exactly what "the team understands everything" requires.

---

## The skill ladder (how a person grows into doing more)

| Level | Title | Owns | Can do unsupervised | Typical time at level |
|-------|-------|------|---------------------|----------------------|
| **L1** | Operator | Following SOPs | Pull a segment, apply suppressions, run a test send, fill the tracker, run Mail-Tester | 1-3 months |
| **L2** | Analyst | One lane | Read the sheets, run a deliverability audit, audit a landing page, spot and localize a drop | 3-9 months |
| **L3** | Lead | A lane + reviews others' work | Diagnose root cause, design an A/B test, approve a campaign to send, execute a network rotation | 9+ months |
| **L4** | Owner | The whole funnel | Set strategy, own a portfolio's P&L, set warmup/rotation policy, train L1/L2 | — |

**Promotion rule:** demonstrate the next level's "can do unsupervised" items on *real work, twice, reviewed by an L3+*. No time-served promotions. Tracked on the [scorecard](../templates/skill-ladder-scorecard.md).

**Cross-training rule:** to reach L3 you must have run all four lanes at least at L2. This is what makes the team resilient and what "understands everything about content inboxing" means in practice.

---

## The cadence that keeps it improving

```
DAILY (each person)      — see SKILL.md heartbeat: check placement, complaints, update tracker, flag red
WEEKLY (team)            — Mon plan / Wed check / Fri wrap+handoff (templates/weekly-review.md)
MONTHLY (each person)    — scorecard review: what leveled up, what's next, one skill to build
QUARTERLY (team)         — lane rotation; retro on what worked; reset targets
```

### Monthly 1:1 / scorecard review (15 min)
- What did you do unsupervised this month that you couldn't last month?
- Where did you get stuck / need help? (that's the next thing to learn)
- One concrete skill to build before next month, with a real task to prove it on.

### Quarterly retro (team)
- What moved the money? What wasted time?
- Which SOPs need updating (reality drifted from the doc)?
- Rotate lanes; update the index of who-owns-what.

---

## SOPs and handoffs (so knowledge doesn't live in one head)

- Every repeatable task has an SOP (the templates here are the starting set). When someone finds a better way, they update the SOP — the doc is living.
- Every Friday handoff documents: what changed, what's blocked, what's queued. A person should be able to be out for a week and the team continues from the doc.
- Use `ops-manager` to generate new SOPs, weekly-review templates, handoff docs, and the priority-scored task list.

---

## How a new hire ramps (first 30 days)

```
Week 1  — Read PLAYBOOK.md. Shadow an L2+ on one live campaign end to end. Learn the trackers.
Week 2  — Operate under supervision: pull a segment, apply suppressions, run a test send + Mail-Tester.
Week 3  — Run a landing-page audit and a deliverability audit using the templates; review with a Lead.
Week 4  — Own a small live send end to end under review. Set first scorecard + the one skill to build.
```

By day 30 a new hire is a functioning L1 with a clear path to L2 in a named lane.

---

## Tools cheat sheet

| Job | Tool |
|-----|------|
| Create SOPs, weekly reviews, handoff docs, priority lists | invoke `ops-manager` |
| Track domains live/paused/rotating | `ops-manager` domain tracker |
| Build the scorecard / review docs | this folder's templates + `ops-manager` |
