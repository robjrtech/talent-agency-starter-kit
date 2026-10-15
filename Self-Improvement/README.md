# Self-Improvement

Per-agent logs backing the **Self-improvement** standing policy in
[Overview.md](../Overview.md#22).

## How it works

1. **In-task habit.** Before any agent finalizes a piece of work, it checks its own
   output against its own log here, and against whatever it's about to deliver, for a
   gap of the kind it's made before. If it finds one (now, or after the fact — a
   mistake the user or another agent points out), it files a new dated entry as its
   own file under its log directory.
2. **Quarterly rollup.** On the same cadence as the [Currency Audits](../Currency%20Audits/),
   each agent reviews its own log and drafts proposed wording changes to its own entry
   in Overview.md's Departments and Agents section — the lessons that are worth baking
   into how the role is defined, not just a one-off fix.
3. **Approval.** Proposed changes go through the publishing gate (filed as a
   project, reviewed by the Publishing Agent) before they're treated as accepted.
4. **Fold-in.** Once approved, the **Process Agent** edits the agent's actual entry in
   Overview.md, marks the promoted entry files as applied (add a `**Promoted:**` date),
   and may archive or delete promoted files so the directory doesn't carry stale,
   already-promoted items forward indefinitely.

5. **Routing review.** Each quarter, the Process Agent also reviews the **Rework**
   fields across all logs and proposes changes to the tier and effort table in
   [Routing.md](../Routing.md). Changes go through the same approval path.

## Filing a log

**One file per entry, in a per-agent directory:**
`<Agent Name>/<YYYY-MM-DD>-<slug>-<id>.md` (e.g.
`Web Engineer/2026-10-07-stale-cache-key-a1b2.md`). Create the agent's directory on
first use — don't pre-create empty ones for agents that haven't needed one yet.
Temporary roles use `Temp - <Role>/` (see the **Temporary roles** policy); at
decommission that directory moves to the charter's archive folder. Copy
[`_template.md`](_template.md) for the entry format.

**Why one file per entry, not one shared file per agent:** this folder may be synced
across multiple devices and sessions. A single shared file that multiple
sessions append to can race — two sessions logging at nearly the same time can produce
a sync conflict copy or a silently dropped entry. A new, uniquely-named file per entry
can never collide with another session's write, because no two sessions ever target
the same filename. The `<id>` suffix (a short slug of the session ID, or 4 random hex
characters) exists specifically to make that true even if two sessions log the same
agent on the same day with similar wording.
