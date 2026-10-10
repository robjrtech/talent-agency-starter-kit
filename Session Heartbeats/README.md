# Session Heartbeats

Advisory, cross-session/cross-device coordination for Routing.md's
[Rule 5](../Routing.md) global subagent cap (3–4 at a time, across the whole
operation). Backs the **Model & effort routing** standing policy in
[Overview.md](../Overview.md).

## Why this folder exists

If this folder is synced across devices (iCloud Drive, Dropbox, OneDrive, etc.),
note that cloud sync is **not** a mutual-exclusion mechanism — it's eventually consistent,
with lag from seconds to minutes, and two devices writing the same file at close to
the same time typically produce a sync conflict copy or a silently dropped edit,
rather than a clean "last write wins." A shared counter that multiple sessions read
and increment would race exactly the way this folder exists to prevent.

The fix is to never share a mutable file: **each session only ever writes its own
heartbeat file.** Coordination happens by every session reading everyone else's
file, not by anyone writing to a shared one.

## File format

One file per session: `<device-slug>-<session-id-short>.json`
(e.g. `MacBook-Pro-f3e01850.json`). Copy [`_template.json`](_template.json) for the
shape:

```json
{
  "device": "MacBook-Pro",
  "session_id": "f3e01850-e603-4481-adde-284b740b4e6b",
  "active_subagents": 2,
  "updated_at": "2026-10-07T14:32:00Z"
}
```

## Protocol

Before spawning a subagent, any session (the top-level session or a Talent Agency
agent already running as one):

1. **Write/update only your own file** — your current active subagent count, and a
   fresh `updated_at`. Never touch another session's file.
2. **Read every file in this folder.** Ignore any whose `updated_at` is more than
   10 minutes old — treat that session as gone or stuck, not as active.
3. **Sum `active_subagents`** across the remaining files, including your own.
4. **If that sum plus what you're about to launch would exceed 4, hold back** —
   queue, launch fewer, or ask the user. Don't spawn past the shared ceiling.
5. **Update your file as subagents finish**, and **delete it** once you have none
   active, or when your session ends.

## What this is not

This is **advisory, not a hard lock**. Two sessions can check at nearly the same
instant and both proceed, briefly overshooting the cap — there's no atomic
operation across cloud sync to prevent that. That's an accepted tradeoff: the goal
is to catch the common case cheaply (one session clearly sees three others already
running and holds back), not to build real distributed mutual exclusion for a
personal tool. The failure mode is a brief overshoot, not corrupted state — the
same bar Routing.md already sets ("guidance agents apply with judgment, not a hard
lock").

## Cleanup

A heartbeat file older than **1 hour** (not just the 10-minute ignore-for-counting
threshold) almost certainly belongs to a crashed or force-quit session. Any session
that notices one may delete it — don't let abandoned files accumulate.
