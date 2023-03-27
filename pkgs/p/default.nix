{ pkgs, ... }:
let
  # https://www.ertt.ca/nix/shell-scripts/
  # pkgScript = name: args:
  #   resholve.writeScriptBin name args (builtins.readFile (./cmd + "/${name}"));
  pkgCmd = cmd: pkgs.writeScriptBin (baseNameOf cmd) (builtins.readFile (cmd));
  
in pkgs.symlinkJoin { 
  name = "p";
  paths = [
    (pkgCmd ./cmd/workon)
    # (pkgScript "exec-with-pwd" {
    #   inputs = [pkgs.sway pkgs.jq pkgs.awk];
    # })
  ];
}
