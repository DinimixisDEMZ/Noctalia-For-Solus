#!/bin/bash

# Configuration of paths
SOURCE="/home/build/work"
DEST="$(pwd)/Noctalia-For-Solus/Releases"

TAG_NAME="Dini-$(date +%s)"
RELEASE_NAME="DinimixisDEMZ-$(date +%s)"

# Check if solbuild directory exists
if [[ -d "$SOURCE" ]]; then
    
    # Search for .eopkg files
    shopt -s nullglob
    files=("$SOURCE"/*.eopkg)
    
    if (( ${#files[@]} > 0 )); then
        # Make sure the destination exists
        mkdir -p "$DEST"
        
        # Move the files
        mv "$SOURCE"/*.eopkg "$DEST/"
        
        echo "${#files[@]} have been moved to $DEST"
    else
        echo "No .eopkg files found in $SOURCE"
    fi
else
    echo "Error: Route hasn't been detected: ($SOURCE)."
fi

PACKAGE_FILE="$(pwd)/Noctalia-For-Solus/Releases/*.eopkg"
FILE_SIZE=$(du -h "$PACKAGE_FILE" | cut -f1)
MD5_SUM=$(md5sum "$PACKAGE_FILE" | awk '{print $1}')

# Release body
RELEASE_BODY="#### 🌎 Download:
$PACKAGE_FILE

#### 📊 File Info:
• Size: $FILE_SIZE
• MD5: $MD5_SUM
"

# Convert to JSON-safe string
JSON_BODY=$(printf '%s' "$RELEASE_BODY" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')

# Create release
if [ -n "$GIT_TOKEN" ]; then
  echo "Creating GitHub release..."

  curl -X POST "https://api.github.com/repos/${GITHUB_REPOSITORY}/releases" \
    -H "Authorization: token $GIT_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
      \"tag_name\": \"$TAG_NAME\",
      \"name\": \"$RELEASE_NAME\",
      \"body\": $JSON_BODY,
      \"draft\": false,
      \"prerelease\": false
    }"
else
  echo "GIT_TOKEN not found. Skipping release."
fi
