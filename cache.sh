#!/usr/bin/env bash

dirname="$(dirname "$0")"
cd "$dirname"
nix build
install -m 644 result/version.txt cache
install -m 644 result/share/fonts/opentype/* cache/share/fonts/opentype
rm result
