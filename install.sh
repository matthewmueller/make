#!/bin/sh

mkdir -p /usr/local/include/github.com/matthewmueller/make
curl -sL https://github.com/matthewmueller/make/archive/master.tar.gz \
  | tar xz --exclude=test.sh --strip-components=1 -C /usr/local/include/github.com/matthewmueller/make
