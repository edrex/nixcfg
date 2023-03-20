{
  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" "https://helix.cachix.org" ];
    extra-trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url =  "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    agenix.url = "github:ryantm/agenix"; # consider switching to sops-nix
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    nil = {
      url = "github:oxalica/nil";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    helix.url = "github:helix-editor/helix";
    # emacs-overlay = {
    #   url = "github:nix-community/emacs-overlay";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     flake-utils.follows = "flake-utils";
    #   };
    # };

  };

  outputs = inputs:
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
      mkSystem = { host, system ? "x86_64-linux", extra-modules ? []}:
        let
          lib = inputs.nixpkgs.lib;
        in
          lib.nixosSystem {
            system = system;
            modules = [
              ./nixos/modules
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
                    inputs.agenix.overlays.default
                    # inputs.emacs-overlay.overlay
                    localOverlay
                  ];
                  config = {
                    allowUnfree = true;
                  };
                };
              })
              (./nixos/hosts/${host}/configuration.nix)
              (./nixos/users/edrex.nix)
              inputs.agenix.nixosModules.age
            ] ++ extra-modules;
            specialArgs = { inherit inputs; };
          };
    in {
      homeConfigurations = {
        edrex = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs {
            # TODO: this should be perSystem, somehow
            system = "x86_64-linux";
            overlays = [ localOverlay ];
          };
          modules = [ ./home ];
        };
      };
      nixosConfigurations = {
        chip = mkSystem {
          host = "chip";
          extra-modules = [ inputs.nixos-hardware.nixosModules.dell-xps-13-9360 ];
        };
        pidrive = mkSystem {
          host = "pidrive";
          system = "aarch64-linux";
        };
        whitecanyon = mkSystem {
          host = "whitecanyon";
          system = "aarch64-linux";
        };
        silversurfer = mkSystem {
          host = "silversurfer";
          #TODO: inputs.nixos-hardware.nixosModules.apple-macbook-pro-2-2
        };
      };
    };
}