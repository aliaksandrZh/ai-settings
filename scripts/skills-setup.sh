#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SKILLS_DIR="$REPO_ROOT/skills"
TARGET_DIR="$HOME/.claude/skills"

if [[ ! -d "$SKILLS_DIR" ]]; then
    echo "Error: Skills directory not found: $SKILLS_DIR"
    exit 1
fi

mkdir -p "$TARGET_DIR"

for source_path in "$SKILLS_DIR"/*; do
    [[ -e "$source_path" ]] || continue

    name="$(basename "$source_path")"
    target_path="$TARGET_DIR/$name"

    if [[ -L "$target_path" ]]; then
        if [[ "$(readlink "$target_path")" == "$source_path" ]]; then
            echo "Skill '$name' is already linked."
            continue
        fi
        rm "$target_path"
        ln -s "$source_path" "$target_path"
        echo "Relinked skill '$name' -> $source_path"
    elif [[ -e "$target_path" ]]; then
        echo "Warning: '$target_path' exists and is not a symlink. Skipped."
        continue
    else
        ln -s "$source_path" "$target_path"
        echo "Linked skill '$name' -> $source_path"
    fi
done
