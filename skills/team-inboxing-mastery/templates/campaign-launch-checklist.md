# Campaign Launch Checklist

Copy this per send. Do not skip a box. Hard stops are marked ⛔.

## Pre-build
```
□ List segment defined (who + why this audience)
□ Suppressions applied: unsubscribes, hard bounces, prior complainers
□ List validated if new/aged (ZeroBounce/NeverBounce/Kickbox)
□ Engaged-only for a warming sender? (send to openers first)
```

## Authentication & sender ⛔
```
□ SPF = pass, DKIM = pass, DMARC = pass (check headers / MXToolbox)
□ Sending domain/IP warmed (not cold) — see warmup ramp if new
□ One-click List-Unsubscribe header present
□ Sender name + from-address consistent with prior sends
```

## Content
```
□ Subject line A/B set up (2 variants, one variable)
□ Text-to-image balance ok (~60% text, not all-image)
□ content-guard PASS on subject + from + body (no blacklisted words, !!!, $$$, CAPS)
□ Unsubscribe link works + physical address present (CAN-SPAM)
□ All links tested, visible text matches destination
□ Renders ok: mobile + desktop, light + dark
□ Compliance reviewed (invoke compliance-legal-shield for finance/health copy)
```

## Test gate ⛔
```
□ Mail-Tester.com score > 9/10  (if < 9, fix and re-test, do NOT send)
□ Seed list: lands in Primary/Inbox, not Promotions/Spam
□ Test send to internal team — confirm inbox, links, render
```

## Send
```
□ Window: Tue–Thu, 9–11am or 6–8pm (recipient local) unless test says otherwise
□ Throttle/ramp set if warming
□ Schedule confirmed
```

## First-hour monitor ⛔
```
□ Open rate tracking as expected
□ Complaint rate < 0.08%  (if >, PAUSE immediately)
□ Bounce rate < 2%
□ No spike in unsubscribes
□ Log results in the performance tracker
```
