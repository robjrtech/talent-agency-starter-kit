# Adapters

The Talent Agency core (Overview.md, Routing.md, the role files and the
shared folders) is tool-neutral. This folder holds what differs per tool:
how agents get installed, which model each tier uses, and which features
exist there.

| | Claude Code | OpenAI Codex | Cursor | Gemini CLI | GitHub Copilot |
|---|---|---|---|---|---|
| Reads `AGENTS.md` | via `CLAUDE.md` | yes | yes | via `GEMINI.md` | yes |
| Generated agents | `~/.claude/agents/` | `~/.codex/agents/` | `~/.cursor/agents/` | `~/.gemini/agents/` | `~/.copilot/agents/` |
| Model per tier | yes | yes | optional (default: inherit) | yes | optional (default: inherit) |
| Effort per agent | yes | yes | via model brackets | no | no |
| Content Gate enforcement | hooks (macOS) | policy only | policy only | policy only | policy only |
| Scheduled cloud runs | routines | not set up by the kit | not set up by the kit | not set up by the kit | not set up by the kit |

"Policy only" means agents follow the untrusted-content rule in
AGENTS.md and Overview.md, but nothing enforces it if an agent forgets.
Recurring tasks still work everywhere as **Local** tasks run in an open
session.

Install for every tool on this computer:

```bash
python3 "Agent Definitions/generate.py"
```

Per-tool details:

- [Claude Code](Claude%20Code/README.md)
- [OpenAI Codex](OpenAI%20Codex/README.md)
- [Cursor](Cursor/README.md)
- [Gemini CLI](Gemini%20CLI/README.md)
- [GitHub Copilot](GitHub%20Copilot/README.md)

Formats and model names were checked against each tool's documentation on
2026-10-13. These tools change quickly. The quarterly currency audit
re-checks this folder and `Agent Definitions/models.json`.

**Adding a tool:** add an entry to `TOOLS` in `generate.py` and to
`models.json`, then write a README here. If the tool reads `AGENTS.md`, the
core rules already apply.
