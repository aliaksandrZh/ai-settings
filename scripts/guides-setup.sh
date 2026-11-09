
#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SOURCE_FILE="$SCRIPT_DIR/../guides/Main.md"
CLAUDE_DIR="$HOME/.claude"
TARGET_FILE="$CLAUDE_DIR/CLAUDE.md"

START_MARKER="<!-- BEGIN CLAUDE TOOLKIT -->"
END_MARKER="<!-- END CLAUDE TOOLKIT -->"

if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "Error: Guides file not found: $SOURCE_FILE"
    exit 1
fi

if [[ "$SOURCE_FILE" == *" "* ]]; then
    echo "Error: Repository path must not contain spaces."
    exit 1
fi

mkdir -p "$CLAUDE_DIR"

if [[ ! -f "$TARGET_FILE" ]]; then
    touch "$TARGET_FILE"
fi

START_COUNT=$(grep -Fxc "$START_MARKER" "$TARGET_FILE" || true)
END_COUNT=$(grep -Fxc "$END_MARKER" "$TARGET_FILE" || true)

if [[ "$START_COUNT" != "$END_COUNT" || "$START_COUNT" -gt 1 ]]; then
    echo "Error: Invalid or duplicate CLAUDE TOOLKIT markers."
    echo "Please inspect $TARGET_FILE manually."
    exit 1
fi

TEMP_FILE="$(mktemp "$CLAUDE_DIR/.CLAUDE.md.XXXXXX")"
trap 'rm -f "$TEMP_FILE"' EXIT

if [[ "$START_COUNT" == "1" ]]; then
    awk -v start="$START_MARKER" -v end="$END_MARKER" '
        $0 == start { skip = 1; next }
        $0 == end { skip = 0; next }
        !skip { print }
    ' "$TARGET_FILE" > "$TEMP_FILE"
else
    cat "$TARGET_FILE" > "$TEMP_FILE"
fi

if [[ -s "$TEMP_FILE" ]]; then
    printf '\n' >> "$TEMP_FILE"
fi

cat >> "$TEMP_FILE" <<EOF
<!-- BEGIN CLAUDE TOOLKIT -->
# Mandatory Global Instructions

The following files contain mandatory instructions governing your behavior.

@$SOURCE_FILE

You MUST follow these instructions in every task and throughout the entire session.

Before responding to a request or taking any action:

1. Consult the loaded instructions and identify all rules relevant to the current task.
2. Follow all applicable rules, including approval requirements and restrictions.
3. Do not treat these instructions as optional reference material.
4. If a rule is unclear, inaccessible, or conflicts with another instruction, stop and ask the user for clarification.
5. Never skip a rule because you consider it irrelevant without first evaluating its applicability.

These instructions apply to all projects, tasks, tools, and delegated work.
<!-- END CLAUDE TOOLKIT -->
EOF

if cmp -s "$TARGET_FILE" "$TEMP_FILE"; then
    echo "Claude Code instructions are already up to date."
    exit 0
fi

BACKUP_FILE="$TARGET_FILE.backup.$(date +%Y%m%d%H%M%S)"

cp -p "$TARGET_FILE" "$BACKUP_FILE"
cat "$TEMP_FILE" > "$TARGET_FILE"

echo "Claude Code global instructions configured successfully."
echo "Source: $SOURCE_FILE"
echo "Target: $TARGET_FILE"
echo "Backup: $BACKUP_FILE"
