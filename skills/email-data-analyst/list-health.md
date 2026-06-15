# List Health — Deep Segmentation Models

## RFM Segmentation for Email Lists

RFM = Recency (last open/click) + Frequency (how often they engage) + Monetary (revenue generated)

### RFM Scoring in Excel

```excel
Recency Score (1-5):
=IF(DaysSinceLastOpen<=7,5, IF(DaysSinceLastOpen<=30,4, IF(DaysSinceLastOpen<=60,3, IF(DaysSinceLastOpen<=90,2,1))))

Frequency Score (1-5):
=IF(OpensLast90Days>=10,5, IF(OpensLast90Days>=6,4, IF(OpensLast90Days>=3,3, IF(OpensLast90Days>=1,2,1))))

Monetary Score (1-5):
=IF(TotalRevenue>=500,5, IF(TotalRevenue>=200,4, IF(TotalRevenue>=50,3, IF(TotalRevenue>0,2,1))))

RFM Total: =R+F+M (max 15)
```

### RFM Segments

| RFM Score | Segment | Action |
|-----------|---------|--------|
| 13–15 | Champions | VIP offers, referral ask, upsell |
| 10–12 | Loyal | Reward loyalty, cross-sell niches |
| 8–9 | Potential Loyalists | Increase frequency, test new offers |
| 6–7 | At Risk | Re-engagement sequence now |
| 4–5 | Hibernating | Win-back campaign, last chance |
| 3 and below | Lost | Suppress — stop sending |

---

## List Decay Model (12-Month Projection)

```
Starting list size: [A]
Monthly gross churn: 2.5% (industry avg — unsubscribes + bounces + inactivity)
Monthly new subscribers: [B]

Month N size = A × (1-0.025)^N + B × ((1-(1-0.025)^N)/0.025)

Break-even acquisition rate = A × 0.025 = [X] new subs/month just to maintain size
```

### Excel Model

| Month | Start Size | Churn (-2.5%) | New Subs | End Size |
|-------|-----------|---------------|----------|----------|
| Jan | 50,000 | -1,250 | +800 | 49,550 |
| Feb | 49,550 | -1,239 | +800 | 49,111 |
| ... | ... | ... | ... | ... |

Formula: `=B2*(1-0.025)+D2`

---

## Suppression Strategy

### Who to suppress (and when)

| Condition | Suppress After | Reason |
|-----------|---------------|--------|
| Hard bounce | Immediately | Invalid address — damages sender rep |
| Spam complaint | Immediately | ISP blocklisting risk |
| 3 soft bounces | After 3rd bounce | Likely bad address |
| No open in 90 days | After win-back attempt | List hygiene |
| Manually unsubscribed | Immediately (legal) | CAN-SPAM / GDPR required |

### Re-permission Campaign (before suppressing 90-day inactives)

Send 1 email:
- Subject: "Do you still want to hear from us?"
- Body: Simple — "Click to stay subscribed, or we'll remove you automatically"
- [YES, KEEP ME SUBSCRIBED] button
- Anyone who doesn't click within 7 days → suppress

This recovers ~5–15% of "dormant" subscribers and cleans the rest cleanly.

---

## Engagement Scoring Model

Score every subscriber 0–100 based on recent behavior:

```
Points assigned:
+20 — Opened in last 7 days
+15 — Clicked in last 7 days
+10 — Opened in last 30 days
+5  — Clicked in last 30 days
-5  — No open in 30–60 days
-15 — No open in 60–90 days
-25 — No open in 90+ days
+10 — Made a purchase/conversion ever
+5  — Referred someone

Score bands:
80–100: Super engaged → send at full frequency
50–79:  Engaged → standard cadence
25–49:  Cooling off → reduce frequency, test re-engagement
0–24:   Cold → re-engagement sequence or suppress
```

---

## Deliverability Health Scorecard

Rate each item 0–2 (0=bad, 1=ok, 2=good). Max score = 20.

| Factor | Check | Score |
|--------|-------|-------|
| SPF record | Set and valid | /2 |
| DKIM | Signing enabled | /2 |
| DMARC | p=quarantine or reject | /2 |
| Bounce rate | <1% = 2pts, 1-2% = 1pt, >2% = 0 | /2 |
| Spam complaint rate | <0.02% = 2pts, <0.08% = 1pt, higher = 0 | /2 |
| Sending domain age | >6 months old | /2 |
| Consistent volume | No sudden spikes | /2 |
| List hygiene | Cleaned in last 90 days | /2 |
| Engagement rate | >20% active openers | /2 |
| Unsubscribe rate | <0.2% per send | /2 |

**Score 18–20**: Excellent deliverability  
**Score 14–17**: Good, minor issues to fix  
**Score 10–13**: At risk — take action now  
**Score <10**: Crisis — likely hitting spam folders  
