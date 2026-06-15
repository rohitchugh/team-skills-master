# Deliverability Audit

Use when inbox placement, open rate, or delivery drops. Work the chain IN ORDER — do not jump to content first. Full reasoning in [references/01-inboxing-deliverability.md](../references/01-inboxing-deliverability.md).

```
Domain / sender under audit: ____________________   Date: __________
Symptom (be specific — which provider, how much, since when): ____________________
```

## 1. Authentication
```
□ SPF = pass        (MXToolbox / headers)
□ DKIM = pass
□ DMARC = pass + policy intact
→ Any fail? Recent DNS or ESP change? FIX before anything else.
Finding: ____________________
```

## 2. Blocklists
```
□ IP not listed (Spamhaus, Barracuda, SORBS via MXToolbox)
□ Domain not listed
→ If listed: identify cause (complaint spike / spam trap), fix, request delisting.
Finding: ____________________
```

## 3. Reputation
```
□ Google Postmaster: domain rep High/Medium?  spam rate spike?
□ IP reputation ok?
Finding: ____________________
```

## 4. List
```
□ Did we mail an aged/unverified segment recently?
□ Hit spam traps? (engaged-only would have prevented)
□ Engaged% trending down?
→ Re-segment to engaged, validate the list, sunset dead contacts.
Finding: ____________________
```

## 5. Content
```
□ New template/creative introduced near the drop?
□ Image-heavy / new trigger words / broken HTML?
□ Mail-Tester re-score > 9?
Finding: ____________________
```

## 6. Volume
```
□ Did volume spike without warmup ramp?
→ Step volume back down and re-ramp.
Finding: ____________________
```

## 7. Complaints
```
□ Complaint rate > 0.08%? Which segment/creative?
→ Pause that send; isolate the offender.
Finding: ____________________
```

## Verdict
```
Root cause: ____________________
Fix applied: ____________________
Re-test result (Mail-Tester / seed): ____________________
Monitor for: 5 days. Recheck date: __________
```
