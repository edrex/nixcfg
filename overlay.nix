{ inputs, ... }: (final: prev:
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
  })
