#!/bin/bash

# Check if inside a git repo
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Not a git repository."
    exit 1
fi

# Loop over all files
for file in $(git ls-files --others --exclude-standard) $(git ls-files); do
    # Skip directories
    [ -d "$file" ] && continue

    echo "Processing $file..."
    git add "$file"
    git commit -m "Update $file"
done

# Push all commits once
git push
echo "All files committed individually and pushed."
