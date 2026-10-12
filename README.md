# Talent Agency Starter Kit

A ready-made team of AI agents for [Claude Code](https://docs.claude.com/en/docs/claude-code/setup),
organized like a small company. Each agent has a job description: what it
does, what it owns, and which model and effort level it runs at. A shared
rulebook covers how work gets planned, built, reviewed and shipped.

You describe what you want in plain English. Claude picks the right agent, or
you can ask for one by name, such as `security-engineer` or `research-agent`.

Everything is plain Markdown plus a few small Python scripts. No server, no
accounts and no data leaves your machine beyond your normal Claude Code use.

> **New to this?** Read [START HERE.md](START%20HERE.md). It walks through
> setup from zero, no AI experience needed.

## What's inside

| Path | What it is |
|---|---|
| [Overview.md](Overview.md) | The rulebook: departments, agents and standing policies (security review, architecture gate, QA sign-off, and more) |
| [Routing.md](Routing.md) | Which model tier (Haiku / Sonnet / Opus) and effort each agent uses, and why |
| [Skills Mapping.md](Skills%20Mapping.md) | Which Claude Code skills and connectors each agent uses |
| [Agent Definitions/](Agent%20Definitions/) | `generate.py` turns the role files into Claude Code subagents |
| `Finance and Accounting/`, `Information Technology/`, `Operations/`, `Research and Development/` | One Markdown job description per agent |
| [Compliance/](Compliance/) | Review checklists, starting with the OWASP Top 10 (2025) |
| [Recurring Tasks/](Recurring%20Tasks/) | Repetitive tasks each department's automation agent runs on a schedule, once you approve them |
| `Currency Audits/`, `Scientific Method/`, `Self-Improvement/`, `Session Heartbeats/` | Templates the agents fill in as they work |

## The team

- **Finance and Accounting:** Bookkeeping Agent, Finance Automation Agent, Financial Analyst, Financial Risk Manager, Invoicing Agent, Reporting Agent
- **Information Technology:** C++ Engineer, Content Integrity Agent, Deployment Agent, iOS Engineer, IT Automation Agent, Python Engineer, QA Engineer, React Native Engineer, Security Engineer, Support-Triage Agent, Sysadmin Agent, System Design Engineer, UI Designer, UI Lead, UX Agent, Web Engineer
- **Operations:** Notion Agent, Operations Automation Agent, Process Agent, Scheduling Agent, Vendor-Ops Agent
- **Research and Development:** Product Agent, Prototyping Agent, Quantitative Researcher, Research Agent, Research Automation Agent

Each department's **automation agent** runs that department's repetitive tasks
(scans, digests, checklists, recurring reports) on a schedule, either as a
cloud routine or inside an open Claude Code session. You approve each task
once. Anything that sends, pays, deploys or deletes still asks you every time.

## Quick start

Requirements: a paid Claude plan (Pro or Max), Claude Code, and Python 3.

```bash
git clone https://github.com/robjrtech/talent-agency-starter-kit.git "Talent Agency"
cd "Talent Agency"
python3 "Agent Definitions/generate.py"   # installs the agents into ~/.claude/agents/
```

Then restart Claude Code so it loads the new agents, and create a `Projects/`
folder next to this one for your actual work. Try:

> *"Read Overview.md and explain in simple terms what this team can do for me."*

## How it works

- **Role files are the source of truth.** Edit a job description or
  `Routing.md`, rerun `generate.py`, and restart Claude Code.
- **Agents route by the cost of a mistake, not the size of the task.**
  Planning runs on the strongest model. Execution runs at each agent's own
  tier. After one failure, the agent moves up a tier instead of retrying at
  the same level.
- **Gates before shipping.** The System Design Engineer reviews architecture
  before building starts. The QA Engineer tests real behavior. The Security
  Engineer signs off against the OWASP Top 10 before anything ships.
- **Subagents are used sparingly:** at most 3–4 at a time across all
  sessions, coordinated through `Session Heartbeats/`.

## Optional pieces

- **Notion publishing.** The rules file finished work in Notion. Replace
  `<your Notion page URL>` in `Overview.md` and `Operations/Notion Agent.md`
  with your own page, or tell Claude to skip that step.
- **Content Gate** (`Information Technology/Content Gate/`). This is a
  macOS-only defense against prompt injection from web pages and connectors.
  It installs system-wide Claude Code hooks and needs `sudo`. Read
  [Content Integrity Agent.md](Information%20Technology/Content%20Integrity%20Agent.md)
  before installing it.

## Make it yours

`Overview.md` is meant to be edited. Add departments, rewrite policies, or
remove anything that doesn't fit how you work. Claude can make the changes
for you.

## A word of caution

AI agents make mistakes. Read permission prompts before approving them, never
paste passwords or private keys into a chat, and double-check anything
involving money, legal matters or security.
