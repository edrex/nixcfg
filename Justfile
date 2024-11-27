all: update os home

os:
  nh os switch .

home:
  nh home switch .

# nix registry is pinned to the store paths of the inputs to this flake,
# so this affects all builds without their own locking.
update:
  nix flake update

test:
  nh os test .

clean:
  cmd/clean-nix-profiles
