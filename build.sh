#!/bin/bash
set -e

DEFAULT_TAG=v0.3.15

if [ -n "$1" ]; then
    TAG=$1
    shift
    echo "Using tag from argument: $TAG"
elif [ -n "$GITHUB_REF_NAME" ] && [[ "$GITHUB_REF_NAME" == v* ]]; then
    TAG="v$(echo "${GITHUB_REF_NAME#v}" | cut -d. -f1-3)"
    echo "Using tag from GITHUB_REF_NAME=$GITHUB_REF_NAME: $TAG"
else
    TAG=$DEFAULT_TAG
    echo "Using default tag: $TAG"
fi

for cmd in git swig gcc g++ javac jar; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "Missing: $cmd. Installing dependencies..." >&2
        sudo apt-get update
        sudo apt-get install -y git swig gcc g++ default-jdk
        break
    fi
done

rm -rf blst
git clone --config core.autocrlf=false --depth 1 --branch "$TAG" https://github.com/supranational/blst blst

cd blst/bindings/java
bash build.sh "$@"
cd ../../..

LIB=$(find blst/bindings/java/supranational -type f -name "libblst.so" | head -1)

if [ -z "$LIB" ]; then
    echo "Error: libblst.so not found" >&2
    exit 1
fi

sudo cp "$LIB" /usr/lib/
sudo ldconfig

echo "Installed: $(basename "$LIB") -> /usr/lib/"
