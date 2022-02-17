#!/usr/bin/env bash


# To use this script, you need to fill in the following inputs
# Please run this from the bazel repo root

########### INPUTS ##########

if [[ -z $API_KEY ]]; then
    RED='\033[0;31m'
    NC='\033[0m' # No Color
    # echo -e enables backslash escapes, which are required for colors
    echo -e "${RED}API_KEY is not set"
    echo "Log into artifactory, then visit your user profile at:"
    echo "https://artifactory.d.musta.ch/artifactory/webapp/#/profile"
    echo "Then rerun this script with the API_KEY set."
    echo -e "I.e. export API_KEY=<YOUR API KEY> ${NC}"
    exit 1
fi

echo "Using API Key: $API_KEY"
# Don't forget to bump this
VERSION="5.0.1"
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

#exit when any command fails
set -e

bazel build -c opt //src:bazel --java_language_version=11
curl --header "X-JFrog-Art-Api: $API_KEY" \
    -X PUT $ARTIFACTORY_URL/$PACKAGE_FOLDER/$VERSION/$ARTIFACTORY_FILENAME \
    --data-binary @"$LOCAL_FILE"
