{ inputs, localOverlay }:
let
  mkSystem = { host, system ? "x86_64-linux", extra-modules ? []}:
    inputs.nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        ../modules
        ({ pkgs, ... }: {  
          nix = {
            # readOnlyStore = false;
            settings = {
              auto-optimise-store = true;
              sandbox = true;
              trusted-users = [ "@wheel" ];
            };
        
            extraOptions = ''
              experimental-features = nix-command flakes
              # keep-outputs = true
              # keep-derivations = true
            '';
            gc = {
              automatic = true;
              dates = "03:15";
            };
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