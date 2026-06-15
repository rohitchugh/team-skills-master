---
name: database-excel-specialist
description: |
  Expert in Excel automation, Google Sheets, data modeling, and database design for affiliate marketing operations. Use this skill whenever the user wants to: analyze domain/EPC/revenue data, build Excel models, create automated spreadsheets, design database schemas, write SQL queries, build pivot reports, clean messy CSV/XLSX data, model network rotation plans, track campaign performance, or automate repetitive data tasks. Trigger for any request involving data files, spreadsheets, domain performance, EPC analysis, revenue tracking, or network shuffle planning — especially for affiliate lead-gen operations.
---

# Database & Excel Automation Specialist

Built specifically for affiliate lead-gen operations — domain rotation, EPC tracking, revenue attribution, network management.

---

## Core Data Structures (Your Operation)

### Domain Performance Table
```
| Domain | Network | Clicks | Revenue | EPC | Status | Last_Updated |
```
- EPC = Revenue / Clicks
- Status: Active / Paused / Testing / Retired
- Network: label each lead network generically (e.g. Network A / Network B / Network C); exclude any you've blacklisted

### Network Tier Model
```
Tier 1 (top network):  EPC > 0.48     (example thresholds — set your own)
Tier 2 (mid network):  EPC 0.35–0.48
Tier 3 (low network):  EPC 0.25–0.34
Retire:                EPC < 0.25 for 3+ days
```

---

## Excel Automation Patterns

### EPC Rotation Logic (Excel formula)
```excel
Network Assignment:
=IF(EPC>0.48,"TIER1", IF(EPC>0.35,"TIER2", IF(EPC>0.25,"TIER3","RETIRE")))

7-Day Rolling EPC:
=AVERAGEIF(DateRange,">="&TODAY()-7,EPCRange)

Revenue vs Prior Period:
=IFERROR((ThisPeriod-LastPeriod)/LastPeriod*100,0)

Flag underperformers:
=IF(AND(EPC<0.35,DaysSinceLastGood>3),"⚠️ ROTATE","✅ OK")
```

### Auto-Color Conditional Formatting Rules
```
Green  (#2DC653): EPC > 0.48  → Tier 1 candidate
Yellow (#F4A261): EPC 0.35–0.48 → Tier 2 candidate
Orange (#E07B39): EPC 0.25–0.34 → Tier 3 candidate
Red    (#E63946): EPC < 0.25  → Retire
```

### Pivot Table Setup (Domain Analysis)
```
Rows:    Domain
Columns: Network
Values:  Sum of Revenue, Avg of EPC, Sum of Clicks
Filter:  Date range, Status
```

---

## Python Data Scripts (pandas)

### Load & Analyze ESP Export
```python
import pandas as pd

def analyze_domains(filepath):
    df = pd.read_excel(filepath, header=1)
    df.columns = ['Domain','Clicks','Revenue','EPC','Network']
    df['EPC'] = df['Revenue'] / df['Clicks']
    df['Tier'] = df['EPC'].apply(lambda x:
        'TIER1' if x > 0.48 else
        'TIER2' if x > 0.35 else
        'TIER3' if x > 0.25 else 'RETIRE')
    df['Action'] = df.apply(lambda r:
        '🔺 Promote' if r['Tier'] != r['Network'] and r['EPC'] > 0.48 else
        '🔻 Rotate'  if r['Tier'] != r['Network'] and r['EPC'] < 0.35 else
        '✅ Hold', axis=1)
    return df.sort_values('EPC', ascending=False)
```

### Weekly Revenue Summary
```python
def weekly_summary(df):
    summary = df.groupby('Network').agg(
        Total_Revenue=('Revenue','sum'),
        Total_Clicks=('Clicks','sum'),
        Avg_EPC=('EPC','mean'),
        Domain_Count=('Domain','count')
    ).round(3)
    summary['Revenue_Share'] = (summary['Total_Revenue'] /
        summary['Total_Revenue'].sum() * 100).round(1)
    return summary
```

---

## Database Schema (PostgreSQL)

### Affiliate Operations DB
```sql
CREATE TABLE domains (
    id SERIAL PRIMARY KEY,
    domain VARCHAR(255) UNIQUE NOT NULL,
    niche VARCHAR(50), -- finance/auto/mortgage/home/nutra
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE performance_daily (
    id SERIAL PRIMARY KEY,
    domain_id INT REFERENCES domains(id),
    network VARCHAR(20), -- generic network label (Network A/B/C)
    report_date DATE,
    clicks INT,
    revenue DECIMAL(10,2),
    epc DECIMAL(6,4) GENERATED ALWAYS AS (revenue/NULLIF(clicks,0)) STORED,
    UNIQUE(domain_id, network, report_date)
);

CREATE TABLE network_assignments (
    domain_id INT REFERENCES domains(id),
    network VARCHAR(20),
    assigned_at TIMESTAMP DEFAULT NOW(),
    reason TEXT -- "EPC dropped below 0.35 for 3 days"
);

-- Useful views
CREATE VIEW current_performance AS
SELECT d.domain, p.network, p.epc,
    CASE WHEN p.epc > 0.48 THEN 'TIER1'
         WHEN p.epc > 0.35 THEN 'TIER2'
         WHEN p.epc > 0.25 THEN 'TIER3'
         ELSE 'RETIRE' END AS recommended_tier
FROM domains d
JOIN performance_daily p ON d.id = p.domain_id
WHERE p.report_date = CURRENT_DATE - 1;
```

---

## Deliverables

| Request | Output |
|---------|--------|
| Upload data.xlsx | Instant analysis + rotation recommendations |
| "Build EPC tracker" | Full Excel model with formulas + conditional formatting |
| "Weekly report" | Revenue summary by domain/network/niche |
| "Shuffle network plan" | Color-coded Excel with old→new assignments |
| "Build affiliate DB" | PostgreSQL schema + query library |
| "Clean this CSV" | Standardized, deduped, formatted output |
