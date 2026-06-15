# Team Skills Master

The complete Claude Code skill pack for the email lead-gen team. One repo, one install, and every team member has the same working setup: how to land content in the inbox, analyze sites, build and read the sheets, and grow on the team.

Start here after installing: type **`/team-inboxing-mastery`** in Claude Code, and read **`skills/team-inboxing-mastery/PLAYBOOK.pdf`** first.

---

## What's inside (7 skills)

| Skill | What it does |
|-------|--------------|
| **team-inboxing-mastery** | The master hub + onboarding playbook + ready-to-use templates. Teaches the whole job and routes to the others. |
| email-data-analyst | Reads campaign metrics, finds why performance dropped, A/B significance, dashboards. |
| database-excel-specialist | Builds and automates the performance sheets, models, SQL, pivots. |
| digital-marketing-pro | Landing pages, SEO, ads, email copy, competitor analysis. |
| compliance-legal-shield | FTC / TCPA / CAN-SPAM checks, disclosures, privacy/terms. |
| ops-manager | SOPs, trackers, weekly reviews, priorities, handoffs. |
| xlsx | Direct create/edit of `.xlsx` spreadsheets (includes helper scripts). |

The master skill is built around four pillars: **content inboxing (deliverability), website/landing analysis, Excel/Sheets analytics, and team structure/growth.** Deep-dives are in `skills/team-inboxing-mastery/references/`, copy-and-use SOPs in `skills/team-inboxing-mastery/templates/`.

---

## Install

### Windows
1. Download / clone this repo.
2. Double-click **`install.bat`** (if SmartScreen warns: "More info" -> "Run anyway").
3. Restart Claude Code. Type `/team-inboxing-mastery`.

### macOS / Linux
```bash
bash install.sh
```
Then restart Claude Code and type `/team-inboxing-mastery`.

The installer copies each skill into your Claude Code skills folder
(`%USERPROFILE%\.claude\skills` on Windows, `~/.claude/skills` on macOS/Linux).
It replaces **only** the 7 skills in this pack and leaves any other skills you
already have installed untouched.

---

## Getting this repo

```bash
git clone <REPO-URL> team-skills-master
cd team-skills-master
# Windows: double-click install.bat   |   mac/linux: bash install.sh
```

No git? Download the ZIP from the repo page, extract it, and run the installer
inside.

---

## Updating later

When the pack is updated, pull and re-run the installer:

```bash
git pull
# then re-run install.bat (Windows) or bash install.sh (mac/linux)
```

Re-running is safe — it overwrites this pack's skills with the latest version.

---

## Repo layout

```
team-skills-master/
├── README.md
├── install.bat        Windows installer (double-click)
├── install.ps1        Windows install logic (called by install.bat)
├── install.sh         macOS / Linux installer
├── NOTICE.md          usage / attribution
└── skills/
    ├── team-inboxing-mastery/   (SKILL.md, PLAYBOOK.md/.pdf, references/, templates/)
    ├── email-data-analyst/
    ├── database-excel-specialist/
    ├── digital-marketing-pro/
    ├── compliance-legal-shield/
    ├── ops-manager/
    └── xlsx/
```

---

## Notes

- **`xlsx` automation** (running its Python helpers) needs Python installed on
  that machine. Reading and using the markdown skills needs nothing extra.
- These are internal team materials. Do not redistribute outside the team.
- Questions or a broken install: send the installer window output to Rohit.
