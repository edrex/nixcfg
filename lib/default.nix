{ config, pkgs, lib, ... }:
let
  # https://www.ertt.ca/nix/shell-scripts/
  pkgScript = path: args:
    resholve.writeScriptBin name args (builtins.readFile (./cmd + "/${name}"));
  pkgCmd = name:
    pkgs.writeScriptBin name (builtins.readFile (./cmd + "/${name}"));
  
