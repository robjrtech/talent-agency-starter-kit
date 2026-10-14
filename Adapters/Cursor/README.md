# Cursor adapter

## Install

```bash
python3 "Agent Definitions/generate.py" --tool cursor
```

Writes one subagent per role to `~/.cursor/agents/<name>.md`. Cursor reads
`AGENTS.md` natively.

**Generate the Cursor files even if you also use Claude Code or Codex.**
Cursor also loads agents from `~/.claude/agents/` and `~/.codex/agents/`,
and those carry Claude or OpenAI model names. When names clash, Cursor's
own folder wins, so generating for Cursor keeps its agents on Cursor's
settings.

## Models and effort

By default every tier uses `inherit`, the model you've picked in Cursor. To
make the tiers mean something, set a model per tier in
`Agent Definitions/models.json`. Effort goes in brackets where the model
supports it, for example:

```json
"cursor": { "fast": "composer-2.5", "standard": "inherit", "deep": "claude-opus-5[effort=high]", "effort": false }
```

Check the model IDs in Cursor's model picker first. Then rerun the
generator.

## Gaps

- **Content Gate:** not ported. The untrusted-content rule applies as policy.
- **Recurring tasks:** run them as **Local** tasks in an open session.
- **Resuming sub-agents:** if an interrupted sub-agent can't be resumed
  here, start a new one and point it at the progress it saved to disk
  (Routing.md Rule 5).
- **Read-only reviewers:** Cursor supports `readonly: true` for agents that
  shouldn't edit files. The generator doesn't set it. Gate agents (System
  Design Engineer, Security Engineer, UI Lead) are good candidates if you
  want it.
