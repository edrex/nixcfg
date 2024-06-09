{ inputs, ... }: (final: prev:
    let
      system = prev.stdenv.system;
      # nixpkgs-master = import inputs.nixpkgs-master {
      #   inherit system;
      #   config.allowUnfree = true;
      # };
    in {
      # use helix HEAD (with helix bin cache)
      # helix =
      #   if system == "x86_64-linux"
      #   then inputs.helix.outputs.packages.${system}.helix 
      #   else prev.helix;
  })
