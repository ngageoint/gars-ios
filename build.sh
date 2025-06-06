#!/bin/bash

set -e

# Find iPhone Simulator
iphone_names=$(xcrun simctl list devices available --json | jq -r '.devices | to_entries[] | .value[] | select(.name | test("^iPhone [0-9]+")) | .name')
if [ -z "$iphone_names" ]; then echo "Error: No iPhone simulators found."; exit 1; fi

latest_iphone=$(echo "$iphone_names" | sort | tail -n 1)
echo "latest_iphone: $latest_iphone"

# Build
xcodebuild build -scheme GARS -destination "platform=iOS Simulator,OS=latest,name=$latest_iphone"

# Test
xcodebuild test -scheme GARS -destination "platform=iOS Simulator,OS=latest,name=$latest_iphone"      
