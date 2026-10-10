# OWASP Top 10 (2025 edition)

The agency's application-security baseline. Every security review, quarterly
audit, and compliance report checks the project against all 10 categories.
This file is the single source of truth. Other files link here instead of
copying the list.

**Edition:** OWASP Top 10:2025 (replaces 2021). Verified current on 2026-10-04.
The System Design Engineer's quarterly currency audit checks for a newer edition.
Source: https://owasp.org/Top10/2025/

## The 10 categories

| # | Category | What it means |
|---|----------|---------------|
| A01 | **Broken Access Control** | Users act outside their intended permissions, letting attackers reach other accounts or sensitive files. Now also covers **Server-Side Request Forgery (SSRF)**: tricking the app into fetching a remote resource or reaching internal systems without authorization. |
| A02 | **Security Misconfiguration** | Insecure default settings, open cloud storage, or overly verbose error messages that leak system info. |
| A03 | **Software Supply Chain Failures** | Third-party software, libraries, or frameworks with known unpatched flaws, plus compromise anywhere in the chain that builds and delivers the software: malicious or hijacked packages, untrusted registries, tampered build tools. |
| A04 | **Cryptographic Failures** | Poor or missing encryption exposes sensitive data like passwords and financial records in transit or at rest. |
| A05 | **Injection** | Untrusted user input goes directly to an interpreter (SQL, NoSQL, OS commands) and executes malicious code. |
| A06 | **Insecure Design** | Flaws in the architecture or design phase that a simple patch can't fix. Needs proper threat modeling. |
| A07 | **Authentication Failures** | Weak login flows or poor session management that let attackers steal passwords or hijack active sessions. |
| A08 | **Software or Data Integrity Failures** | Insecure updates, plugins, or CI/CD pipelines that allow untrusted code to run, or unverified data deserialization. |
| A09 | **Security Logging & Alerting Failures** | Too little logging, or no alerts on what's logged, so teams don't notice or respond to active breaches. |
| A10 | **Mishandling of Exceptional Conditions** | Errors and unexpected states handled badly: failing open instead of closed, leaking details in error messages, or leaving the app in an unsafe state after a crash or timeout. |

## Changes from the 2021 list

| 2021 name | 2025 |
|-----------|------|
| Server-Side Request Forgery (SSRF) | Merged into A01 Broken Access Control |
| Vulnerable and Outdated Components | Expanded into A03 Software Supply Chain Failures |
| Identification and Authentication Failures | Renamed A07 Authentication Failures |
| Security Logging and Monitoring Failures | Renamed A09 Security Logging & Alerting Failures |
| none | New: A10 Mishandling of Exceptional Conditions |

## How it's used

- **Security Engineer:** checks all 10 in the pre-ship security review and the
  quarterly audit, and records the results in the compliance report's OWASP table.
- **Vendor/Ops Agent:** during vendor vetting, asks for evidence the vendor
  tests against the OWASP Top 10, such as a recent penetration test report.
- A category that doesn't apply (for example, A05 for an app with no
  interpreter input) is marked **N/A with a reason**, never just skipped.
