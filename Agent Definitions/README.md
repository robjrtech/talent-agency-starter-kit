# Agent Definitions

Turns the Talent Agency role files into Claude Code subagents, so each agent
can be launched by name (for example `security-engineer`) from any project,
already set to the model and effort in [Routing.md](../Routing.md).

## How it works

- **Source of truth:** the role files in each department folder
  (`<Department>/<Agent>.md`). Never edit the generated files directly.
- **Output:** `~/.claude/agents/<agent-name>.md` (user level, so the agents
  are available in every project under `Projects/`).
- **Model and effort** come from each role file's `## Default Routing` section:
  Fast → `haiku`, Standard → `sonnet`, Deep → `opus`. Effort uses the first
  level listed (for "Medium; High for specs" the default is Medium).
- **Every agent evaluates its task first.** Before working, it rates the cost
  of a mistake, how easily the result can be checked, how ambiguous the task
  is, and whether it has already failed once. If the task is above its level,
  it stops and returns an escalation request instead of weak work. Routing is
  **guidance the agents apply with judgment**, not a hard lock.
- **Skipped:** the Content Integrity Agent (it runs as root-owned hooks, not
  a subagent) and any file without a `## Default Routing` section (such as
  the UI Lead's preferences log).

## When to rerun

After any change to a role file, its routing, or Routing.md's shared rules:

```
cd "Agent Definitions"
python3 generate.py --check   # preview: create / update / same
python3 generate.py           # write
```

New or changed definitions load when a Claude Code session starts.
The script only overwrites files it generated (it checks for its marker
comment), and it reports definitions whose role file was removed rather
than deleting them.

**Gotcha confirmed 2026-10-07:** "loads when a session starts" is literal — a
session that's already running keeps whatever subagent list it started with,
even after the generator writes new or changed files to `~/.claude/agents/`.
Calling the Agent tool by name (e.g. `security-engineer`) in the *same*
session that just ran the generator fails with "Agent type not found." The
fix is just to start a new session (new window, or `/new`) — it isn't a bug
to chase. In the meantime, the current session can still do the work: read
the relevant `<Department>/<Agent>.md` role file directly and act under it
(or hand it to a generic agent type as its brief) — the capability is the
role file's content, not the generated wrapper around it.

**This fallback does not automatically carry the role's model/effort.** The
generated definition pins model and effort from the role's `## Default
Routing` section; a generic agent type (e.g. `general-purpose`) given the
role file as its brief runs at *its own* default instead, and there's no
effort-level override for it at all. For a Standard/Medium role that gap
rarely matters. For a **Deep/High gate role** (System Design Engineer,
Security Engineer, UI Lead, Financial Risk Manager), it can: an unpinned
fallback may quietly review a gate at a weaker tier than the policy
requires. When using this fallback for a gate role, explicitly pass
`model: opus` on the call — there's still no way to force the effort level,
so flag that gap to the user rather than silently absorbing it.

## Who maintains it

The **Process Agent** reruns the generator after folding approved changes
into a role file (Self-Improvement rollup, quarterly routing review).
