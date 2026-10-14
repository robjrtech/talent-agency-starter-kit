# Claude Code adapter

The most complete adapter: everything in the kit was first built here.

## Install

```bash
python3 "Agent Definitions/generate.py" --tool claude
```

Writes one subagent per role to `~/.claude/agents/<name>.md`, with `model`
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
- **Resuming sub-agents:** Routing.md's "resume, don't restart" rule uses
  `SendMessage` here.
