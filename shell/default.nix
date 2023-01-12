{ self, ... }: {
  imports = [
    # ./fish.nix
    # ./hyprland.nix
  ];
  perSystem = { config, self', inputs', pkgs, ... }: let
    p = pkgs;
    helix = inputs'.helix.packages.helix;
  in rec {
    apps = with pkgs; [
      inputs'.helix.packages.helix
      ranger
      fzf
      zoxide
      bat
      choose
      delta
      exa
      fd
      ripgrep
      git
      gitui
      gh
      
    ];
    # https://ryantm.github.io/nixpkgs/builders/trivial-builders/#trivial-builder-writeShellApplication
    packages.homeShell = pkgs.wrapFish {
      runtimeInputs = apps;
      pluginPkgs = with pkgs.fishPlugins; [ pure foreign-env ];
      completionDirs = [];
      functionDirs = [];
      confDirs = [ "/path/to/some/fish/init/dir/" ];
    };
  };
}