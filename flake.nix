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
    
    nil = {
      url = "github:oxalica/nil";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
    helix.url = "github:helix-editor/helix";
  };

  outputs = inputs@{ flake-parts, ...}:
    let
      localOverlay = (final: prev:
        let
          system = prev.stdenv.system;
          # nixpkgs-master = import inputs.nixpkgs-master {
          #   inherit system;
          #   config.allowUnfree = true;
          # };
        in {
          pamixer-notify = final.callPackage ./pkgs/pamixer-notify.nix { };
          helix =
            if system == "x86_64-linux"
            then inputs.helix.outputs.packages.${system}.helix 
            else prev.helix;
      });
    in flake-parts.lib.mkFlake { inherit inputs; } rec {
      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
      };
      flake = let
        lib = inputs.nixpkgs.lib;
        sysKeys = builtins.listToAttrs ( builtins.map (v: {name = v; value = null; }) systems);
        eachSys = f: (lib.attrsets.mapAttrs (k: v: f k) sysKeys);
      in {
        nixosConfigurations = import ./nixos/hosts { inherit inputs localOverlay; };
        legacyPackages = eachSys ( system: {
          homeConfigurations.edrex = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = [ localOverlay ];
            };
            modules = [ ./home ];
          };
        });
      };
    };
}