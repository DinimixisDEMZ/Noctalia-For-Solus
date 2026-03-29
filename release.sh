#!/bin/bash

# Configuration of paths
mkdir -p "$(pwd)/Releases"
DEST="$(pwd)/Releases"

TAG_NAME="Dini-$(date +%s)"
RELEASE_NAME="DinimixisDEMZ-$(date +%s)"

find . -maxdepth 1 -name "*.eopkg" -exec cp -t "$DEST/" {} +
echo "File copied to $DEST"

pkgs=("$(pwd)/Releases/"*.eopkg)

if [ -e "${pkgs[0]}" ]; then
    PACKAGE_FILE=$(basename "${pkgs[0]}")
    echo "Paquete detectado: $PACKAGE_FILE"
else
    echo "No se encontraron archivos .eopkg en la carpeta Releases."
fi

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
