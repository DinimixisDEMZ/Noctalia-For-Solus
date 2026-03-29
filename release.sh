#!/bin/bash

# Configuration of paths
mkdir -p "$(pwd)/Releases"
DEST="$(pwd)/Releases"

TAG_NAME="Dini-$(date +%s)"
RELEASE_NAME="DinimixisDEMZ-$(date +%s)"

PACKAGE_PATH=$(find . -maxdepth 2 -name "*.eopkg" -print -quit)

if [ -n "$PACKAGE_PATH" ]; then
    PACKAGE_FILE=$(basename "$PACKAGE_PATH")
    echo "✅ Package detected: $PACKAGE_FILE in the path $PACKAGE_PATH"
    
    DEST="./Releases"
    mkdir -p "$DEST"
    
    if [ "$PACKAGE_PATH" != "$DEST/$PACKAGE_FILE" ]; then
        cp "$PACKAGE_PATH" "$DEST/"
        echo "File copied to $DEST"
    fi
else
    echo "❌ No .eopkg file found. Aborting release."
    exit 0
fi

SIZE=$(du -h "$DEST/$PACKAGE_FILE" | cut -f1)
MD5=$(md5sum "$DEST/$PACKAGE_FILE" | cut -d' ' -f1)

echo "Info: Size $SIZE, MD5 $MD5"
echo "File detected: $PACKAGE_FILE"
cd "$(pwd)/Releases/"

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
fi