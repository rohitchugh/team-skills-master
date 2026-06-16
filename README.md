# Team Skills Master

The complete Claude Code skill pack for the email lead-gen team. One repo, one install, and every team member has the same working setup: how to land content in the inbox, analyze sites, build and read the sheets, and grow on the team.

Start here after installing: type **`/team-inboxing-mastery`** in Claude Code, and read **`skills/team-inboxing-mastery/PLAYBOOK.pdf`** first.

---

## What's inside (8 skills)

| Skill | What it does |
|-------|--------------|
| **team-inboxing-mastery** | The master hub + onboarding playbook + ready-to-use templates. Teaches the whole job and routes to the others. |
| content-guard | Scans subject / from / HTML against a 369-word spam blacklist (+ `!`, `$`, ALL-CAPS); flags or strips. Run before every send. |
| email-data-analyst | Reads campaign metrics, finds why performance dropped, A/B significance, dashboards. |
| database-excel-specialist | Builds and automates the performance sheets, models, SQL, pivots. |
| digital-marketing-pro | Landing pages, SEO, ads, email copy, competitor analysis. |
| compliance-legal-shield | FTC / TCPA / CAN-SPAM checks, disclosures, privacy/terms. |
| ops-manager | SOPs, trackers, weekly reviews, priorities, handoffs. |
| xlsx | Direct create/edit of `.xlsx` spreadsheets (includes helper scripts). |

The master skill is built around four pillars: **content inboxing (deliverability), website/landing analysis, Excel/Sheets analytics, and team structure/growth.** Deep-dives are in `skills/team-inboxing-mastery/references/`, copy-and-use SOPs in `skills/team-inboxing-mastery/templates/`.

---

## Install

### Easiest: one command (recommended)

Paste this into a terminal. It installs git if needed, downloads the skills, and
sets up Python automatically. No login or account required.

**Windows** (PowerShell):
```powershell
irm https://gist.githubusercontent.com/rohitchugh/915e834a4e28a9587e177d7c8b2df45b/raw/bootstrap.ps1 | iex
```

**macOS / Linux** (Terminal):
```bash
curl -fsSL https://gist.githubusercontent.com/rohitchugh/915e834a4e28a9587e177d7c8b2df45b/raw/bootstrap.sh | bash
```

Then restart Claude Code and type `/team-inboxing-mastery`.

### Manual alternative

**Windows**
1. Download / clone this repo.
2. Double-click **`install.bat`** (if SmartScreen warns: "More info" -> "Run anyway").
3. Restart Claude Code. Type `/team-inboxing-mastery`.

**macOS / Linux**
```bash
bash install.sh
```
Then restart Claude Code and type `/team-inboxing-mastery`.

The installer copies each skill into your Claude Code skills folder
(`%USERPROFILE%\.claude\skills` on Windows, `~/.claude/skills` on macOS/Linux).
It replaces **only** the 8 skills in this pack and leaves any other skills you
already have installed untouched.

**It also configures Claude Code to work hands-free**, by merging into your
`~/.claude/settings.json` (existing hooks/keys are preserved, not overwritten):
- `permissions.defaultMode = bypassPermissions` — skills run without asking for
  permission on every command, so you work like the owner does.
- Installs the team operating rules to `~/.claude/CLAUDE.md` **only if you don't
  already have one** (otherwise it leaves yours alone and points you to
  `team-operating-rules.md`).

> bypassPermissions means Claude executes commands without prompting. That's the
> intended setup for this trusted internal team. If a member wants prompts back,
> set `defaultMode` to `default` in their `settings.json`.

What is intentionally **not** copied (owner-specific, would break or leak):
personal hooks, the owner's memory, gitnexus, and credentials. Each member works
on **their own** data with the **same skills + Python + permissions + rules**.

**Python is set up automatically.** The installer detects Python; if it's
missing it installs Python 3 (Windows: via winget; macOS: Homebrew; Linux:
apt/dnf/pacman), then installs the packages the `xlsx` skill needs
(`openpyxl`, `pandas`, `lxml`, `defusedxml` — see `requirements.txt`). If
auto-install can't run on a locked-down machine, the installer prints a clear
manual fallback and continues — only the `xlsx` automation depends on Python.

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
