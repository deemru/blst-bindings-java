#!/bin/bash
set -e

if [ ! -d blst/bindings ]; then
    echo "Error: blst/bindings not found. Run build.sh first." >&2
    exit 1
fi

if [ -z "$JAVA_HOME" ]; then
    JAVAC_PATH=$(readlink -f "$(command -v javac)")
    export JAVA_HOME="${JAVAC_PATH%/bin/javac}"
fi

rm -rf verify/gen verify/out
mkdir -p verify/gen/supranational/blst verify/out

swig -c++ -java -package supranational.blst \
  -outdir verify/gen/supranational/blst \
  -o /dev/null blst/bindings/blst.swg

"$JAVA_HOME"/bin/javac -d verify/out \
  verify/gen/supranational/blst/*.java \
  verify/BLSTVerify.java

"$JAVA_HOME"/bin/java -cp verify/out BLSTVerify
