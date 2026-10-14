# Gemini CLI adapter

## Install

```bash
python3 "Agent Definitions/generate.py" --tool gemini
```

Writes one subagent per role to `~/.gemini/agents/<name>.md`. Call one with
`@name`, e.g. `@security-engineer`, and list them with `/agents`.

`GEMINI.md` at the kit root imports `AGENTS.md`, so Gemini CLI reads the
core rules. Alternatively, add `AGENTS.md` to `context.fileName` in your
Gemini CLI `settings.json`.

## Models

Default models (`models.json`) use Gemini CLI's aliases: `flash-lite` for
Fast, `flash` for Standard, `pro` for Deep. If your version rejects an
alias, replace it with a full model ID from `/model` and rerun the
generator. Gemini CLI has no per-agent effort setting, so the role's effort
level is only stated in the agent's instructions.

## Gaps

- **Content Gate:** not ported. The untrusted-content rule applies as policy.
- **Recurring tasks:** run them as **Local** tasks in an open session.
- **Resuming sub-agents:** if an interrupted sub-agent can't be resumed
  here, start a new one and point it at the progress it saved to disk
  (Routing.md Rule 5).
- **Antigravity CLI:** Google replaced Gemini CLI with Antigravity CLI for
  unpaid and Google One users on 2026-06-18. This adapter targets Gemini
  CLI. Check Antigravity's docs before assuming it reads the same agent
  folder.
