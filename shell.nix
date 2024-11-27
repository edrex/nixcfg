{ pkgs ? import <nixpkgs> {}}:

pkgs.mkShell {
  packages = with pkgs; [ 
    #nixd
    nh
    hydra-check
  ];
}
