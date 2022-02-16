#!/usr/bin/env bash

# To use this script, you need to fill in the following inputs
# Please run this from the bazel repo root

########### INPUTS ##########

# Log into artifactory, then visit your user profile at:
# https://artifactory.d.musta.ch/artifactory/webapp/#/profile
# to get your API Key
API_KEY=FILL_IN

echo "Using API Key: $API_KEY"
# Bump this when you want to push
VERSION=4.1.4
echo "Deploying bazel artifact version $VERSION"

########### CALCULATE PLATFORM ##########
grep_linux=$(uname -s | grep -i linux)
grep_darwin=$(uname -s | grep -i darwin)
grep_x86_64=$(uname -m | grep -i x86_64)
grep_arm64=$(uname -m | grep -i arm64)
if [[ -n $grep_linux ]] && [[ -n $grep_x86_64 ]]; then
    PLATFORM=linux-x86_64
elif [[ -n $grep_darwin ]] && [[ -n $grep_x86_64 ]]; then
    PLATFORM=darwin-x86_64
elif [[ -n $grep_darwin ]] && [[ -n $grep_arm64 ]]; then
    PLATFORM=darwin-arm64
else
    echo "$(uname -s) $(uname -m) is not a supported platform"
    exit 1
fi

echo "PLATFORM is inferred to be $PLATFORM"

########### END OF INPUTS ##########


########### CONSTANTS #########

ARTIFACTORY_URL="https://artifactory.d.musta.ch/artifactory"
PACKAGE_FOLDER="generic-airbnb/airbnb/bazel/releases/download"

########### END OF CONSTANTS ###########

ARTIFACTORY_FILENAME=bazel-$VERSION-$PLATFORM
LOCAL_FILE=bazel-bin/src/bazel

bazel build -c opt //src:bazel --incompatible_restrict_string_escapes=false
curl --header "X-JFrog-Art-Api: $API_KEY" \
    -X PUT $ARTIFACTORY_URL/$PACKAGE_FOLDER/$VERSION/$ARTIFACTORY_FILENAME \
    --data-binary $LOCAL_FILE
