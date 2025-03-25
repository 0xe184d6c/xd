#!/bin/bash

# Generate tree structure
if command -v tree &> /dev/null; then
  tree -I 'node_modules|.git|.cache' -a --noreport > docs/00_tree.txt
else
  find . -type d ! -path './node_modules*' ! -path './.git*' ! -path './.cache*' | \
    sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/" > docs/00_tree.txt
fi

# Generate flat directory listing
find "$(pwd)" -type f ! -path "*/node_modules/*" ! -path "*/.git/*" ! -path "*/.cache/*" | \
  sed 's|/home/runner/workspace/||' > docs/01_flat_dir.txt

# Record dependencies from package.json
jq -r '.dependencies' package.json > docs/dependencies.txt 2>/dev/null || {
  grep '"dependencies"' package.json | awk -F: '{print $2}' > docs/dependencies.txt
}

[[ -f package-lock.json ]] && echo "package-lock.json exists" >> docs/dependencies.txt
[[ -f yarn.lock ]] && echo "yarn.lock exists" >> docs/dependencies.txt
