# Compliance Review — <YYYY-MM-DD> — <project or vendor name>

**Trigger:** <project ship / vendor onboarding>
**Reviewed by:** <Security Engineer / Vendor/Ops Agent>

## Frameworks identified as applicable

- <framework, e.g. "GDPR"> — <why it applies: data/jurisdiction involved>
- <framework, e.g. "SOC 2"> — <why it applies>
- ... or: "none identified — no personal data, no third-party data access, no
  applicable jurisdiction"

## Controls checked

| Framework | Control | Status | Notes |
|-----------|---------|--------|-------|
| | | met / gap | |

## OWASP Top 10 (2025)

See [OWASP Top 10.md](OWASP%20Top%2010.md). Every row is filled in; N/A needs a reason.

| # | Category | Status | Notes |
|---|----------|--------|-------|
| A01 | Broken Access Control (incl. SSRF) | pass / gap / N/A | |
| A02 | Security Misconfiguration | | |
| A03 | Software Supply Chain Failures | | |
| A04 | Cryptographic Failures | | |
| A05 | Injection | | |
| A06 | Insecure Design | | |
| A07 | Authentication Failures | | |
| A08 | Software or Data Integrity Failures | | |
| A09 | Security Logging & Alerting Failures | | |
| A10 | Mishandling of Exceptional Conditions | | |

## Gaps found and resolution

- <gap> → <fix applied, or "open — tracked for next review">

## Vendor-specific (if applicable)

**Vendor:** <name>
**Data shared/accessed:** <what, specifically>
**Agreement in place:** <data-sharing/processing agreement — yes/no, link or location>
**Attestation reviewed:** <vendor's own SOC 2 report or equivalent — yes/no, date>
**OWASP Top 10 evidence:** <pentest report or attestation covering the OWASP Top 10 — yes/no, date; if no, flagged to Security Engineer and user>


## SOPs needed or updated

<any procedure the Process Agent needs to document or revise as a result, or "none">

## Next review

**Scheduled for:** <date, or "next project ship" / "vendor renewal date">
