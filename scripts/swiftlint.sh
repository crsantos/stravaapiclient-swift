#!/usr/bin/env bash
# Swiftlint script

echo "Starting Swiftlint: [root: ${PODS_ROOT}]"
#printenv
millis(){  python -c "import time; print(int(time.time()*1000))"; }
START_DATE=$(millis)

${SRCROOT}/Pods/SwiftLint/swiftlint

millis(){  python -c "import time; print(int(time.time()*1000))"; }
END_DATE=$(millis)
DURATION=$((END_DATE-START_DATE))
echo "Swiftlint Script Duration: $DURATION milliseconds"
