# Temporary Roles

Charters, work logs and archives for temporary roles in Research and Development.
Backs the **Temporary roles** standing policy in [Overview.md](../../Overview.md).
Every department has its own `Temporary/` folder with the same README and
template; keep them in step when one changes.

## When to use one

A task needs a role that no existing agent covers, and the need ends with the
task. If the need is ongoing, propose a permanent role instead. If an existing
role covers it even partly, use that role and note the gap in its
Self-Improvement log.

## Layout

```text
Temporary/
├── README.md
├── _template.md                    ← charter template
├── <Role> - <Project>/             ← one folder per active temporary role
│   ├── charter.md                  ← copied from _template.md
│   └── logs/
│       └── <YYYY-MM-DD>-<slug>-<id>.md   ← one new file per session
└── Archive/                        ← closed roles, moved here whole at decommission
```

This folder sits below the department folder, and
[`generate.py`](../../Agent%20Definitions/generate.py) reads only `*.md`
directly in each department folder. That keeps temporary roles out of every
tool's generated agents, so their names can't collide with permanent agents
and nothing goes stale when they close.

Like `Self-Improvement/`, every log is a new, uniquely-named file, never an
append, because this folder may sync across devices. The `<id>` is a short
session-ID slug or 4 random hex characters.

## Lifecycle

| Step | Who | Done when |
|---|---|---|
| 1. Draft charter | Requesting agent or session | `charter.md` filled in, Status: Proposed |
| 2. Check skills and approach | System Design Engineer | Sign-off line filled in charter |
| 3. Check tools and access | Security Engineer | Sign-off line filled in charter |
| 4. Approve | User, in session | Status: Active, approval date filled in |
| 5. Work | The temporary role | One `logs/` file per session; Self-Improvement entries in `Self-Improvement/Temp - <Role>/` |
| 6. Review work | Sponsor, plus the usual gates | Sponsor review filled in charter; QA, Security, compliance and publishing gates passed |
| 7. Decommission | Sponsor | Handoff filled in, Status: Closed, folder moved to `Archive/` |

## Running a temporary role

There's no generated agent, so run it the way
[Agent Definitions/](../../Agent%20Definitions/README.md) describes for any role
without one: the session, or a generic sub-agent, acts under the whole
`charter.md` as its brief. That doesn't carry the charter's model or effort.
Use a model at the charter's tier, or tell the user the work ran below it.
Tool-specific steps are in [Adapters/](../../Adapters/README.md).

The brief must also tell it to:

- follow every standing policy in Overview.md, as any agent does
- write a `logs/` entry before it finishes each session
- stop and ask rather than act outside the charter's scope

## Validating the work when no one has the expertise

The sponsor is the closest permanent role, which may not be close enough to
judge the work. When the sponsor says it can't fully assess something, write
that in the charter's Sponsor review. Lean on checks that don't need the
specialty: QA against real behavior, the System Design Engineer at Deep tier,
and the Scientific Method records. Any gap still open goes to the user as an
explicit, written risk acceptance.

## Decommission

1. The sponsor fills in the Handoff section and takes ownership of the code,
   docs and open issues.
2. Lessons that apply beyond this task go in the sponsor's
   `Self-Improvement/<Sponsor>/` log as new entries.
3. Set Status: Closed, move `Self-Improvement/Temp - <Role>/` into the role's
   folder as `self-improvement/`, then move the whole folder to `Archive/`.
   Never delete it: post-build reports and published entries link to it.
4. If a role with the same purpose has been chartered before (check
   `Archive/`), the Process Agent proposes a permanent role for the user's
   approval.
