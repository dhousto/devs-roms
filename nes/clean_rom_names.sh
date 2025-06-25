#!/bin/bash

# Set to the directory containing your ROM files
ROM_DIR="./"

# Change to that directory
cd "$ROM_DIR" || exit 1

# Loop through all relevant ROM files
for file in *.{smc,sfc,fig,nes}; do
    # Skip if no matching files
    [ -e "$file" ] || continue

    # Extract base name and extension
    base="${file%.*}"
    ext="${file##*.}"

    # Remove all trailing (...) and [...] groups
    clean_name=$(echo "$base" | sed -E 's/[[:space:]]*[\(\[].*[\)\]]*$//g')

    # Construct new file name
    new_name="${clean_name}.${ext}"

    # Rename the file if it changed
    if [[ "$file" != "$new_name" ]]; then
        echo "Renaming: $file -> $new_name"
        mv -i "$file" "$new_name"
    fi
done

