# Power BI — Email Marketing Dashboard Templates

## Dashboard Architecture

```
Email Marketing Analytics Workspace
├── Page 1: Executive Summary
├── Page 2: Campaign Deep Dive
├── Page 3: List Health Monitor
└── Page 4: A/B Test Tracker
```

---

## Data Model (Tables & Relationships)

```
Campaigns (fact table)
├── CampaignID (PK)
├── CampaignName
├── SendDate
├── Segment
├── CampaignType (promotional/nurture/re-engagement/transactional)
├── Sent
├── Delivered
├── UniqueOpens
├── UniqueClicks
├── Unsubscribes
├── Complaints
├── HardBounces
├── Revenue

List (dimension table)
├── Date
├── TotalListSize
├── ActiveSubscribers (opened in 90 days)
├── AtRisk (no open 31-60 days)
├── Dormant (no open 61-90 days)
├── Dead (no open 90+ days)
├── NewSubscribers
├── ChurnedThisMonth

Date (dimension table — standard Power BI calendar table)

ABTests (fact table)
├── TestID
├── TestName
├── StartDate
├── EndDate
├── VariantA_Sent, VariantA_Opens, VariantA_Clicks, VariantA_Revenue
├── VariantB_Sent, VariantB_Opens, VariantB_Clicks, VariantB_Revenue
├── StatisticallySignificant (Yes/No)
├── Winner (A/B/Inconclusive)
├── RevenueLift
```

---

## Page 1: Executive Summary

### Visuals
1. **4 KPI Cards** (top row)
   - Total Revenue (vs. prior period % change)
   - Avg Open Rate (with benchmark line at 22%)
   - Revenue per Email (vs. prior period)
   - List Size (with trend arrow)

2. **Revenue Trend Line Chart**
   - X: Month, Y: Revenue
   - Add benchmark line (target RPE × delivered)
   - Color: teal/navy (match brand)

3. **Performance Gauge — List Health Score**
   - 0–100 score based on engagement + churn metrics
   - Red/Yellow/Green zones

4. **Campaign Type Breakdown — Donut Chart**
   - Promotional / Nurture / Re-engagement / Transactional
   - Size = Revenue generated

### DAX Measures
```dax
Total Revenue = SUM(Campaigns[Revenue])

Avg Open Rate = DIVIDE(SUM(Campaigns[UniqueOpens]), SUM(Campaigns[Delivered]))

RPE = DIVIDE([Total Revenue], SUM(Campaigns[Delivered]))

Prior Period Revenue = 
CALCULATE([Total Revenue], DATEADD('Date'[Date], -1, MONTH))

Revenue Change % = 
DIVIDE([Total Revenue] - [Prior Period Revenue], [Prior Period Revenue])

List Health Score = 
VAR ActivePct = DIVIDE(SUM(List[ActiveSubscribers]), SUM(List[TotalListSize]))
VAR ChurnRate = DIVIDE(SUM(List[ChurnedThisMonth]), SUM(List[TotalListSize]))
VAR BounceRate = DIVIDE(SUM(Campaigns[HardBounces]), SUM(Campaigns[Delivered]))
RETURN 
    (ActivePct * 50) + 
    ((1 - ChurnRate * 10) * 30) + 
    ((1 - BounceRate * 20) * 20)
```

---

## Page 2: Campaign Deep Dive

### Visuals
1. **Campaign Performance Table**
   - Columns: Name | Date | Sent | Open% | CTR | CTOR | RPE | Revenue
   - Conditional formatting: RPE green >$0.15, yellow $0.05–$0.15, red <$0.05

2. **Open Rate vs RPE Scatter Plot**
   - X: Open Rate, Y: RPE
   - Bubble size: Emails Sent
   - Quadrants: High open + High RPE = star campaigns

3. **Campaign Type Performance Bar**
   - Grouped bar: Open Rate + CTR by campaign type

4. **Send Day Heatmap**
   - Day of week vs. Hour of day
   - Color intensity = avg open rate
   - Identify best send times

### Key DAX
```dax
Open Rate by Campaign = 
DIVIDE(SUM(Campaigns[UniqueOpens]), SUM(Campaigns[Delivered]))

CTOR = 
DIVIDE(SUM(Campaigns[UniqueClicks]), SUM(Campaigns[UniqueOpens]))

Campaign RPE = 
DIVIDE(SUM(Campaigns[Revenue]), SUM(Campaigns[Delivered]))

Unsubscribe Rate = 
DIVIDE(SUM(Campaigns[Unsubscribes]), SUM(Campaigns[Delivered]))

Complaint Rate = 
DIVIDE(SUM(Campaigns[Complaints]), SUM(Campaigns[Delivered]))

-- Red flag alerts
Deliverability Alert = 
IF([Complaint Rate] > 0.001, "⚠️ HIGH COMPLAINTS", 
    IF([Unsubscribe Rate] > 0.003, "⚠️ HIGH UNSUBS", "✅ OK"))
```

---

## Page 3: List Health Monitor

### Visuals
1. **Segment Breakdown Donut**
   - Champions / Active / At-Risk / Dormant / Dead
   - Click to filter campaigns by segment

2. **List Size Trend (12 months)**
   - Line: Total list size
   - Stacked area: Active vs inactive breakdown
   - Bar overlay: Monthly new subscribers

3. **Monthly Churn Waterfall**
   - Start size → +New subs → -Unsubscribes → -Bounces → -Inactivity suppress → End size

4. **Deliverability Scorecard Table**
   - Bounce rate | Complaint rate | Unsubscribe rate
   - Vs. benchmarks, color coded

### Key DAX
```dax
Active Subscribers = SUM(List[ActiveSubscribers])

Inactive % = 
DIVIDE(
    SUM(List[TotalListSize]) - SUM(List[ActiveSubscribers]),
    SUM(List[TotalListSize])
)

Monthly Churn Rate = 
DIVIDE(SUM(List[ChurnedThisMonth]), SUM(List[TotalListSize]))

List Growth Rate = 
DIVIDE(SUM(List[NewSubscribers]) - SUM(List[ChurnedThisMonth]), 
    CALCULATE(SUM(List[TotalListSize]), DATEADD('Date'[Date], -1, MONTH)))

Months to List Decay = 
VAR NetGrowth = [List Growth Rate]
RETURN IF(NetGrowth < 0, DIVIDE(1, ABS(NetGrowth)), BLANK())
```

---

## Page 4: A/B Test Tracker

### Visuals
1. **Test Results Table**
   - Test Name | Dates | Metric tested | A vs B result | Sig? | Winner | Revenue lift

2. **Cumulative Revenue from Winning Tests**
   - Running total bar chart by month

3. **Win Rate by Test Type**
   - Subject line / Send time / Content / Offer / Segment
   - Which type of test drives most wins?

### Key DAX
```dax
Total Revenue Lift from Tests = SUM(ABTests[RevenueLift])

Test Win Rate = 
DIVIDE(
    COUNTROWS(FILTER(ABTests, ABTests[Winner] <> "Inconclusive")),
    COUNTROWS(ABTests)
)

Avg Lift per Winning Test = 
DIVIDE(
    SUM(ABTests[RevenueLift]),
    COUNTROWS(FILTER(ABTests, ABTests[Winner] <> "Inconclusive"))
)
```

---

## Color Theme (Finance/Professional)

```
Primary: #1E3A5F (dark navy)
Accent: #00B4D8 (teal)
Success: #2DC653 (green)
Warning: #F4A261 (amber)
Danger: #E63946 (red)
Background: #F8F9FA (light grey)
Text: #212529 (near black)
```

---

## Excel Companion Model

For users who want Excel alongside Power BI:

**Tab structure:**
1. `Raw Data` — paste ESP export here (never touch)
2. `Cleaned` — formulas pulling from raw, standardized columns
3. `Metrics` — calculated KPIs with benchmark comparisons
4. `Dashboard` — charts linked from Metrics tab
5. `A/B Tests` — test log with significance calculator
6. `List Health` — segment breakdown + decay projection
7. `Monthly Report` — auto-populated exec summary table

**Protect Raw Data tab** — lock cells, tell user to only paste in the yellow columns.
