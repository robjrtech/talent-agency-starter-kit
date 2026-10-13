#!/usr/bin/python3 -I
"""Tamper guard for the Untrusted Content Gate (PreToolUse on Bash).

Installed root-owned at /Library/Application Support/ClaudeCode/hooks/ and
wired in through managed settings. Denies any shell command that touches
Claude Code settings, the gate's files, or hook-disabling switches, unless
it is a plain read (cat/grep/jq/... with no redirection or chaining).
Edit/Write tools are blocked separately by permissions.deny.

The root-owned install is the hard lock; this guard is the speed bump that
keeps agents from even trying through the shell. Fails closed.
Must stay Python 3.9 compatible (/usr/bin/python3).
"""
import json
import re
import sys

PROTECTED = re.compile(
    r"settings(\.local)?\.json|managed-settings|ClaudeCode|\.claude/hooks|content[-_]gate|gate_guard|"
    r"disableAllHooks|allowManagedHooksOnly|CLAUDE_CODE_DISABLE",
    re.IGNORECASE,
)
READ_ONLY = re.compile(r"^\s*(cat|head|tail|less|grep|rg|jq|ls|stat|wc|diff|shasum|file)\s")
CHAINING = re.compile(r"[>;&`]|\$\(|\|\s*(tee|sh|bash|zsh|python|perl|ruby|node|xargs|dd|sponge)\b")


def deny(reason):
    print(json.dumps({"hookSpecificOutput": {
        "hookEventName": "PreToolUse",
        "permissionDecision": "deny",
        "permissionDecisionReason": reason}}))


def main():
    try:
        cmd = json.load(sys.stdin).get("tool_input", {}).get("command", "")
    except Exception as e:
        deny(f"Tamper guard could not read the command ({e!r}); blocked to be safe.")
        return
    if not PROTECTED.search(cmd):
        return
    if READ_ONLY.match(cmd) and not CHAINING.search(cmd):
        return
    deny("Blocked by the Untrusted Content Gate tamper guard: agents may not modify Claude Code "
         "settings, the gate's hooks, or its trusted-task files. The user must make this change by hand.")


if __name__ == "__main__":
    main()
