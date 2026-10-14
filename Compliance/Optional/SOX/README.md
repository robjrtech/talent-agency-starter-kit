# SOX-style controls (optional module)

An **opt-in** set of controls for projects that handle financial data:
balances, transactions, invoices, holdings, payroll, anything a money
decision rests on. If your projects don't touch financial data, you can skip
this folder.

It is modeled on the IT controls that auditors test under the US
Sarbanes-Oxley Act (SOX). It works with any AI tool, any agents and any code
host.

## Read this first: it is not legal SOX compliance

Most of SOX, including Sections 302 and 404, applies to public companies
(companies that file reports with the SEC) and to the firms that audit them.
A few provisions apply to everyone, such as the crime of destroying or
altering records to obstruct a federal investigation (Section 802).

Using this module does **not** make anything "SOX compliant," and no report
should say so. The accurate wording is *"meets our voluntary SOX-style
control baseline."* Use that wording only in your own internal reports. Don't
describe your controls as "SOX" to customers, investors or lenders.

Stop and talk to a qualified auditor or lawyer, rather than relying on this
module, if:
- you work for, or handle financial data on behalf of, a public company, or
- a customer asks you for SOX or SOC 1 assurance.

## What's in this folder

| File | What it is |
|---|---|
| [Controls.md](Controls.md) | The 18 controls, what each one asks for, and examples of how to meet them with common tools |
| [Report table.md](Report%20table.md) | A table to paste into a compliance report and fill in |
| `README.md` | This page: what SOX is, how to turn the module on, and who does what |

## What SOX requires, briefly

The Sarbanes-Oxley Act of 2002 was passed after the Enron and WorldCom
accounting frauds. The parts people mean when they say "SOX":

- **Section 302:** the CEO and CFO personally certify each annual and
  quarterly report, and confirm they are responsible for internal controls.
- **Section 404:** management assesses its internal control over financial
  reporting every year. For larger companies, an outside auditor also
  checks that assessment.
- **Section 802:** destroying or altering records to obstruct an
  investigation is a crime.
- **The PCAOB:** the act created this board, which sets the standards
  auditors use (the main one for internal control is AS 2201).

Part of how auditors check whether the numbers can be trusted is by testing
the **IT general controls** around the systems that produce them. The
standard areas are access to programs and data, program changes, program
development, and computer operations. This module adapts access, changes and
operations for a small team of AI agents and a person directing them. It
adds two groups of its own: financial data integrity, and evidence someone
else can follow.

**Last checked:** 2026-10-14. Amendments to AS 2201 tied to the PCAOB's new
quality control standard (QC 1000) take effect December 15, 2026. They
concern audit firms' own quality control, not the controls in this module.
Re-check the current status before relying on any date here.

## Turning it on

1. **Decide the scope.** For each project, write down which code, data and
   accounts create, change or display financial figures. If none do, the
   module doesn't apply to that project.
2. **Assign the responsibilities** below to agents you have, and write the
   names into the table.
3. **Fill in the [report table](Report%20table.md)** as part of your normal
   pre-ship review. Mark every control met, gap, compensating or N/A, and
   give a reason for each.
4. **Choose your gap rule.** We suggest that an open gap blocks shipping
   unless the risk acceptor accepts it in writing.
5. **Optional:** add a line to your `Overview.md` standing policies so
   agents apply this automatically. For example: *"Projects with a
   financial-data scope also complete `Compliance/Optional/SOX/`."*

## Who does what

The module doesn't create a new agent. Assign each responsibility to any
agent you already have. One agent can hold several, with one exception: the
**change reviewer** must never be the author of the change it reviews.

| Responsibility | What it involves | Assigned to |
|---|---|---|
| **Scope owner** | Decides whether a project has a financial-data scope, assembles the report (EV-1) | |
| **Access reviewer** | Lists who and what can reach the code, data and secrets, removes anything unused, and checks where financial data goes (AC-1 to AC-5) | |
| **Change reviewer** | Reviews and approves changes, including new or upgraded dependencies. Never the author (CM-1 to CM-4, CM-6) | |
| **Tester** | Runs the tests before merge, and checks financial figures and imports against known answers (CM-3, FD-1 to FD-3) | |
| **Operations owner** | Keeps backups with tested restores, and run logs for scheduled jobs (OP-1, OP-3) | |
| **Procedure writer** | Writes the emergency-change and incident procedures (CM-5, OP-2) | |
| **Risk acceptor** | Accepts or rejects open gaps in writing. This should be a person, not an agent | |

**If you're the only human:** true separation of duties isn't possible,
because you direct the agents that write and review the code. You can
record an agent's independent review as a **compensating control** instead,
and say so in the report. To keep that review meaningful, run the reviewing
agent in a fresh session that doesn't share the author's conversation. The
person still makes the merge decision.

## Sources

- [Sarbanes-Oxley Act of 2002, Pub. L. 107-204](https://www.govinfo.gov/content/pkg/PLAW-107publ204/html/PLAW-107publ204.htm)
- [PCAOB AS 2201](https://pcaobus.org/oversight/standards/auditing-standards/details/AS2201)
- [SEC Release 34-103803: QC 1000 and related amendments, effective date](https://www.sec.gov/files/rules/pcaob/2025/34-103803.pdf)
- [PCAOB: postponement of QC 1000's effective date](https://pcaobus.org/news-events/news-releases/news-release-detail/pcaob-postpones-effective-date-of-qc-1000-and-related-standards--rules--and-forms)
