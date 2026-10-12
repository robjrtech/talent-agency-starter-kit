# Skills Mapping

Maps Claude's available skills to the Talent Agency agent(s) whose job they support.
Skills change over time — treat this as a snapshot, not a guarantee every listed skill
is still loaded. See [Overview.md](Overview.md) for the department/agent structure.

## Finance and Accounting
| Agent | Skills that fit its job |
|---|---|
| **Bookkeeping Agent** | `xlsx` (categorizing/reconciling in spreadsheets), `pdf` (reading bank/statement PDFs) |
| **Reporting Agent** | `xlsx` (budget-vs-actual), `pdf`/`docx` (formatted P&L/cash-flow output), `dataviz` (charts in those reports) |
| **Invoicing Agent** | `pdf`/`docx` (invoice generation), `xlsx` (payment-status tracking) |
| **Financial Analyst** | `xlsx`, `dataviz`, `claude-api` (if modeling gets AI-assisted) |
| **Financial Risk Manager** | `xlsx` (exposure/stress-test models), `dataviz` (risk dashboards, drawdown charts), `pdf`/`docx` (risk reports) |
| **Finance Automation Agent** | `xlsx`, `pdf`/`docx` (running approved recurring tasks); runs under routines made with `schedule` or local `loop` timers armed by the Scheduling Agent |

## Information Technology
| Agent | Skills that fit its job |
|---|---|
| **Sysadmin Agent** | `update-config`, `keybindings-help`, `fewer-permission-prompts`, `init`, `setup-cowork`, partial `security-review` (secrets/env) |
| **Deployment Agent** | `run` (launch/verify a build), partial `security-review` (release readiness) |
| **Support/Triage Agent** | `code-review` (root-causing reported bugs), `run` (reproducing them) |
| **Python Engineer** | `code-review`, `simplify`, `claude-api` (if it's building AI-backed services) |
| **C++ Engineer** | `code-review`, `simplify` |
| **UX Agent** | `artifact-diagramming` (journey/flow diagrams); storyboards built in FigJam via the Figma connector |
| **UI Designer** | `design`, `dataviz`, `artifact-design`, `artifact-diagramming` |
| **UI Lead** | `design` (critique), `artifact-design` |
| **iOS Engineer** | `code-review`, `simplify`, `run` |
| **Web Engineer** | `code-review`, `simplify`, `run`, `artifact-design`, `artifact-diagramming`, `artifact-capabilities`, `claude-api` |
| **React Native Engineer** | `code-review`, `simplify`, `run` (launch/verify on simulators, emulators, web, desktop) |
| **Security Engineer** | `security-review` (primary owner), `code-review` (security-focused passes) |
| **QA Engineer** | `run` (launch/exercise the app), `code-review` (test-coverage angle) |
| **System Design Engineer** | `code-review` (architecture/dependency angle), `simplify` |
| **Content Integrity Agent** | none of the loaded skills map directly; runs as Claude Code hooks (`~/.claude/hooks/content_gate.py` + a Haiku agent hook), maintained via `update-config` |
| **IT Automation Agent** | none of the loaded skills map directly — runs read-only scans and checks via Bash; runs under routines made with `schedule` or local `loop` timers armed by the Scheduling Agent |

## Operations
| Agent | Skills that fit its job |
|---|---|
| **Scheduling Agent** | `anthropic-skills:schedule` / `schedule` (cron routines), `loop`, `anthropic-skills:morning` |
| **Process Agent** | `loop` (recurring workflows — secondary owner alongside Scheduling), `anthropic-skills:skill-creator` (turning an SOP into a repeatable skill) |
| **Vendor/Ops Agent** | none of the loaded skills fit — genuinely outside this skill set, not a gap |
| **Notion Agent** | none of the loaded skills map directly — works through the connected Notion MCP tools (search/fetch/create/update pages), not a packaged skill |
| **Operations Automation Agent** | none of the loaded skills map directly — reads calendars and Notion through tools and connectors; runs under routines made with `schedule` or local `loop` timers armed by the Scheduling Agent |

## Research and Development
| Agent | Skills that fit its job |
|---|---|
| **Research Agent** | none of the loaded skills map directly (leans on search/fetch tools, not a packaged skill) |
| **Prototyping Agent** | `pptx` (presenting POCs to stakeholders), `design`, `artifact-design`/`artifact-diagramming`/`artifact-capabilities`, `dataviz` |
| **Product Agent** | `docx`/`pptx` (specs, roadmap decks), `dataviz` (success metrics) |
| **Quantitative Researcher** | `xlsx`, `dataviz`, `claude-api` |
| **Research Automation Agent** | none of the loaded skills map directly (search/fetch tools for monitoring digests); runs under routines made with `schedule` or local `loop` timers armed by the Scheduling Agent |

## No natural owner
These are Claude/session-management skills, not business-domain work, so they don't
belong to any Talent Agency role: `anthropic-skills:consolidate-memory`,
`anthropic-skills:import-memory`, `anthropic-skills:explain-usage`.

`security-review` is owned by the **Security Engineer**. Sysadmin (secrets/env) and Deployment (release
readiness) keep partial use.

## Local Application Mapping (computer use)

Per [Overview.md](Overview.md#22)'s "Local application access" policy, agents may
drive a real local app via computer use instead of only writing a file — e.g. drafting
a report directly in a Text Editor. Governed by computer use's own rules: user approves
each app per session, apps are restricted to their tier (read/click/full), no clicking
raw links in native apps, no executing trades/payments/transfers on the user's behalf.

Update the **Result** column as agents actually use these so the mapping stays a record
of what worked, not just a plan — that's the "track outcomes" part of the policy.

| Agent | Task | Local app | Tier | Result (update as used) |
|---|---|---|---|---|
| Reporting Agent | P&L/cash-flow/budget write-ups | TextEdit or Pages | full | — |
| Financial Analyst | model/forecast narrative | Numbers or Excel | full | — |
| Financial Risk Manager | risk reports | Numbers/Excel + TextEdit | full | — |
| Invoicing Agent | invoice drafting | Pages or Word | full | — |
| Bookkeeping Agent | reconciliation review | Quicken/QuickBooks/Numbers — **read/categorize only, never initiates payments or transfers** | full | — |
| Product Agent | specs, roadmaps | TextEdit, Pages, or Notion desktop | full | — |
| Research Agent | research write-ups | TextEdit or Notes | full | — |
| Prototyping Agent | POC write-ups, mockup notes | TextEdit/Notes; Figma desktop for visual POCs | full | — |
| Quantitative Researcher | model/strategy write-ups | Numbers/Excel + TextEdit | full | — |
| Process Agent | SOP documentation | TextEdit or Notes | full | — |
| Scheduling Agent | calendar coordination | Calendar app | full | — |
| UI Designer | mockups, prototypes | Figma desktop | full | — |
| Sysadmin / Deployment / Security / QA / System Design Engineer | ops write-ups only | TextEdit for the report itself | full | — |
| Python / C++ / iOS / Web / React Native Engineer | n/a | Bash/Edit/Write tools already do this directly; Terminal and VS Code are **click-tier** under computer use (no typing), so computer use adds nothing here | click | — |
| Vendor/Ops Agent | none identified yet | — | — | — |

## Third-Party Integration Mapping (connectors)

Which agent uses which connected service for its task(s). Covers MCP connectors —
Notion, Gmail, Google Calendar, Google Drive, Figma, Vercel — as a connection snapshot,
not a guarantee every listed connector stays connected. Browser-based and native-desktop
access are already covered above (Local Application Mapping) and in Overview.md's
Local application access policy; this table is specifically about dedicated
service connectors.

**Governance, on top of what's in each row:**
- **Filing to Notion still goes through the Notion Agent.** Drafting a doc via Google
  Drive, or a spec via some other connector, doesn't bypass the Notion publishing gate —
  it still has to be reviewed and approved before it's filed as a project.
- **Sending/creating/deploying is a visible or hard-to-reverse action.** Emails (Gmail),
  calendar invites (Google Calendar), and deployments (Vercel) reach other people or
  shared state — confirm with the user before sending/creating/deploying, same as any
  other action of that kind.
- **claude.ai PDF Viewer is connected but not authorized** — unusable by any agent until
  the user authorizes it via claude.ai connector settings.

| Agent | Connector(s) | Task |
|---|---|---|
| Bookkeeping Agent | Google Drive | reading bank/receipt files already stored in Drive |
| Reporting Agent | Google Drive, Gmail | storing finished reports; sending them to stakeholders (confirm before sending) |
| Invoicing Agent | Gmail, Google Drive | sending invoices (confirm before sending); storing copies |
| Financial Analyst | Google Drive | model/forecast working files |
| Financial Risk Manager | Google Drive | risk-report working files |
| Sysadmin Agent | none of the connected services fit — genuinely local/infra work, not a gap | |
| Deployment Agent | Vercel | deployments, projects, env vars, domains, logs — primary owner |
| Support/Triage Agent | Gmail — weak fit | only if a bug report actually arrives by email |
| Python / C++ / iOS / React Native Engineer | none — code lives locally, no connector involved | |
| UX Agent | Figma (FigJam) | building the problem/solution storyboard |
| UI Designer | Figma | design context, screenshots, generating/syncing designs, Code Connect |
| UI Lead | Figma — read only | screenshots and design context of variations under review |
| Web Engineer | Figma, Vercel | implementing designs from Figma; deploying the web app |
| Security Engineer | Vercel — partial | reviewing env var/secrets exposure and firewall config as part of security review |
| QA Engineer | Vercel — partial | checking deployment logs/runtime errors as part of release validation |
| System Design Engineer | none directly | |
| Content Integrity Agent | all read-type connectors (Gmail, Drive, Notion, Calendar, Figma, Vercel, Claude Docs) + WebFetch/WebSearch/browser reads | screens their output via hooks; never writes or sends through any connector |
| Scheduling Agent | Google Calendar | primary owner — coordinating calendars, deadlines, invites |
| Process Agent | Google Drive | drafting SOPs before they're filed through the Notion Agent |
| Vendor/Ops Agent | Gmail, Google Calendar | vendor communication (confirm before sending); coordination meetings |
| Notion Agent | Notion | primary and only owner of direct publishing — see Overview.md's Notion publishing gate |
| Research Agent | Google Drive | storing source material and notes |
| Prototyping Agent | Figma, Vercel | mockups; deploying POC builds for review |
| Product Agent | Google Drive | drafting specs/roadmaps before they're filed through the Notion Agent |
| Quantitative Researcher | Google Drive | model/data working files |
