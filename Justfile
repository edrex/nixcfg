all: update host home

host:
  nh os switch .

home:
  nh home switch .

# nix registry is pinned to the store paths of the inputs to this flake,
# so this affects all builds without their own locking.
update:
  nix flake update

gc:
  cmd/clean-nix-profiles
