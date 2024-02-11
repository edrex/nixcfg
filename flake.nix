{
   nixConfig = {
    extra-substituters = [
      "https://helix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    
  };

  outputs = inputs@{ flake-parts, home-manager, nixos-hardware, helix, emacs-overlay, ... }:
    let
      lib = inputs.nixpkgs.lib;
      localOverlay = import ./overlay.nix { inherit inputs; };
    in flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: rec {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [ localOverlay ];
        };
        # a devShell is just an app, which is a runnable package
        packages = {
          # default = devShells.default;
          dev = devShells.default;
          p = pkgs.callPackage ./pkgs/p {};
        };
        devShells.default = inputs.devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [ ./devenv.nix ];
        };
        # home-manager --flake . switch
        legacyPackages.homeConfigurations.edrex = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home
            # make command-not-found work
            inputs.nix-index-database.hmModules.nix-index
            {
              # just stick all exported packages into home.packages, mm?
              # home.packages = lib.attrValues self'.packages;
              # enable `,` command eg `, fcgi-wrapper ..`
              programs.nix-index-database.comma.enable = true;
              # programs.nix-index.enable = true;
            }
          ];
        };
      };
      flake = {
        # todo: pass nixosModules in. probably surface individual hosts too.
        nixosConfigurations = import ./nixos/hosts { inherit inputs localOverlay; };
      };
    };
}
