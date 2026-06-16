# Team Operating Rules (Claude Code)

These are the working rules for the email lead-gen team. They make Claude behave
consistently for everyone: concise, autonomous, and safe. Installed to your
`~/.claude/CLAUDE.md` so they apply to every session.

## How Claude should work
- Read existing files before writing. Don't re-read unchanged files.
- Thorough in reasoning, concise in output. No filler, no emojis, no em-dashes.
- Don't guess APIs, versions, flags, or file contents. Verify by reading first.
- Execute autonomously. Don't stop to confirm routine steps; flag only genuinely
  destructive or irreversible actions (deleting data, sending to a live list,
  overwriting a versioned report).

## Email work (non-negotiable)
- Run **content-guard** on every subject, from name, and body before sending.
  Rewrite flagged words; never send with blacklisted words still in.
- Never send without suppressions applied (unsubscribes, bounces, complainers).
- Hard stops: complaint rate > 0.08% -> pause; Mail-Tester < 9/10 -> don't send;
  domain EPC < 0.35 for 3 days -> rotation review.
- Start from `/team-inboxing-mastery` — it routes to the right skill/template.

## Data safety
- Work on your own copies. Version reports with a suffix (`_v2`), never overwrite
  a published file in place.
- Keep project files backed up; don't store the only copy on the C: drive.
