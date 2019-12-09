#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" > /dev/null && pwd )"

if [[ "$(docker images -q dlang/python-nanomsg 2> /dev/null)" == "" ]]; then
    docker build --no-cache --pull -t dlang/python-nanomsg "$SCRIPT_DIR"
fi
