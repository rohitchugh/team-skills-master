# Pillar 1 — Content Inboxing (Email Deliverability)

The whole job in one sentence: **get a compliant message that the recipient wants, from a trusted sender, into the inbox, and prove it.** Everything below is how.

The mental model: inbox placement is decided by a chain. If any link is weak, you land in spam. Work the chain in order — never jump to "rewrite the subject line" before authentication and reputation are solid.

```
Authentication  →  Sender reputation  →  List quality  →  Content hygiene  →  Engagement  →  Inbox
   (who you are)    (your track record)   (who you send to)  (what's inside)    (do they care)
```

---

## 1. Authentication — prove who you are

Mailbox providers (Gmail, Yahoo, Outlook) reject or downrank anything they cannot verify. Three records, all required:

| Record | What it proves | Set where | How to check |
|--------|----------------|-----------|--------------|
| **SPF** | This server is allowed to send for the domain | DNS TXT record | `nslookup -type=txt yourdomain.com`, or MXToolbox SPF check |
| **DKIM** | The message was not tampered with; signed by the domain | DNS + ESP signing key | MXToolbox DKIM check; look for `dkim=pass` in headers |
| **DMARC** | Tells receivers what to do if SPF/DKIM fail, and where to send reports | DNS TXT at `_dmarc.yourdomain.com` | MXToolbox DMARC; start at `p=none`, move to `quarantine`, then `reject` |

**2024+ Gmail/Yahoo bulk-sender rules (memorize):** if you send to Gmail/Yahoo at volume you MUST have SPF + DKIM + DMARC, a one-click unsubscribe (List-Unsubscribe header), and keep spam complaints **under 0.3%** (we hold ourselves to 0.08%). Failing these = throttling or blocking.

How to verify on any message: open the raw headers and confirm three lines say `spf=pass`, `dkim=pass`, `dmarc=pass`. If any says `fail` or `none`, stop and fix DNS before sending.

---

## 2. Sender reputation — your track record

Providers score your **sending IP** and your **sending domain** separately. Both must be warm and clean.

### IP / domain warmup (new sender or new domain)
Never blast a cold IP/domain — you will be flagged as a spammer instantly. Ramp volume gradually so providers build trust:

```
Day 1-2:    50 emails/day to your most engaged contacts
Day 3-4:    100/day
Day 5-7:    500/day
Week 2:     1,000 → 2,500/day
Week 3:     5,000 → 10,000/day
Week 4+:    scale to target, watch complaint + bounce rates at each step
```
Rule: only increase volume if the prior step kept complaints < 0.08% and bounces < 2%. If a step goes red, hold or step back.

### Monitor reputation
- **Google Postmaster Tools** — domain/IP reputation, spam rate, auth results for Gmail. Set this up for every sending domain.
- **Blocklists** — check the sending IP/domain against Spamhaus, Barracuda, SORBS via MXToolbox Blacklist Check. If listed, identify why (usually a complaint spike or a spam trap hit), fix it, then request delisting.
- **Spam traps** — addresses that should never receive mail. Hitting them tanks reputation. You hit them by sending to old/scraped/never-engaged addresses → this is why list hygiene (below) matters.

---

## 3. List quality — who you send to

Reputation is mostly a function of *who you send to and whether they engage*. A clean, engaged list is the single biggest deliverability lever.

**Always suppress before every send:**
- Unsubscribes (legally required — CAN-SPAM)
- Hard bounces (invalid addresses)
- Prior spam complainers
- Role addresses if quality is a concern (info@, admin@, sales@)

**Re-engagement / sunsetting:** contacts who have not opened in 90+ days drag down engagement signals. Segment them out of the main send, run a re-engagement sequence, and sunset (stop mailing) the ones who still do not respond. A smaller engaged list outperforms a big dead one.

**List validation:** before mailing a new or aged list, run it through a verification service (e.g. ZeroBounce, NeverBounce, Kickbox) to strip invalids and traps. Mailing an unverified aged list is the fastest way to a blocklist.

See [references/03-sheets-analytics.md](03-sheets-analytics.md) for the **list-health** tracking sheet (decay rate, engaged %, churn).

---

## 4. Content hygiene — what's inside

Once auth + reputation + list are solid, content is the tiebreaker. Spam filters score the message.

**Do:**
- Balanced text-to-image ratio (do not send an all-image email; filters cannot read it and treat it as suspicious). Aim ~60% text.
- Real, working unsubscribe link + physical mailing address (CAN-SPAM requires both).
- One-click `List-Unsubscribe` header (Gmail/Yahoo requirement).
- Consistent "from" name and address.
- Plain, human subject lines. A/B test them ([sheets ref](03-sheets-analytics.md) for significance).
- Test rendering on mobile + desktop, light + dark mode.

**Avoid (spam triggers):**
- ALL CAPS, excessive `!!!`, `$$$`, "FREE", "ACT NOW", "guaranteed", "risk-free", "100%".
- URL shorteners (bit.ly etc.) and link mismatches (visible text ≠ destination).
- Attachments in cold mail.
- Spammy/unbalanced HTML, broken tags, tiny hidden text, single giant image.
- Brand-new "from" domain that is not warmed up.

**Pre-send content test (every campaign):**
- Send to **Mail-Tester.com** → must score **> 9/10**. It catches auth, blocklist, content, and broken-HTML issues in one shot.
- Send to a **seed list** (a spread of Gmail/Yahoo/Outlook test inboxes) → confirm it lands in **Primary/Inbox**, not Promotions or Spam. Tools like GlockApps automate seed inbox-placement testing across providers.

---

## 5. Engagement — do they care

Providers watch what recipients do: opens, replies, "move to inbox", "not spam" all build reputation; deletes-without-open, "mark as spam", and ignores erode it.

Levers to raise engagement (and therefore placement):
- Send to engaged segments first; let early positive signals lift the rest of the send.
- Best windows for our audience: **Tue–Thu, 9–11am or 6–8pm** (recipient local time). Test and confirm per list.
- Relevance > frequency. Over-mailing a tired list raises complaints and deletes.
- Prompt a reply early in a sequence (replies are a strong positive signal).

---

## 6. The deliverability drop playbook (when placement falls)

Work it in chain order; do not guess.

```
1. AUTH      — did SPF/DKIM/DMARC break? (DNS change, ESP switch) → check headers
2. BLOCKLIST — newly listed? → MXToolbox blacklist check → fix cause, request delisting
3. REPUTATION— Postmaster Tools: did spam rate spike? IP/domain rep drop?
4. LIST      — did we mail an aged/unverified segment or hit traps? → verify + re-segment
5. CONTENT   — new template? image-heavy? new trigger words? → Mail-Tester re-score
6. VOLUME    — did we spike volume without warmup? → step back down, re-ramp
7. COMPLAINTS— complaint rate > 0.08%? → pause, find the offending segment/creative
```

Full step-by-step with the checklist is in [templates/deliverability-audit.md](../templates/deliverability-audit.md).

---

## Tools cheat sheet

| Job | Tool |
|-----|------|
| Check SPF/DKIM/DMARC + blocklists | MXToolbox |
| Gmail reputation + spam rate | Google Postmaster Tools |
| One-shot content/auth score | Mail-Tester.com |
| Inbox placement across providers | GlockApps / seed list |
| List validation | ZeroBounce / NeverBounce / Kickbox |
| Read campaign metrics / find drops | invoke `email-data-analyst` |
| Compliance check on copy | invoke `compliance-legal-shield` |
