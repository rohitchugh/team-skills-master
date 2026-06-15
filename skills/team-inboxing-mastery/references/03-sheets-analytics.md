# Pillar 3 — Excel / Google Sheets Analytics

Inboxing and pages create the activity; this pillar **proves what worked and finds what to fix.** Every team member must be able to build a clean sheet and read it without being told what it says.

The model: **every number answers a decision.** If a column does not change a decision, cut it.

---

## 1. The metrics that matter (know these cold)

| Metric | Formula | What it tells you | Target |
|--------|---------|-------------------|--------|
| Open rate | opens / delivered | Subject + sender + placement working | > 18% |
| Click rate (CTR) | clicks / delivered | Content + offer relevance | > 2% |
| Click-to-open (CTOR) | clicks / opens | Did the opener care about the content | > 10% |
| Delivery rate | delivered / sent | Are we getting through at all | > 98% |
| Hard bounce rate | hard bounces / sent | List validity | < 1% |
| Complaint rate | complaints / delivered | Are we annoying people | < 0.05% (pause > 0.08%) |
| Unsub rate | unsubs / delivered | Relevance / frequency | < 0.5% |
| **RPE** (revenue per email) | revenue / delivered | The money number for email | track + grow |
| **EPC** (earnings per click) | revenue / clicks | The money number for the offer/network | > 0.48 (rotate < 0.35) |
| Conversion rate | leads or sales / clicks | Landing page + offer fit | benchmark per offer |

EPC and RPE are the two numbers leadership cares about. Everything else explains *why* they moved.

---

## 2. The core sheets we maintain

### a) Campaign performance tracker (the daily sheet)
One row per send. Columns:
```
Date | Domain | List/Segment | Subject (A/B) | Sent | Delivered | Opens | Open% |
Clicks | CTR | Leads | Revenue | RPE | EPC | Complaints | Comp% | Unsubs | Notes
```
Computed columns are formulas, not hand-typed. Conditional-format the red lines (Comp% > 0.08, EPC < 0.35) so problems jump out.

### b) Domain / network rotation model
One row per domain (mirrors the ops `domain tracker`):
```
Domain | Niche | Network (ZP/DOT/LG) | 3-day avg EPC | Status | Last action | Next review
```
Status: Active / Testing / Paused / Rotating / Retired. Rule baked into the sheet: flag any domain with 3-day EPC < 0.35.

### c) List-health sheet
```
List | Total | Engaged (opened 90d) | Engaged% | Decay rate | Hard bounce% | Last cleaned
```
Engaged% trending down = sunset/re-engage before reputation suffers (ties to [deliverability](01-inboxing-deliverability.md)).

### d) A/B test log
```
Test | Variant A | Variant B | Metric | A result | B result | Sample size | Significant? | Winner | Rolled out?
```

---

## 3. Reading the sheet — the diagnostic ladder

When a number is bad, walk DOWN the funnel to localize it:

```
Revenue down?
  └─ EPC down? ........... offer/network problem → rotate network, check landing page
  └─ Clicks down? ........ content/offer problem → CTR low → rewrite, re-segment
       └─ Opens down? .... placement or subject → Open% low → check deliverability (pillar 1)
            └─ Delivered down? ... deliverability broke → run deliverability audit
```
Always localize before acting. "Revenue is down" is not actionable; "opens dropped 40% on Gmail only" points straight at a Gmail reputation issue.

---

## 4. A/B testing — don't fool yourself

- Change **one variable** at a time (subject OR creative OR send time, not all three).
- Need enough sample for the result to be real. Rule of thumb: a few thousand per variant for open-rate tests; more for click/revenue. When in doubt, compute significance.
- A 19% vs 21% open rate on 500 emails each is **noise**, not a winner. Use the significance check (invoke `email-data-analyst`, which can compute statistical significance and interpret A/B results).
- Log every test in the A/B log so we build institutional memory and stop re-running settled tests.

---

## 5. Building the sheets — practical

- **Formulas not manual entry** for anything derived (rates, EPC, RPE). Manual numbers rot.
- **One source of truth per metric** — do not compute open rate three different ways in three tabs.
- Use pivot tables for "revenue by domain", "RPE by send time", "EPC by network".
- Clean ESP exports (Klaviyo/Mailchimp/ActiveCampaign/Pinpointe) before charting — strip junk rows, fix headers, dedupe.
- Version reports with a suffix (`_v2`, `_v3`); never overwrite a published report in place.

For execution:
- Build/automate spreadsheets, clean messy CSV/XLSX, pivots, models → invoke `database-excel-specialist` or `xlsx`.
- Interpret email metrics, list decay, revenue attribution, A/B significance, executive dashboards → invoke `email-data-analyst`.

---

## 6. Reporting up

A good report answers three questions in this order:
1. **What happened?** (the headline number vs last period)
2. **Why?** (the diagnostic — which sub-metric moved)
3. **What now?** (the recommended action)

Never hand over a table with no conclusion. The sheet is the evidence; the one-line "so what" is the deliverable.

---

## Tools cheat sheet

| Job | Tool |
|-----|------|
| Build / fix / automate a spreadsheet | invoke `database-excel-specialist` or `xlsx` |
| Interpret email metrics, find drops, A/B significance | invoke `email-data-analyst` |
| Dashboard (Power BI / Sheets) | invoke `email-data-analyst` |
| Database schema / SQL for performance data | invoke `database-excel-specialist` |
