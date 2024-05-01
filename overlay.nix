{ inputs, ... }: (final: prev:
    let
      system = prev.stdenv.system;
      # nixpkgs-master = import inputs.nixpkgs-master {
      #   inherit system;
      #   config.allowUnfree = true;
      # };
    in {
      pamixer-notify = final.callPackage ./pkgs/pamixer-notify.nix { };

      way-displays = prev.way-displays.overrideAttrs (prev: {
        version = "git";
        src = final.fetchFromGitHub {
          owner = "alex-courtis";
          repo = "way-displays";
          rev = "04cff0a4b0b971c5c08c002efa78b4059480db02";
          sha256 = "sha256-ZQD7nXXL4ZiWCn0St3RaEZLWwhcNryn+JbmGV2Klf/I=";
        };
      });
      emacs = inputs.emacs-overlay.outputs.packages.${system}.emacsUnstablePgtk;
      helix =
        if system == "x86_64-linux"
        then inputs.helix.outputs.packages.${system}.helix 
        else prev.helix;
  })
