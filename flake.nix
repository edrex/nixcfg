{
  description = "edrex's flake";

  nixConfig = {
    extra-substituters = [
      "https://helix.cachix.org"
      # "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    helix.url = "github:helix-editor/helix/22.12";

    hyprland.url = "github:hyprwm/hyprland";
    hyprpaper.url = "github:hyprwm/hyprpaper";
  };
  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./home
        # ./shell/graphical
        # ./flow/write
        # inputs.foo.flakeModule
      ];
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        apps.default = self'.homeShell;
        # packages.default = pkgs.hello;
        # devShells = {
        #   hyprland = self'.devShells.hyprland;
        # };
      };
      flake = {
        # The usual flake attributes can be defined here, including system-
        # agnostic ones like nixosModule and system-enumerating ones, although
        # those are more easily expressed in perSystem.

      };
    };  
}
