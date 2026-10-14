# Controls

Part of the optional [SOX-style controls module](README.md). Each control
applies to a project's **financial-data scope**: the code, data and accounts
that create, change or display financial figures.

The control text is deliberately tool-neutral. Ways to meet each control with
common tools are listed under [Examples](#examples). Use whatever your setup
supports, and record what you actually did as the evidence.

## Access (AC)

| ID | Control | Evidence |
|---|---|---|
| AC-1 | **Least privilege.** Only the people, agents, keys and tokens that need access have it: write access to the code, and any access to the financial data or secrets. | The access list at the time of review |
| AC-2 | **Access review.** At each compliance review, list everything with access and remove what isn't needed. | The list, and what was removed |
| AC-3 | **Multi-factor sign-in** on your code host and on every account that touches financial data. | Account settings showing it's on |
| AC-4 | **No secrets in the code.** Passwords, keys and tokens live in a secrets store or the operating system's keychain, never in version control, and you check for them. If a secret ever reaches version control, revoke and replace it. Deleting the commit isn't enough. | Output of a secret scan covering the full history |
| AC-5 | **Financial data stays where it belongs.** Real financial data isn't committed, isn't used as test data (use made-up or anonymized data), isn't written to logs, and isn't sent to outside services, including AI tools, unless you've decided it may be. Stored financial data and its backups are encrypted. | Scan results, where fixtures came from, and storage and backup settings |

## Change management (CM)

| ID | Control | Evidence |
|---|---|---|
| CM-1 | **No direct changes to the main line of code.** Every change arrives through a reviewed change request (a pull request or merge request). | Your code host's protection settings. A local safeguard alone counts as **compensating**, not met |
| CM-2 | **Nobody approves their own change.** A reviewer other than the author approves each change. If you're the only human, an agent's recorded review is a compensating control (see [README](README.md#who-does-what)). | The approval on each change request |
| CM-3 | **Tested before merge.** Automated checks run on every change request and pass before it's merged. | The check results |
| CM-4 | **Traceable, never rewritten.** Each change says why it was made, and the main line's history is never force-overwritten or deleted. Rewriting history to remove leaked data is an emergency change (CM-5). | Change request descriptions; protection settings (a local safeguard alone is compensating) |
| CM-5 | **Emergency changes are rare and recorded.** CM-1 to CM-3 may be skipped only when the risk acceptor says so, and the change gets a normal review within a set number of days you choose (for example, 3 business days). | Emergency log entry |
| CM-6 | **New or upgraded dependencies are vetted.** They go through a dependency review and a check that the version is current and supported. | Review note on the change request |

## Operations (OP)

| ID | Control | Evidence |
|---|---|---|
| OP-1 | **Backups, with a tested restore,** for any stored financial data. | Record of the last restore test |
| OP-2 | **An incident log:** what broke, how it affected the figures, the fix, and any follow-up. | The log |
| OP-3 | **Scheduled jobs that touch financial data** (imports, syncs, recurring reports) keep run logs and fail loudly. | Run logs |

## Financial data integrity (FD)

| ID | Control | Evidence |
|---|---|---|
| FD-1 | **Known-answer tests** for every calculation that produces a financial figure (totals, balances, P&L, gains). | Test names |
| FD-2 | **Imports reconcile:** row counts and totals are checked against the source, duplicates are caught, and an import can be undone. | Tests, plus the behavior in the app |
| FD-3 | **No silent edits to history.** A change to a past financial record is recorded (what, when, why) instead of overwriting it. | The data design |

## Evidence (EV)

| ID | Control | Evidence |
|---|---|---|
| EV-1 | **Followable evidence.** Every control's evidence is linked from the project's compliance report, so someone else can check it without asking. | The report |

## Not included

These belong to a full SOX program. Add them if your situation calls for it:

- An annual management assessment and sign-off (the Section 302/404 equivalent)
- Seven-year evidence retention (modeled on the rule for auditors' workpapers)
- Access reviews on a fixed schedule (AC-2 runs at each compliance review instead)
- An outside auditor's attestation

## Examples

These are illustrations, not requirements. Check your tool's current
documentation, because plan limits and settings change.

**CM-1 / CM-4: protecting the main line**
- **Server-side:** branch protection or rulesets on GitHub, protected branches
  on GitLab, branch permissions on Bitbucket. Some hosts reserve these for
  paid plans on private repositories. Make sure the rule also applies to
  owners and administrators, or record that it doesn't.
- **Local fallback (git):** a `pre-push` hook that refuses pushes whose
  target is the main branch, and refuses deleting it. Keep the hook in the
  repository (for example `.githooks/`) and enable it per clone with
  `git config core.hooksPath .githooks`. A local hook can be bypassed
  (`--no-verify`, or by changing `core.hooksPath`). It guards against
  accidents, not against anyone (or any agent) that chooses to skip it, so
  record it as **compensating**. Review changes to `.githooks/` like any
  other code, and don't push from a branch you haven't reviewed: a branch
  can change the hook that runs on your next push.

**CM-2: recording review**
- A change request template with a sign-off table (reviewer, result, notes).
- A code-owners file, where your host supports one, so the right reviewer
  is requested automatically.

**CM-3: automated checks**
- A CI pipeline (GitHub Actions, GitLab CI, or any CI service) that runs
  your test and lint commands on every change request.
- Pin third-party CI steps to a full commit hash, not a version tag,
  because tags can be moved. Change pins only through a reviewed change
  request.
- Give CI jobs read-only permissions by default, and don't expose secrets
  to change requests from forks or outside contributors.

**AC-4: finding secrets**
- A secret scanner on your code host, or a pre-commit secret scan run
  locally.
- Scan the full history, not just the latest version.

**AC-5: keeping real financial data out**
- Use made-up or anonymized data for test fixtures, never real exports.
- Ignore rules help keep real exports out of version control, but they can
  be overridden and don't untrack files already committed, so the scan is
  the check. If you add exceptions for test fixtures, confirm they match the
  actual folder names.

**CM-1 to CM-3 with one human**
- Treat merging a change whose checks failed as a gap, even if your host
  allows it.
