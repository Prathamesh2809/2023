#!/bin/bash

# Mocking the GitHub Actions inputs
DEPLOY_TAG="v1.1.0"
DEPLOY_ENVIRONMENT="staging" # or "secondstaging"

echo "--- STARTING LOCAL TEST ---"

# 1. Get the previous tag
if [ -f .current_tag ]; then
    PREV_TAG=$(cat .current_tag)
else
    echo "Error: .current_tag not found!"
    exit 1
fi

echo "Currently deployed tag: $PREV_TAG"
echo "Deploying new tag: $DEPLOY_TAG"

# 2. Simulate the Git Reset
git reset -q --hard "$DEPLOY_TAG"
echo "$DEPLOY_TAG" > .current_tag

# 3. Test the Diff Logic
# Note: This will only echo 'npm install' if package.json actually changed
if git diff --name-only "$PREV_TAG" "$DEPLOY_TAG" | grep -E "package.json|package-lock.json"; then
  echo ">>> Changes in package files detected. (Mocking npm install)"
else
  echo ">>> No changes in package files. (Skipping npm install)"
fi

echo "--- TEST COMPLETE ---"
echo "Final state of .current_tag: $(cat .current_tag)"
