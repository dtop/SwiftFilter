#! /bin/bash

TEST_CMD="xcodebuild -project SwiftFilter.xcodeproj -scheme SwiftFilter -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 6S,OS=9.1' test"

which -s xcpretty
XCPRETTY_INSTALLED=$?

if [[ $TRAVIS || $XCPRETTY_INSTALLED == 0 ]]; then
  eval "${TEST_CMD} | xcpretty"
else
  eval "$TEST_CMD"
fi
