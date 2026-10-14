# Content Gate (Claude Code)

The Claude Code implementation of the
[Content Integrity Agent](../../../Information%20Technology/Content%20Integrity%20Agent.md)'s
untrusted-content gate. macOS only. Installing it needs `sudo` and changes
system-wide Claude Code settings, so read all of this first.

## How it runs (enforced, not optional)
Implemented as Claude Code hooks in managed settings (see Tamper
protection below), so it runs on every matching tool call in every
project, whether or not an agent remembers to call it.

1. **Trusted task record.** Each user prompt is saved to
   `~/.claude/content-gate/sessions/<session>/task.md`. Only the user's own
   prompts are written there, so fetched content can't rewrite the task.
2. **Layer 1 — pattern scan** (`content_gate.py`).
   Deterministic, so injected text can't argue with it. Logs every external
   fetch to `~/.claude/content-gate/audit.jsonl` and halts on high-confidence
   injection patterns. Rejects are also appended to
   `~/.claude/content-gate/incidents.md`.
3. **Layer 2 — semantic check** (Haiku agent hook). Reads the trusted task
   file and judges whether the content tries to steer the agent away from it.

## Tamper protection (root-owned managed install)
No agent can switch the gate off:
- **Managed settings.** The hooks and deny rules live in
  `/Library/Application Support/ClaudeCode/managed-settings.d/50-content-gate.json`.
  Per the Claude Code docs, managed hooks can't be removed or disabled by
  user, project, or local settings, including `disableAllHooks`.
- **Root-owned scripts.** `content_gate.py` and `gate_guard.py` live in
  `/Library/Application Support/ClaudeCode/hooks/` (root:wheel, 644) and
  run under Apple's SIP-protected `/usr/bin/python3 -I`, which ignores
  user site-packages and `PYTHON*` environment variables. Changing them
  requires your admin password.
- **Deny rules.** `permissions.deny` blocks Edit/Write on all Claude Code
  settings files, the gate's directories, and the trusted-task files.
- **Bash guard.** A PreToolUse hook (`gate_guard.py`) blocks any shell
  command that touches those paths or `disableAllHooks`, allowing only
  plain reads. It fails closed. Side effect: it also blocks harmless
  commands whose text mentions those names; use Edit/Write for unrelated
  files.

**Changing the gate is user-only.** Source of truth: this folder. Edit
here by hand, run `/usr/bin/python3 -I selftest.py` in this folder, then
run `sudo bash install.sh`. Agents can't edit any settings files, so other
settings changes (such as permission allowlists) are also made by hand.

**Remaining residual risk:** the trusted-task files and logs in
`~/.claude/content-gate/` are written by the hooks as you, so they can't be
root-owned. Deny rules and the Bash guard protect them, but a deliberately
obfuscated shell command could still alter them.

## Known limits (Claude Code)
- The hook runs *after* the tool returns, so flagged content is already in
  that conversation's context. The halt stops the agent from acting on it;
  for a clean slate, `/clear` and re-run without the source.
- Layer 2 is itself an LLM and can in principle be fooled; layer 1 and
  least-privilege tool access for research agents are the backstops.
- Local file reads (`Read`) are not gated, because that would screen every
  code file. Treat uploaded or downloaded files as external: route them
  through the Content Integrity Agent manually until a narrower hook is
  added.
- A gate script error shows a warning and lets content through unscreened
  (fail-open), so a bug can't block all work. Watch for
  "content gate error" messages.

## Routine duties (Claude Code)
- Review `incidents.md` and recent `audit.jsonl` entries; promote any new
  injection phrasing seen in the wild into layer 1's patterns.
- At the quarterly audit, check for new connectors or tools that need
  adding to the hook matcher.
