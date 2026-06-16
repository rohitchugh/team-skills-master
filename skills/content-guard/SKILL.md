---
name: content-guard
description: |
  Spam-word and content safety guard for email campaigns. Use this skill whenever a team member writes, reviews, or pastes email content (subject line, from name, preview text, or HTML/text body) and needs it checked against the blacklist of spam-trigger words before sending. Triggers: "check this subject", "is this email spammy", "scan my content", "clean this email", "will this hit spam", "review my from line", or any time email copy is being drafted or finalized. ALWAYS run this before a campaign goes out. The skill flags every blacklisted word, risky symbol (!, $, ALL-CAPS), gives a risk level, and can auto-strip the flagged words.
---

# Content Guard — keep spam-trigger words out of the send

Blacklisted words in a subject line, from name, or body are one of the fastest ways into the spam folder. This skill scans content against a 369-term blacklist (plus `!`, `$`, and ALL-CAPS checks) and tells you exactly what to fix.

The blacklist lives in [blacklist.txt](blacklist.txt). The scanner is [spamcheck.py](spamcheck.py) (Python; installed by the pack).

---

## When to use it (do this every time)

Run the guard on **every** subject, from name, and body **before sending** — and any time you draft or edit email copy. If anything is flagged, rewrite and re-check until it passes.

## How Claude should apply it

When a team member is writing or reviewing email content, Claude must:
1. Run the content through the scanner (or apply the blacklist directly from `blacklist.txt`).
2. Show the flagged words per field (subject / from / body) with counts and the risk level.
3. **Rewrite** the flagged words into clean alternatives that keep the meaning, rather than blindly deleting (blind deletion breaks sentences — see note below). Show the before/after.
4. Re-check the rewrite and confirm it passes.

Never let content go out with blacklisted words still in it.

---

## Commands

```bash
# Scan a body file (HTML auto-detected by extension)
python spamcheck.py body.html

# Scan subject + from + body together
python spamcheck.py --subject "Your update is ready" --from "Maria" body.html

# Scan piped/pasted content
echo "<p>Apply now and get fast cash</p>" | python spamcheck.py --html -

# Machine-readable result (for automation / dashboards)
python spamcheck.py --json body.html

# Aggressively strip every flagged word (REVIEW the output — see note)
python spamcheck.py --clean body.html -o body.cleaned.html
```

Exit code: `0` = clean (PASS), `1` = blacklisted terms found (FAIL). Useful in scripts and pre-send gates.

What it checks:
- Every blacklisted word/phrase (whole-word, case-insensitive, phrase-aware, apostrophe-insensitive).
- Symbols/style: `!` count, `$` count, ALL-CAPS words.
- HTML tags are skipped — only visible text is scanned/cleaned.

Risk levels: `PASS` (0 flags) -> `LOW` (1-3) -> `MEDIUM` (4-8) -> `HIGH` (9+).

---

## Important: prefer rewriting over auto-stripping

The blacklist is intentionally broad and includes common words (get, now, free, offer, loan, cash, check, only, rates...). `--clean` removes every match, which will mangle normal sentences (e.g. "Get your free quote now" becomes "your quote"). So:

- Use the **report** to see what's flagged.
- **Rewrite** the copy to say the same thing without the trigger words (this is the real skill — Claude should do this automatically when drafting/reviewing).
- Use `--clean` only for a quick "how bad is it" strip or when you'll hand-fix the result.

### Quick rewrite cheatsheet (keep meaning, drop the trigger)
| Avoid | Try instead |
|-------|-------------|
| Free / Free quote | "no-cost estimate", "see your rate" |
| Cash / Fast cash | "funds", "your money" (sparingly), reframe the benefit |
| Apply now / Act now / Order now | "see your options", "start when you're ready" |
| Guaranteed / Risk-free | "backed by", state the actual terms |
| Pre-approved | "you may qualify", "check eligibility" |
| Click here | "view your offer", a descriptive link |
| ALL CAPS / !!! / $$$ | normal sentence case, one or zero exclamation marks |

---

## Maintaining the blacklist

`blacklist.txt` is one term per line, lowercased. To add a word, append it and save (it's deduped automatically on load). Phrases are supported ("free money", "no credit check"). The symbols `!`, `$`, `$$$` are handled in the scanner, not the list.

This skill is the deliverability content gate referenced by `team-inboxing-mastery` (pillar 1) and `digital-marketing-pro` (email copy).
