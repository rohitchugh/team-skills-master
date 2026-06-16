# Pillar add-on — Connect your own reports & analyze them

Each team member analyzes **their own** campaign reports — no shared spreadsheet, no waiting on someone else. Two ways to get your data in front of the skills, then a fixed analysis playbook.

---

## Getting your data in

### Option A — local export (simplest, works today)
Export your report from the ESP (Klaviyo / Mailchimp / ActiveCampaign / Pinpointe / etc.) as `.csv` or `.xlsx`, save it in a folder, and just ask:
> "Analyze this report: C:\path\to\my-report.xlsx"

The `xlsx`, `database-excel-specialist`, and `email-data-analyst` skills read the file directly. Nothing else to set up (Python is installed by the pack).

### Option B — live connection via MCP (Google Sheets, Drive, ESP API)
If your data lives in a Google Sheet or a live source, connect it once via an MCP server, then the skills query it directly.
- Use the **mcp-client** or **mcporter** skill, or `claude mcp add ...`, to connect the source.
- To find the right connector, ask Claude: *"find an MCP connector for Google Sheets"* (it searches the MCP registry).
- Once connected, ask: *"pull my campaign tab and analyze it."*

> Connect only your own accounts. Don't share credentials in chat. A connected MCP source stays on your machine/session.

---

## The analysis playbook (subject · from · timing · inboxing · HTML)

Once the data (or the email) is available, run these. Each maps to a skill.

### 1. Subject line
- Run **content-guard** on every subject (spam words, `!`, ALL-CAPS).
- With report data, ask `email-data-analyst`: open-rate by subject, A/B winner, significance.
- Output: which subjects win, which to kill, what to avoid.

### 2. From name / from address
- Run **content-guard** on the from name.
- Check consistency (same from name/address as prior good sends) and authentication (`team-inboxing-mastery` -> [01-inboxing-deliverability](01-inboxing-deliverability.md)).

### 3. Timing
- Ask `email-data-analyst`: open/click/RPE **by send hour and weekday** (pivot).
- Compare against the default window (Tue-Thu, 9-11am or 6-8pm) and find *your* best slots.

### 4. Inboxing / deliverability
- Pull delivery, open, complaint, bounce rates from the report.
- Run the [deliverability-audit](../templates/deliverability-audit.md) if placement or opens dropped.
- Watch the red lines: complaint > 0.08% (pause), bounce > 2%, open < 10%.

### 5. HTML body
- Run **content-guard** on the HTML (it scans visible text, skips tags) for spam words and `$$$`.
- Check text-to-image balance, working unsubscribe + physical address, links match, renders on mobile + dark mode (see [01-inboxing-deliverability](01-inboxing-deliverability.md) section 4).

---

## One-shot content check (before every send)

```bash
python ../../content-guard/spamcheck.py --subject "<your subject>" --from "<your from>" body.html
```
PASS = send. FAIL = rewrite the flagged words (content-guard has a rewrite cheatsheet) and re-check.

---

## Which skill does what

| Task | Skill |
|------|-------|
| Spam-word / symbol scan of subject, from, HTML | `content-guard` |
| Read/clean the report file, build pivots | `xlsx` / `database-excel-specialist` |
| Metrics, drops, A/B significance, timing analysis | `email-data-analyst` |
| Connect a live data source | `mcp-client` / `mcporter` |
| Deliverability diagnosis | `team-inboxing-mastery` -> deliverability audit |
