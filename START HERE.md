# START HERE

Welcome! You don't need any AI experience to use this. This page walks you
through it from zero.

## What is this?

This folder is a **team of AI helpers**, set up like a small company.
Each helper (an "agent") has a job description, for example a Security
Engineer, a Web Engineer, a Bookkeeper or a Researcher. The files tell the AI:

- **who** does each kind of work (the department folders)
- **how** work should be done and checked (`Overview.md`)
- **how hard** each helper should think (`Routing.md`)

You describe what you want in plain English. The AI picks the right helper, or
you can ask for one by name.

## What you need

1. **A computer.** A Mac is easiest. Windows and Linux work for everything
   except the optional Content Gate below.
2. **A paid Claude plan** (Pro or Max) from https://claude.ai. The free plan
   doesn't include Claude Code.
3. **Claude Code**, the app that lets Claude work with files on your
   computer. Install instructions: https://docs.claude.com/en/docs/claude-code/setup
   You can use it in the Claude desktop app, in VS Code, or in the Terminal.
4. **Python 3**, which is already installed on most Macs. To check, open
   Terminal and type `python3 --version`.

## Setup (about 10 minutes)

**Step 1: Put this folder somewhere permanent.** For example `Documents/`.
You can rename it, for example to `Talent Agency`.

**Step 2: Open the folder in Claude Code.** In the desktop app or VS Code,
open this folder. In Terminal, run `cd` followed by the folder path, then
type `claude`.

**Step 3: Install the helpers.** Run this command from inside this folder,
or ask Claude: *"Run the agent generator in Agent Definitions."*

```
python3 "Agent Definitions/generate.py"
```

It creates one helper per job description in your personal Claude settings
(`~/.claude/agents/`). Nothing gets sent anywhere.

**Step 4: Restart Claude Code.** New helpers only load when a session
starts. Close Claude Code and open it again.

**Step 5: Make a `Projects` folder** next to this one. That's where your
actual work goes, such as apps, documents and research. This folder holds
the rules and the team.

## Your first three requests

Try typing these into Claude Code:

1. *"Read Overview.md and explain in simple terms what this team can do for me."*
2. *"Ask the research-agent to compare three budgeting apps for a beginner and summarize the pros and cons."*
3. *"I want to build a simple to-do list website. Which agents should be involved, and in what order?"*

Tip: you can call any helper by name, for example `security-engineer`,
`ui-designer` or `bookkeeping-agent`. The full list is in the department
folders.

## Things you can skip at first

- **Notion publishing (`Operations/Notion Agent.md`).** The rules say
  finished work gets filed in Notion. If you don't use Notion, tell Claude
  *"I don't use Notion, skip the Notion publishing step,"* or delete that
  policy from `Overview.md`. If you do use Notion, replace
  `<your Notion page URL>` in `Overview.md` and `Operations/Notion Agent.md`
  with a link to your own page.
- **Content Gate (`Information Technology/Content Gate/`).** This is an
  advanced safety guard against malicious web pages that try to trick the AI.
  It's Mac-only, needs your admin password (`sudo bash install.sh`), and
  changes system-wide Claude settings. Leave it until you're comfortable,
  then read `Information Technology/Content Integrity Agent.md` first.
- **Session Heartbeats, Currency Audits, Scientific Method,
  Self-Improvement.** These folders start almost empty on purpose. The
  helpers fill them in as they work. You don't need to touch them.

## Making it yours

- Everything here is plain text. Open any `.md` file and edit it.
- After you change a job description or `Routing.md`, run step 3 again
  and restart Claude Code.
- `Overview.md` is the rulebook. If a rule doesn't fit how you work, change
  it, or ask Claude to change it for you.

## Safety basics

- Claude asks permission before running commands or changing files. Read
  each request before approving it.
- Never paste passwords, bank details or private keys into a chat.
- The AI can make mistakes. Check important work, especially anything
  involving money, legal matters or security.
