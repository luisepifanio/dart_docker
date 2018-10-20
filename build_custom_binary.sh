#!/usr/bin/env bash
# Build a Docker image with Dart using a specific .deb file.
#
# This is only used for testing with a custom build of Dart where
# an already built zip file is used.
#
#  tools/create_debian_chroot.sh

REPO_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

REPOSITORY_PREFIX=luisepifanio

CHANNEL="stable" #dev
RELEASE="$1"
PLATFORM="linux"
ARCH="arm64"


check_installed () {
  type "$1" > /dev/null 2>&1 || { echo >&2 "✖ program/command '$1' is required but it's not installed.  Aborting."; return 1; }
}

if [ $# -lt 1 ] || [ $# -gt 1 ]
then
  RELEASE="2.0.0"
fi

check_installed 'wget'
check_installed 'unzip'

echo "
Building custom binary image with:

CHANNEL=$CHANNEL
RELEASE=$RELEASE
PLATFORM=$PLATFORM
ARCH=$PLATFORM
"

mkdir "$REPO_ROOT/custom_binary"
wget --continue -O "dartsdk.binary.zip" "https://storage.googleapis.com/dart-archive/channels/$CHANNEL/release/$RELEASE/sdk/dartsdk-$PLATFORM-$ARCH-release.zip"

if [ "$?" != 0 ]; then
  echo "Error downloading file"
  exit
fi

unzip -q "dartsdk.binary.zip" -d "$REPO_ROOT/custom_binary"

docker build -t $REPOSITORY_PREFIX/dart $REPO_ROOT/custom_binary
docker tag $REPOSITORY_PREFIX/dart $REPOSITORY_PREFIX/dart-custom-binary

rm -rf "$REPO_ROOT/custom_binary/dart-sdk"
rm "dartsdk.binary.zip"