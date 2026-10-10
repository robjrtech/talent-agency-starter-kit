#!/bin/bash
# Installs the Untrusted Content Gate as root-owned Claude Code managed settings.
# Managed hooks can't be removed or disabled from user/project settings, and
# root-owned scripts can't be edited without your admin password.
#
# Run from your own account:   sudo bash install.sh
# Re-run the same way after changing any file in this folder.
set -euo pipefail

[[ $EUID -eq 0 ]] || { echo "Run with sudo: sudo bash \"$0\""; exit 1; }
USER_NAME="${SUDO_USER:?Run via sudo from your own account, not a root shell}"
USER_HOME=$(dscl . -read "/Users/$USER_NAME" NFSHomeDirectory | awk '{print $2}')
SRC="$(cd "$(dirname "$0")" && pwd)"
DEST="/Library/Application Support/ClaudeCode"
DROPIN="$DEST/managed-settings.d/50-content-gate.json"
STAMP=$(date +%Y%m%d-%H%M%S)
PY=(/usr/bin/python3 -I)

echo "1/6 Validating package..."
"${PY[@]}" -c 'import json,sys; d=json.load(open(sys.argv[1])); assert isinstance(d, dict) and d.get("hooks"), "no hooks"' "$SRC/managed-settings.json"
sudo -u "$USER_NAME" "${PY[@]}" "$SRC/selftest.py" "$SRC" >/dev/null || { echo "Self-test failed on the package. Nothing installed."; exit 1; }

echo "2/6 Backing up any previous gate install..."
if [[ -e "$DROPIN" ]]; then cp -p "$DROPIN" "$DROPIN.bak-$STAMP"; echo "    previous drop-in backed up"; fi

echo "3/6 Installing root-owned files to $DEST ..."
install -d -o root -g wheel -m 755 "$DEST" "$DEST/hooks" "$DEST/managed-settings.d"
install -o root -g wheel -m 644 "$SRC/content_gate.py" "$SRC/gate_guard.py" "$SRC/selftest.py" "$DEST/hooks/"
install -o root -g wheel -m 644 "$SRC/managed-settings.json" "$DROPIN"

echo "4/6 Verifying the installed copies..."
sudo -u "$USER_NAME" "${PY[@]}" "$DEST/hooks/selftest.py" "$DEST/hooks" | tail -1

echo "5/6 Removing the old user-level gate hooks (they're managed now)..."
SETTINGS="$USER_HOME/.claude/settings.json"
cp -p "$SETTINGS" "$SETTINGS.bak-$STAMP"
sudo -u "$USER_NAME" "${PY[@]}" - "$SETTINGS" <<'PYEOF'
import json, sys
p = sys.argv[1]
s = json.load(open(p))
hooks = s.get("hooks", {})
def is_gate(group):
    return any(("content_gate.py" in h.get("command", "") or "gate_guard.py" in h.get("command", ""))
               for h in group.get("hooks", []))
for event in list(hooks):
    kept = [g for g in hooks[event] if not is_gate(g)]
    if kept:
        hooks[event] = kept
    else:
        del hooks[event]
if not hooks:
    s.pop("hooks", None)
with open(p, "w") as f:
    json.dump(s, f, indent=2, ensure_ascii=False)
    f.write("\n")
print("    user-level gate hooks removed (deny rules kept as a second layer)")
PYEOF

echo "6/6 Retiring the old user-level scripts..."
OLD="$USER_HOME/.claude/content-gate/retired-$STAMP"
sudo -u "$USER_NAME" mkdir -p "$OLD"
for f in "$USER_HOME/.claude/hooks/content_gate.py" "$USER_HOME/.claude/hooks/gate_guard.py" "$USER_HOME/.claude/content-gate/baseline.json"; do
  if [[ -e "$f" ]]; then sudo -u "$USER_NAME" mv "$f" "$OLD/"; fi
done

echo
ls -l "$DEST/hooks" "$DROPIN"
echo
echo "Done. Restart any open Claude Code sessions (including the VS Code extension)."
echo "Check it took: run /status in Claude Code and look for managed settings in the setting sources."
echo "Backup of your user settings: $SETTINGS.bak-$STAMP"
