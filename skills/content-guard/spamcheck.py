#!/usr/bin/env python3
"""
content-guard / spamcheck — scan email content (subject, from, body/HTML) for
blacklisted spam-trigger words and optionally strip them.

Usage:
  python spamcheck.py body.html
  python spamcheck.py --subject "Fast cash today!" --from "Deals Team" body.html
  echo "<p>Get your free cash now!</p>" | python spamcheck.py
  python spamcheck.py --clean body.html -o body.cleaned.html
  python spamcheck.py --json body.html

Exit code: 0 = clean (PASS), 1 = blacklisted terms found (FAIL).
Matching is whole-word, case-insensitive, phrase-aware, apostrophe-insensitive.
HTML tags are skipped (only visible text is checked / cleaned).
"""
import argparse, json, re, sys
from pathlib import Path

BLACKLIST_FILE = Path(__file__).with_name("blacklist.txt")


def load_terms():
    terms = []
    for line in BLACKLIST_FILE.read_text(encoding="utf-8").splitlines():
        t = line.strip().replace("’", "'").replace("‘", "'")
        if t:
            terms.append(t.lower())
    # longest first so phrases match before their component words
    return sorted(set(terms), key=lambda s: (-len(s), s))


def build_pattern(terms):
    parts = []
    for t in terms:
        esc = re.escape(t).replace(r"\ ", r"\s+")          # allow flexible whitespace in phrases
        left = r"(?<![A-Za-z0-9])" if t[0].isalnum() else ""
        right = r"(?![A-Za-z0-9])" if t[-1].isalnum() else ""
        parts.append(left + esc + right)
    return re.compile("(" + "|".join(parts) + ")", re.IGNORECASE)


# split into (text, tag, text, tag, ...) so we never touch HTML tags
TAG_SPLIT = re.compile(r"(<[^>]+>)")


def norm(s):
    return s.replace("’", "'").replace("‘", "'")


def scan_text(text, pat):
    """Return dict {term_lower: count} of matches in plain text."""
    found = {}
    for m in pat.finditer(norm(text)):
        key = re.sub(r"\s+", " ", m.group(0)).strip().lower()
        found[key] = found.get(key, 0) + 1
    return found


def scan_field(content, pat, is_html):
    if not content:
        return {}
    if not is_html:
        return scan_text(content, pat)
    found = {}
    for seg in TAG_SPLIT.split(content):
        if seg.startswith("<") and seg.endswith(">"):
            continue
        for k, v in scan_text(seg, pat).items():
            found[k] = found.get(k, 0) + v
    return found


def clean_text(text, pat):
    cleaned = pat.sub("", norm(text))
    cleaned = re.sub(r"[ \t]{2,}", " ", cleaned)
    cleaned = re.sub(r"\s+([,.!?;:])", r"\1", cleaned)
    return cleaned


def clean_field(content, pat, is_html):
    if not is_html:
        return clean_text(content, pat)
    out = []
    for seg in TAG_SPLIT.split(content):
        out.append(seg if (seg.startswith("<") and seg.endswith(">")) else clean_text(seg, pat))
    return "".join(out)


def symbol_flags(*texts):
    blob = " ".join(t for t in texts if t)
    flags = {}
    ex = blob.count("!")
    if ex:
        flags["exclamation marks (!)"] = ex
    dollars = blob.count("$")
    if dollars:
        flags["dollar signs ($)"] = dollars
    caps = re.findall(r"\b[A-Z]{4,}\b", blob)
    if caps:
        flags["ALL-CAPS words"] = len(caps)
    return flags


def merge(a, b):
    out = dict(a)
    for k, v in b.items():
        out[k] = out.get(k, 0) + v
    return out


def main():
    ap = argparse.ArgumentParser(description="Scan/clean email content against the spam-word blacklist.")
    ap.add_argument("file", nargs="?", help="content file (html or txt). Omit to read body from stdin.")
    ap.add_argument("--subject", default="")
    ap.add_argument("--from", dest="frm", default="")
    ap.add_argument("--html", action="store_true", help="force HTML mode (auto-detected for .html/.htm)")
    ap.add_argument("--clean", action="store_true", help="output a cleaned copy with flagged words removed")
    ap.add_argument("-o", "--out", help="write cleaned content here (with --clean)")
    ap.add_argument("--json", action="store_true", help="machine-readable output")
    args = ap.parse_args()

    if args.file and args.file != "-":
        body = Path(args.file).read_text(encoding="utf-8")
        is_html = args.html or args.file.lower().endswith((".html", ".htm"))
    else:
        body = sys.stdin.read()
        is_html = args.html

    terms = load_terms()
    pat = build_pattern(terms)

    per_field = {
        "subject": scan_field(args.subject, pat, False),
        "from": scan_field(args.frm, pat, False),
        "body": scan_field(body, pat, is_html),
    }
    all_terms = {}
    for d in per_field.values():
        all_terms = merge(all_terms, d)
    syms = symbol_flags(args.subject, args.frm, body)

    total_hits = sum(all_terms.values()) + sum(syms.values())
    distinct = len(all_terms) + len(syms)
    level = "PASS" if distinct == 0 else ("LOW" if distinct <= 3 else ("MEDIUM" if distinct <= 8 else "HIGH"))

    if args.clean:
        cleaned = clean_field(body, pat, is_html)
        if args.out:
            Path(args.out).write_text(cleaned, encoding="utf-8")
            sys.stderr.write(f"Cleaned content written to {args.out}\n")
        else:
            sys.stdout.write(cleaned)
        removed = sorted(all_terms.items(), key=lambda x: -x[1])
        sys.stderr.write("\nRemoved terms: " + (", ".join(f"{t}({c})" for t, c in removed) or "none") + "\n")
        if syms:
            sys.stderr.write("Note: symbols still present (not auto-removed): "
                             + ", ".join(f"{k}:{v}" for k, v in syms.items()) + "\n")
        return 1 if distinct else 0

    if args.json:
        print(json.dumps({
            "level": level, "distinct_flags": distinct, "total_hits": total_hits,
            "by_field": per_field, "symbols": syms,
        }, indent=2))
        return 1 if distinct else 0

    # human-readable report
    print("=" * 56)
    print(f" CONTENT GUARD - spam-word scan   RESULT: {level}")
    print("=" * 56)
    if distinct == 0 and not syms:
        print("Clean. No blacklisted words or risky symbols found.")
        return 0
    for field in ("subject", "from", "body"):
        d = per_field[field]
        if d:
            print(f"\n[{field}] {sum(d.values())} hit(s):")
            for t, c in sorted(d.items(), key=lambda x: -x[1]):
                print(f"    - {t}  x{c}")
    if syms:
        print("\n[symbols / style]")
        for k, v in syms.items():
            print(f"    - {k}: {v}")
    print(f"\nTotal: {distinct} distinct flag(s), {total_hits} occurrence(s).")
    print("Fix: rewrite or remove flagged words, then re-check. Auto-strip with --clean.")
    return 1


if __name__ == "__main__":
    sys.exit(main())
