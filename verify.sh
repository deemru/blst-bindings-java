#!/bin/bash
set -e

if [ ! -d blst/bindings ]; then
    echo "Error: blst/bindings not found. Run build.sh first." >&2
    exit 1
fi

rm -rf verify/gen verify/out
mkdir -p verify/gen/supranational/blst verify/out

swig -c++ -java -package supranational.blst \
  -outdir verify/gen/supranational/blst \
  -o /dev/null blst/bindings/blst.swg

javac -d verify/out \
  verify/gen/supranational/blst/*.java \
  verify/BLSTVerify.java

java -cp verify/out BLSTVerify
