#!/bin/sh
set -xe
export NIX_CONFIG="experimental-features = nix-command flakes"
nix run github:nix-community/disko -- --mode destroy,format,mount --yes-wipe-all-disks ./server/disko
nixos-install --flake ./server#server
