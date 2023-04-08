# This should return a package.
# maybe later it will be something else (a flake module or whatever)
# but until it's shown to be needed let's KISS 😳

{ pkgs, ... }: pkgs.symlinkJoin { 
  name = "cli-basics";
  paths = with pkgs; [
    fd
    bottom
    fzf
    rg
    # in future, this should be my customized helix, because why not
    hx
    # (pkgScript "exec-with-pwd" {
    #   inputs = [pkgs.sway pkgs.jq pkgs.awk];
    # })
  ];
}
