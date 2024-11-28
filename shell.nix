{ pkgs ? import <nixpkgs> {}}:

pkgs.mkShell {
  packages = with pkgs; [ 
    nixd
    nh
    just
    hydra-check
  ];
}
