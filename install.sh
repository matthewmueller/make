#!/bin/sh

INCLUDE_DIR="/usr/local/include/github.com/matthewmueller/make"
TMP_DIR=$(mktemp -d)

curl -sL https://github.com/matthewmueller/make/archive/master.tar.gz \
  | tar xz --strip-components=1  --include "*/*.mk" --include "*/config/" -C "${TMP_DIR}"

# clear old version
rm -rf "${INCLUDE_DIR}"
mv "${TMP_DIR}" "${INCLUDE_DIR}"
