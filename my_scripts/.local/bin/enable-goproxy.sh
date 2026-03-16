#!/usr/bin/env bash

trap 'rm -rf "$TEMPDIR"' EXIT
TEMPDIR=$(mktemp -d -t goproxy.cache.XXXXXX) || exit 1
echo $TEMPDIR

# Usage of $HOME/goproxy/bin/goproxy:
#     -cacheDir string
#         go modules cache dir
#     -exclude string
#         exclude host pattern
#     -listen string
#         service listen address (default "0.0.0.0:8081")
#     -proxy string
#         next hop proxy for go modules
if ! pgrep -f goproxy ; then
    $HOME/goproxy/bin/goproxy \
       -listen="0.0.0.0:9999" \
       -cacheDir=$TEMPDIR \
       -proxy https://goproxy.io \
       -exclude ""
fi
