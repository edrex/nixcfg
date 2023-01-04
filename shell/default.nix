{ self, ... }: {
  imports = [
    # ./fish.nix
    ./hyprland.nix
  ];
  perSystem = { config, self', inputs', pkgs, ... }: let
    p = pkgs;
    helix = inputs'.helix.packages.helix;
  in {
    apps = [
      p.joshuto
      p.git
      p.gitui
      inputs'.helix.packages.helix
      p.gh
    ];
    # https://ryantm.github.io/nixpkgs/builders/trivial-builders/#trivial-builder-writeShellApplication
    packages.homeShell = pkgs.wrapFish {
      runtimeInputs = [
        p.joshuto
        p.git
        p.gitui
        inputs'.helix.packages.helix
        p.gh
      ];
      pluginPkgs = with pkgs.fishPlugins; [ pure foreign-env ];
      completionDirs = [];
      functionDirs = [];
      confDirs = [ "/path/to/some/fish/init/dir/" ];
    };
  };
}