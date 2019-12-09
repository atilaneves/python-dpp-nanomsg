#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"
"$SCRIPT_DIR"/docker-build.sh

docker run --rm -v "$SCRIPT_DIR"/..:/project -it dlang/python-nanomsg /bin/bash
