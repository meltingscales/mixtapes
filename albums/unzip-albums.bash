#!/usr/bin/env bash
# makes sure all .zip files are unzipped.
# keeps .zip files.

set -euo pipefail

# Find all .zip files in current directory
shopt -s nullglob
zip_files=(*.zip)

if [ ${#zip_files[@]} -eq 0 ]; then
    echo "No .zip files found in current directory."
    exit 0
fi

echo "Found ${#zip_files[@]} .zip file(s)"

for zip_file in "${zip_files[@]}"; do
    # Get basename without extension
    dirname="${zip_file%.zip}"

    if [ -d "$dirname" ]; then
        echo "⏭️  Skipping $zip_file (directory '$dirname' already exists)"
        continue
    fi

    echo "📦 Extracting: $zip_file"

    # Create directory and extract into it
    mkdir -p "$dirname"
    unzip -q "$zip_file" -d "$dirname"

    echo "✓ Extracted to: $dirname/"
done

echo ""
echo "Done! All albums unzipped."
