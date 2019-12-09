#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
"$SCRIPT_DIR"/docker-build.sh
docker run --rm -w /project -v "$SCRIPT_DIR"/..:/project dlang/python-nanomsg make -j"$(nproc)" -C /project
