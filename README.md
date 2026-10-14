# Talent Agency Starter Kit

A ready-made team of AI agents, organized like a small company, that works
with the AI coding tool you already use: **Claude Code, OpenAI Codex,
Cursor, Gemini CLI or GitHub Copilot**, and any other tool that reads
[`AGENTS.md`](AGENTS.md).

Each agent has a job description: what it does, what it owns, and how
carefully it should work (a Fast, Standard or Deep tier plus an effort
level). A shared rulebook covers how work gets planned, built, reviewed and
shipped.

You describe what you want in plain English. Your AI picks the right agent,
or you ask for one by name, such as `security-engineer` or `research-agent`.

Everything is plain Markdown plus a few small Python scripts. No server and
no accounts. Nothing leaves your machine beyond your normal use of your AI
tool.

> **New to this?** Read [START HERE.md](START%20HERE.md). It walks through
> setup from zero, no AI experience needed.

## What's inside

| Path | What it is |
|---|---|
| [AGENTS.md](AGENTS.md) | The entry point every AI tool reads: how to route work and the rules that always apply |
| [Overview.md](Overview.md) | The rulebook: departments, agents and standing policies (security review, architecture gate, QA sign-off, and more) |
| [Routing.md](Routing.md) | Which tier (Fast / Standard / Deep) and effort each agent uses, and why |
| [Agent Definitions/](Agent%20Definitions/) | `generate.py` turns the role files into native agents for each tool; `models.json` picks each tool's model per tier |
| [Adapters/](Adapters/) | Per-tool setup notes and tool-only features (e.g. the Claude Code Content Gate) |
| `Finance and Accounting/`, `Information Technology/`, `Operations/`, `Research and Development/` | One Markdown job description per agent |
| [Compliance/](Compliance/) | Review checklists, starting with the OWASP Top 10 (2025) |
| [Recurring Tasks/](Recurring%20Tasks/) | Repetitive tasks each department's automation agent runs on a schedule, once you approve them |
| `Currency Audits/`, `Scientific Method/`, `Self-Improvement/`, `Session Heartbeats/` | Templates the agents fill in as they work |

## Supported tools

| Tool | Agents installed to | Notes |
|---|---|---|
| Claude Code | `~/.claude/agents/` | Full support, including the Content Gate hooks and cloud routines |
| OpenAI Codex | `~/.codex/agents/` | Model and effort per agent |
| Cursor | `~/.cursor/agents/` | Uses your Cursor model unless you pin one |
| Gemini CLI | `~/.gemini/agents/` | Model per tier via Gemini aliases |
| GitHub Copilot | `~/.copilot/agents/` | Copilot CLI; VS Code and repo setup in the adapter notes |

See [Adapters/](Adapters/README.md) for what each tool supports.

## The team

- **Finance and Accounting:** Bookkeeping Agent, Finance Automation Agent, Financial Analyst, Financial Risk Manager, Invoicing Agent, Reporting Agent
- **Information Technology:** C++ Engineer, Content Integrity Agent, Deployment Agent, iOS Engineer, IT Automation Agent, Python Engineer, QA Engineer, React Native Engineer, Security Engineer, Support-Triage Agent, Sysadmin Agent, System Design Engineer, UI Designer, UI Lead, UX Agent, Web Engineer
- **Operations:** Operations Automation Agent, Process Agent, Publishing Agent, Scheduling Agent, Vendor-Ops Agent
- **Research and Development:** Product Agent, Prototyping Agent, Quantitative Researcher, Research Agent, Research Automation Agent

Each department's **automation agent** runs that department's repetitive tasks
(scans, digests, checklists, recurring reports) on a schedule. You approve
each task once. Anything that sends, pays, deploys or deletes still asks you
every time.

## Quick start

Requirements: one of the supported tools and Python 3.

```bash
git clone https://github.com/robjrtech/talent-agency-starter-kit.git "Talent Agency"
cd "Talent Agency"
python3 "Agent Definitions/generate.py"   # installs agents for every supported tool it finds
```

Then restart your tool so it loads the new agents, and create a `Projects/`
folder next to this one for your actual work. Try:

> *"Read Overview.md and explain in simple terms what this team can do for me."*

To install for one tool only: `python3 "Agent Definitions/generate.py" --tool codex`
(or `claude`, `cursor`, `gemini`, `copilot`, `all`).

## How it works

- **Role files are the source of truth.** Edit a job description,
  `Routing.md` or `models.json`, rerun `generate.py`, and restart your tool.
- **Agents route by the cost of a mistake, not the size of the task.**
  Planning runs on the strongest tier. Execution runs at each agent's own
  tier. After one failure, the agent moves up a tier instead of retrying at
  the same level.
- **Gates before shipping.** The System Design Engineer reviews architecture
  before building starts. The QA Engineer tests real behavior. The Security
  Engineer signs off against the OWASP Top 10 before anything ships.
- **Sub-agents are used sparingly:** at most 3–4 at a time across all
  sessions and tools, coordinated through `Session Heartbeats/`.

## Optional pieces

- **SOX-style controls** (`Compliance/Optional/SOX/`). Opt-in controls for
  projects that handle financial data, modeled on the IT controls auditors
  test under the US Sarbanes-Oxley Act. Voluntary, not legal compliance.
  You assign the responsibilities to whichever agents you have.
- **Publishing workspace.** The rules file finished work in one workspace
  you choose. Replace `<your publishing workspace>` in `Overview.md` with
  yours (a shared folder, a wiki, a docs tool), or leave it and work is
  filed in each project's folder. Tool setup, for example
  [Notion](Adapters/Notion/README.md), is in `Adapters/`.
- **Content Gate** (`Adapters/Claude Code/Content Gate/`). A Claude Code,
  macOS-only defense against prompt injection from web pages and connectors.
  It installs system-wide Claude Code hooks and needs `sudo`. Read
  [Content Integrity Agent.md](Information%20Technology/Content%20Integrity%20Agent.md)
  before installing it. In other tools the same rule applies as policy.

## Upgrading

- **Notion Agent renamed to Publishing Agent.** The publishing gate no
  longer assumes Notion. After updating, rerun
  `python3 "Agent Definitions/generate.py"`, then delete the old
  `notion-agent` file from your tool's agents folder (the generator flags it as
  `stale` but doesn't delete it). If you use Notion, see
  `Adapters/Notion/`.

## Make it yours

`Overview.md` is meant to be edited. Add departments, rewrite policies, or
remove anything that doesn't fit how you work. Your AI can make the changes
for you.

## A word of caution

AI agents make mistakes. Read permission prompts before approving them, never
paste passwords or private keys into a chat, and double-check anything
involving money, legal matters or security.
