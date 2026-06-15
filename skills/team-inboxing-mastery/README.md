# team-inboxing-mastery — shareable team package

This folder is a self-contained training + operating package for the email lead-gen team. Hand it to anyone; it has no external dependencies beyond the specialist skills it points to.

## What's inside
```
team-inboxing-mastery/
├── SKILL.md              ← master skill: the daily working map / router (invoke in Claude Code / Odysseus)
├── PLAYBOOK.md           ← human handbook: read this first (also exported to PLAYBOOK.pdf)
├── PLAYBOOK.pdf          ← printable version of the handbook
├── README.md             ← this file
├── references/           ← the four pillar deep-dives
│   ├── 01-inboxing-deliverability.md
│   ├── 02-website-landing-analysis.md
│   ├── 03-sheets-analytics.md
│   └── 04-team-structure-growth.md
└── templates/            ← copy-and-use SOPs + the tracker
    ├── campaign-launch-checklist.md
    ├── deliverability-audit.md
    ├── site-audit.md
    ├── weekly-review.md
    ├── skill-ladder-scorecard.md
    └── performance-tracker.csv
```

## How a team member uses it
1. Read `PLAYBOOK.md` (or `PLAYBOOK.pdf`) end to end.
2. Shadow a senior on one live campaign.
3. Use the templates for every real task (launch, audits, weekly review, scorecard).
4. Invoke `team-inboxing-mastery` in Claude Code / Odysseus as the daily map — it routes to the specialist skills (`email-data-analyst`, `database-excel-specialist`, `digital-marketing-pro`, `compliance-legal-shield`, `ops-manager`, `xlsx`, `browse`) that do the execution.

## How to install the skill (so it's invocable by name)
Copy this whole folder into the skills directory of each person's Claude Code / Odysseus:
- Claude Code (Windows): `C:\Users\<user>\.claude\skills\team-inboxing-mastery\`
- Or your Odysseus skills path.

The skill is recognized by `SKILL.md` at the folder root.

## How to share as a single file
Zip this folder and send it. It is fully self-contained.

## Updating
The templates and references are living documents. When someone finds a better way, update the doc and re-share. Version any exported reports with a suffix (`_v2`); never overwrite a published file in place.
