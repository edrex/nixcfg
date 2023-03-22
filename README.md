# edrex's nix env configs

This repo contains my nix environment configs: nixos, home-manager, and later things like nix-on-droid, darwin, etc.

## Goals


## Principles

- Maximize reusability.
  - Don't make a home manager module when a simple wrapper package will do
- Evolve this repo incrementally, rather than trying to start over when I decide to try a different approach. I've gotten in a stuck "in-between" state too many times this way.


## Current wishlist

- [ ] The `nix profile` CLI has a terrible UX. Wrap it.


## Fresh install from Live USB:

- `nixos-generate-config --root /mnt`
- Check out this repo to `/mnt/etc/nixos`
- `nixos-install --flake /mnt/etc/nixos#chip`

## Ideas

It would be nice if nixConfig was inherited from inputs.
Idea: generate flake.nix, walking input tree?
