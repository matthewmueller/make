#!/bin/sh

mkdir -p /usr/local/include/github.com/matthewmueller/make
curl -sL https://github.com/matthewmueller/make/archive/master.tar.gz \
  | tar xz --strip-components=1  --include "*/*.mk" --include "*/config/" -C /usr/local/include/github.com/matthewmueller/make