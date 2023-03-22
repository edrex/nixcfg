{
   nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" "https://helix.cachix.org" ];
    extra-trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url =  "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    devenv.url = github:cachix/devenv;
    
    nil = {
      url = "github:oxalica/nil";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    helix.url = "github:helix-editor/helix";
  };

  outputs = inputs@{ flake-parts, ... }:
    let
      localOverlay = import ./overlay.nix { inherit inputs; };
    in flake-parts.lib.mkFlake { inherit inputs; } rec {
      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: rec {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            localOverlay
          ];
        };
        # this allows nix shell to work
        packages.default = devShells.default;
        devShells.default = inputs.devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [ ./devenv.nix ];
        };
        legacyPackages.homeConfigurations.edrex = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home ];
        };
      };
      flake = {
        nixosConfigurations = import ./nixos/hosts { inherit inputs localOverlay; };
      };
    };
}