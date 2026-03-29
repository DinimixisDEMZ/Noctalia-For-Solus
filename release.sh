#!/bin/bash

# Configuration of paths
SOURCE="/home/build/work/"
DEST="$(pwd)/Noctalia-For-Solus/Releases"

TAG_NAME="Dini-$(date +%s)"
RELEASE_NAME="DinimixisDEMZ-$(date +%s)"

echo "Searching for packages in $SOURCE..."

# Debug
ls -l "$SOURCE"

if [ -d "$SOURCE" ]; then

    FILES=$(find "$SOURCE" -maxdepth 1 -name "*.eopkg")

    if [ -n "$FILES" ]; then
        mkdir -p "$DEST"
        cp "$SOURCE"/*.eopkg "$DEST/"
        echo "✅ Files copied to $DEST"
        
    else
        echo "❌ No se encontraron archivos .eopkg en $SOURCE"
        exit 1
    fi
else
    echo "❌ Error: La ruta $SOURCE no existe en este entorno."
    exit 1
fi

PACKAGE_FILE="$(pwd)/Noctalia-For-Solus/Releases"/*.eopkg
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
