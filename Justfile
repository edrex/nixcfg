all: update host home

host:
  nh os switch .

home:
  nh home switch .
      
update:
  nix flake update --override-input nixpkgs nixpkgs

gc:
  cmd/clean-nix-profiles
