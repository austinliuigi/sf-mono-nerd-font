#!/usr/bin/env nix-shell
#!nix-shell -i bash -p jq

# this logic was taken from https://github.com/NixOS/nixpkgs/blob/nixos-23.11/pkgs/data/fonts/nerdfonts/update.sh

latest_release=$(curl --silent https://api.github.com/repos/epk/SF-Mono-Nerd-Font/releases/latest)
version=$(jq -r '.tag_name' <<<"$latest_release")

echo "dirname: $0"
dirname="$(dirname "$0")"
echo \""${version}"\" >"$dirname/version-new.nix"
if diff -q "$dirname/version-new.nix" "$dirname/version.nix"; then
    echo No new version available, current: $version
    exit 0
else
    echo Updated to version "$version"
    mv "$dirname/version-new.nix" "$dirname/version.nix"
fi
