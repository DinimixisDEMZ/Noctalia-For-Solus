#!/bin/bash

# Configuration of paths
mkdir -p "$(pwd)/Releases"
DEST="$(pwd)/Releases"

TAG_NAME="Dini-$(date +%s)"
RELEASE_NAME="DinimixisDEMZ-$(date +%s)"

FILES=$(find /home/runner -maxdepth 1 -name "*.eopkg" -print -quit)

if [ -n "$FILES" ]; then
    find /home/runner -maxdepth 1 -name "*.eopkg" -exec cp -t "$DEST/" {} +
    echo "File(s) copied to $DEST"
else
    echo "No .eopkg files found to copy. Skipping..."
fi

for file in "$(pwd)/Releases/"*.eopkg; do
    if [ -e "$file" ]; then
        PACKAGE_FILE=$(basename "$file")
        echo "Package detected: $PACKAGE_FILE"
        break
    else
        echo "There is no .eopkg file in Releases."
        PACKAGE_FILE=""
    fi
done

echo "File detected: $PACKAGE_FILE"
cd "$(pwd)/Releases/"

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
if [ -z "$PACKAGE_FILE" ]; then
    echo "There is no .eopkg file in Releases. Skipping release."
    exit 0
elif [ -z "$GIT_TOKEN" ]; then
    echo "GIT_TOKEN not found. Skipping release."
    exit 0
else
    echo "Package detected: $PACKAGE_FILE. Proceeding to create release..."

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