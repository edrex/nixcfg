{ inputs, localOverlay }:
let
  mkSystem = { host, system ? "x86_64-linux", extra-modules ? []}:
    inputs.nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        inputs.nixos-cosmic.nixosModules.default

        ../modules
        ({ pkgs, ... }: {  
          nix = {
            package = pkgs.nixVersions.latest;
            # readOnlyStore = false;
            settings = {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
              auto-optimise-store = true;
              sandbox = true;
              trusted-users = [ "@wheel" ];
            };
        
            extraOptions = ''
              experimental-features = nix-command flakes auto-allocate-uids
              auto-allocate-uids = true
              # keep-outputs = true
              # keep-derivations = true
            '';
            gc = {
              automatic = true;
              dates = "03:15";
            };
            # point nixpkgs registry entry at a pre-fetched store path
            # WARNING: this will result in nix flake update using the local version
            # which may be bad. Still, offline mode wins.
            registry.nixpkgs.flake = inputs.nixpkgs;
          };
          nixpkgs = {
            overlays = [
              # inputs.agenix.overlays.default
              # inputs.emacs-overlay.overlay
              localOverlay
            ];
            config = {
              allowUnfree = true;
            };
          };
        })
        (./${host}/configuration.nix)
        (../users/edrex.nix)
      ] ++ extra-modules;
      specialArgs = { inherit inputs; };
    };
in {
  chip = mkSystem {
    host = "chip";
    # if I bring this inside the main module, it causes infinite recursion
    extra-modules = [ inputs.nixos-hardware.nixosModules.dell-xps-13-9360 ];
  };
  minion = mkSystem {
    host = "minion";
  };
  # pidrive = mkSystem {
  #   host = "pidrive";
  #   system = "aarch64-linux";
  # };
  # whitecanyon = mkSystem {
  #   host = "whitecanyon";
  #   system = "aarch64-linux";
  # };
  # silversurfer = mkSystem {
  #   host = "silversurfer";
  #   #TODO: inputs.nixos-hardware.nixosModules.apple-macbook-pro-2-2
  # };
}
