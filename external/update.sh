#!/usr/bin/env bash
set -euo pipefail

echo "Checking skill updates..."
npx -y skills check

# echo "Updating skills..."
# npx -y skills update -y

# echo "Updating Claude plugins..."
# claude plugin update --all

# echo "Update completed."