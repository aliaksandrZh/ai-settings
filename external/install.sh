#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/config.sh"

if command -v claude >/dev/null 2>&1; then
    echo "Configuring Claude Code..."

    for marketplace in "${CLAUDE_MARKETPLACES[@]}"; do
        claude plugin marketplace add "$marketplace"
    done

    for plugin in "${CLAUDE_PLUGINS[@]}"; do
        claude plugin install "$plugin" --scope user
    done

    echo "Installing individual skills..."

    for entry in "${CLAUDE_SKILLS[@]}"; do
        IFS=: read -r repo skill <<< "$entry"

        npx -y skills@latest add "$repo" \
            --skill "$skill" \
            --agent claude-code \
            -g
    done
fi


# if command -v codex >/dev/null 2>&1; then
#     echo "Configuring Codex..."

#     for marketplace in "${CODEX_MARKETPLACES[@]}"; do
#         codex plugin marketplace add "$marketplace"
#     done
# fi

echo "Installation completed."