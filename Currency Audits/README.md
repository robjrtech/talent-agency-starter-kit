# Currency Audits

Write-ups from the two standing policies (see [Overview.md](../Overview.md#22))
that keep agents' tools, skills, and dependency choices from going stale:

- **Quarterly currency audit** — the System Design Engineer's scheduled sweep
  of every agent's stated tools/skills/dependency versions.
- **Point-of-use version check** — the build-time check an agent runs before
  adopting a dependency, library, or API. Log it here only if it surfaces a
  finding worth recording (routine checks that find nothing don't need a file).

## Filing a report

One file per audit or notable point-of-use check:
`YYYY-MM-DD-<agent-or-scope>.md`, e.g. `2026-09-23-quarterly-sweep.md` or
`2026-11-02-web-engineer-point-of-use.md`.

Copy [`_template.md`](_template.md) as the starting point. Each report covers:

1. **Findings** — what's stale or outdated, and where (agent, tool, skill, or
   dependency).
2. **Potential issues if applied** — the risk of actually adopting the
   recommended update (breaking changes, migration cost, compatibility
   fallout) — not the risk of leaving things as-is.
3. **What was updated** — a record of what changed, as a table of
   Agent / Tool / Skill / Version (before → after). Leave a row's "after"
   blank if a finding was reviewed but deliberately not applied, and note why.

## Index

| Date | Scope | Report |
|------|-------|--------|
