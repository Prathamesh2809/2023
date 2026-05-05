#!/bin/bash

echo "==== Testing package.json change detection ===="

# Simulate what the deploy script does
PREV_HASH=$(git show HEAD~1:package.json 2>/dev/null | md5sum | awk '{print $1}' || echo "none")
NEW_HASH=$(git show HEAD:package.json 2>/dev/null | md5sum | awk '{print $1}' || echo "none")

echo "Previous hash: $PREV_HASH"
echo "New hash:      $NEW_HASH"

if [ "$PREV_HASH" != "$NEW_HASH" ]; then
  echo "✅ package.json changed! Running npm ci..."
  npm ci
else
  echo "⏭️  package.json unchanged. Skipping npm ci."
fi
