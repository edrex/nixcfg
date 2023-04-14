## Fri Apr 14 06:24:52 AM PDT 2023 Trip Prep

- x Shut down bookmobile, figure out which is gonas, unplug it
- x Log into afraid, get domain refresh info for mooo or whatever
  - greencastle.mooo.com
- Set up refresh script on prism router
- Port forward SSH to bookmobile, minion
  - bookmobile
    - ssh :2201
  - minion
    - ssh :2203
    - HTTP
    - HTTPS
- Test external access via phone tether of dip
  - ssh bookmobile works
  - ssh minion doesn't
    - nothing in `journalctl`
    - try with chip
- Test kopia over remote link
- Start asset inventory (orgmode or Markdown, start as Markdown since I don't have org tooling setup ATM)
  - write down essential info
  - Secrets in personal store, under host/ subdir
- Dump browser tabs into journal for sync
- one last kopia snapshot



## Later

- Directory per-host
- Include nixos config in this directory for nixos hosts
- Add all secrets here, instead of on the other host
  Feel weird about secrets cyphertext in public repo. How about a seperate repo, git submodule, symlinks? That seems like a good soln.
- Make a list of supporting station keepers, so I can support them with money and also so future users of my thing can see who to support.
  - afraid.org

# Asset Inventory
- Dedicated namespace
- Intermingled/layered with config? I think yes.
## Hosts
### Chip
### Dip
### Minion
### Bookmobile
### Gonas
### vm-do-web1
## ExternalService
List what depends on them (actually, reverse) eg Host, Site, Service
- Afraid.org
- Digitalocean

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

  