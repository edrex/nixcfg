## Next

- [ ] Establish a format for "profiles" (what I'm calling packages that are just compositions of other packages (via symLinkJoin).
  ./profiles/cli/default.nix
  I like keeping them as "just plain packages", and wrapping them when more is needed (nixos config, etc) because then they can be consumed anywhere.


## Future

- [ ] Get emacs config into nix via https://github.com/nix-community/nix-doom-emacs
  This approach generates a package from my doom config.
  Why emacs, given I have switched my editing to Helix? I haven't found anything to replace magit.
  Lots of poor clones etc.
- Builder (github action?)
- Cachix

  