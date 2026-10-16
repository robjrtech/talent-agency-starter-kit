# Claude Code adapter

The most complete adapter: everything in the kit was first built here.

## Install

```bash
python3 "Agent Definitions/generate.py" --tool claude
```

Writes one subagent per role to `~/.claude/agents/<name>.md`, and installs
each skill in [Skills/](Skills/) to `~/.claude/skills/<name>/SKILL.md`. Agents get `model`
(`haiku` / `sonnet` / `opus`, from `models.json`) and `effort`. Restart
Claude Code to load them, then call one by name, e.g. `security-engineer`.
`CLAUDE.md` at the kit root imports `AGENTS.md`, so Claude Code reads the
same core rules as every other tool.

## Claude Code-only features

- **[Content Gate/](Content%20Gate/)** enforces the untrusted-content policy
  with root-owned managed-settings hooks. External content is screened
  before any agent acts on it, and agents can't turn the check off. It's
  macOS-only, needs `sudo bash install.sh`, and changes system-wide Claude
  Code settings. Read
  [its README](Content%20Gate/README.md) and the
  [Content Integrity Agent](../../Information%20Technology/Content%20Integrity%20Agent.md)
  first.
- **[Skills Mapping.md](Skills%20Mapping.md)** lists which Claude Code
  skills, connectors (Gmail, Calendar, Drive, Notion, Figma, Vercel) and
  local apps each agent uses.
- **Recurring tasks:** the Scheduling Agent arms **Cloud** tasks as routines
  with the `schedule` skill, and **Local** tasks with `/loop` or a session
  cron.
- **[`/temp-role` skill](Skills/temp-role/SKILL.md)** runs the Temporary
  roles policy from start to finish. `/temp-role <task>` checks for an
  existing fit, drafts the charter, gets the System Design and Security
  reviews, stops for your approval and launches the role. `run`, `close` and
  `status` cover the rest of its life. It runs only when you type it, and it
  refuses to run inside a sub-agent. `generate.py --tool claude` installs it
  to `~/.claude/skills/temp-role/`. Skills load without a restart.
- **Resuming sub-agents:** Routing.md's "resume, don't restart" rule uses
  `SendMessage` here.
