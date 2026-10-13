# Agent Definitions

Turns the Talent Agency role files into native agents for each AI coding
tool, so every agent can be launched by name (for example
`security-engineer`) from any project, already set to the tier and effort in
[Routing.md](../Routing.md).

| Tool | Output | Format |
|---|---|---|
| Claude Code | `~/.claude/agents/<name>.md` | Markdown + YAML frontmatter (`model`, `effort`) |
| OpenAI Codex | `~/.codex/agents/<name>.toml` | TOML (`model`, `model_reasoning_effort`, `developer_instructions`) |
| Cursor | `~/.cursor/agents/<name>.md` | Markdown + YAML frontmatter (`model`) |
| Gemini CLI | `~/.gemini/agents/<name>.md` | Markdown + YAML frontmatter (`model`) |
| GitHub Copilot | `~/.copilot/agents/<name>.agent.md` | Markdown + YAML frontmatter (`model` optional) |

All files are user level, so the agents are available in every project
under `Projects/`. Per-tool notes are in [Adapters/](../Adapters/README.md).

## How it works

- **Source of truth:** the role files in each department folder
  (`<Department>/<Agent>.md`). Never edit the generated files directly.
- **Tier and effort** come from each role file's `## Default Routing`
  section. Effort uses the first level listed (for "Medium; High for specs"
  the default is Medium).
- **Models** come from [models.json](models.json), which maps Fast /
  Standard / Deep to a model for each tool. `"inherit"` uses the tool's
  current model, and `null` leaves the model out. Edit it to match the
  models you have access to.
- **Every agent evaluates its task first.** Before working, it rates the cost
  of a mistake, how easily the result can be checked, how ambiguous the task
  is, and whether it has already failed once. If the task is above its level,
  it stops and returns an escalation request instead of weak work. Routing is
  **guidance the agents apply with judgment**, not a hard lock.
- **Skipped:** the Content Integrity Agent (in Claude Code it runs as
  hooks, not an agent) and any file without a `## Default Routing` section
  (such as the UI Lead's preferences log).

## Running it

After any change to a role file, Routing.md or models.json:

```
cd "Agent Definitions"
python3 generate.py --check              # preview: create / update / same
python3 generate.py                      # every tool installed on this computer
python3 generate.py --tool codex,cursor  # only these tools
python3 generate.py --tool all           # every supported tool
```

With no `--tool`, the script writes for each tool whose home folder exists
(`~/.claude`, `~/.codex`, `~/.cursor`, `~/.gemini`, `~/.copilot`). It only
overwrites files it generated (it checks for its marker), and it reports
definitions whose role file was removed rather than deleting them.

## New agents load at session start

In every tool, a session that's already running keeps the agent list it
started with. Start a new session after running the generator.

Until then, the current session can still do the work: read the relevant
`<Department>/<Agent>.md` role file and act under it. **That fallback
doesn't carry the role's model or effort.** For a Deep/High gate role
(System Design Engineer, Security Engineer, UI Lead, Financial Risk
Manager), switch the session to a Deep-tier model first, or tell the user
the review ran below the tier the policy requires.

## Who maintains it

The **Process Agent** reruns the generator after folding approved changes
into a role file (Self-Improvement rollup, quarterly routing review). The
**System Design Engineer** re-checks `models.json` and the tool formats in
the quarterly currency audit.
