# GitHub Copilot adapter

## Install

```bash
python3 "Agent Definitions/generate.py" --tool copilot
```

Writes one custom agent per role to `~/.copilot/agents/<name>.agent.md`,
the user-level folder for **Copilot CLI**. Pick one with `/agent` or start
with `copilot --agent security-engineer`.

Copilot reads `AGENTS.md` for the core rules.

## Other Copilot surfaces

- **VS Code:** user-level custom agents live in your VS Code profile, not
  `~/.copilot/agents/`. Use "Configure Custom Agents" in the agents
  dropdown, choose the user profile location, and copy in the generated
  files you want.
- **A single repository:** copy the generated files into that repo's
  `.github/agents/` folder. A user-level agent with the same name overrides
  the repo one.

## Models

By default the generated files leave `model` out, so Copilot uses its
current model. To pin a model per tier, set it in
`Agent Definitions/models.json` using a name from Copilot's model picker,
then rerun the generator. Copilot has no per-agent effort setting.

## Gaps

- **Content Gate:** not ported. The untrusted-content rule applies as policy.
- **Recurring tasks:** run them as **Local** tasks in an open session.
