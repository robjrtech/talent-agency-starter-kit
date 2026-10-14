# OpenAI Codex adapter

## Install

```bash
python3 "Agent Definitions/generate.py" --tool codex
```

Writes one custom agent per role to `~/.codex/agents/<name>.toml`, with
`name`, `description`, `developer_instructions`, `model` and
`model_reasoning_effort`. Default models (`models.json`): `gpt-6-luna` for
Fast, `gpt-6.1-sol` for Standard and Deep, with the role's own effort.
Ask for an agent by name in your prompt, e.g. "have the security-engineer
review this".

Codex reads `AGENTS.md` natively, so opening the kit folder gives it the
core rules.

## Recommended setting

Match Routing.md's global sub-agent cap in `~/.codex/config.toml`:

```toml
[agents]
max_concurrent_threads_per_session = 4
```

This caps one session. The cap across sessions and devices still relies on
`Session Heartbeats/`.

## Gaps

- **Content Gate:** not ported. The untrusted-content rule applies as
  policy. Codex's sandbox and approval settings limit what a misled agent
  could do, so keep approvals on for anything that writes outside the
  project.
- **Recurring tasks:** run them as **Local** tasks in an open session. The
  kit doesn't set up a cloud schedule for Codex.
- **Resuming sub-agents:** if an interrupted sub-agent can't be resumed
  here, start a new one and point it at the progress it saved to disk
  (Routing.md Rule 5).
- **Skills and connectors:** the Claude Code Skills Mapping doesn't apply.
  Codex skills and MCP servers can be added to a generated agent by hand,
  but rerunning the generator overwrites it, so put lasting changes in
  `generate.py`.
