#!/bin/sh
sudo nix --extra-experimental-features "nix-command flakes" \
     run "github:nix-community/disko/latest#disko-install" -- \
     --flake .#server \
     --disk main /dev/sda
