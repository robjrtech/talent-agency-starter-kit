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
- **Departments** are listed in `DEPARTMENTS` at the top of `generate.py`.
  A new department folder is skipped, with no warning, until its name is
  added there. Subfolders such as `Temporary/` are never read.
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

## Claude Code skills

For Claude Code, the generator also installs the kit's skills. Each
`Adapters/Claude Code/Skills/<name>/SKILL.md` is the source. It's written to
`~/.claude/skills/<name>/SKILL.md`, with `<<AGENCY>>` replaced by this
folder's path and a marker comment added after the frontmatter.
- **Same safety rules as agents:** it only overwrites files this checkout
  generated, and it reports stale ones without deleting them.
- **Everything is checked before anything is written.** The folder name must
  be lowercase letters, digits and hyphens, can't be `synced` (Claude Code's
  own folder), and must match the frontmatter `name`.
- **Only `SKILL.md` is installed.** The generator warns about any other file
  in the skill's folder.

Keep the frontmatter valid YAML, and quote any value that contains `: `. If it
fails to parse, Claude Code loads the skill with none of its fields.

## Running it

After any change to a role file, Routing.md, models.json or a skill in
`Adapters/Claude Code/Skills/`:

```
cd "Agent Definitions"
python3 generate.py --check              # preview: create / update / same
python3 generate.py                      # every tool installed on this computer
python3 generate.py --tool codex,cursor  # only these tools
python3 generate.py --tool all           # every supported tool
```

With no `--tool`, the script writes for each tool whose home folder exists
(`~/.claude`, `~/.codex`, `~/.cursor`, `~/.gemini`, `~/.copilot`). It only
overwrites files this checkout generated. It checks for its marker and this
folder's path, so files from a second copy of the kit are left alone. It
reports definitions whose role file was removed rather than deleting them. If
you move this folder, files generated from its old location count as another
copy's, so delete them by hand and rerun.

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
