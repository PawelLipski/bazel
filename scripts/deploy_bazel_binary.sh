#!/usr/bin/env bash

# To use this script, you need to fill in the following inputs
# Please run this from the bazel repo root

########### INPUTS ##########

# You can get it here https://artifactory.d.musta.ch/artifactory/webapp/#/profile
API_KEY=FILL_IN
VERSION=FILL_IN
# UNCOMMENT OUT ONE OF THE BELOW
#PLATFORM=darwin-x86_64
#PLATFORM=darwin-arm64
#PLATFORM=linux-x86_64

########### END OF INPUTS ##########


########### CONSTANTS #########

ARTIFACTORY_URL="https://artifactory.d.musta.ch/artifactory"
PACKAGE_FOLDER="generic-airbnb/airbnb/bazel/releases/download"

########### END OF CONSTANTS ###########

ARTIFACTORY_FILENAME=bazel-$VERSION-$PLATFORM
LOCAL_FILE=bazel-bin/src/bazel

#bazel build -c opt //src:bazel --incompatible_restrict_string_escapes=false
curl --header "X-JFrog-Art-Api: $API_KEY" \
    -X PUT $ARTIFACTORY_URL/$PACKAGE_FOLDER/$VERSION/$ARTIFACTORY_FILENAME \
    --data-binary $LOCAL_FILE
