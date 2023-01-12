{ self, ... }: {
  imports = [
    ./editor/helix.nix
    ./fish.nix
  ];
  perSystem = { config, self', inputs', pkgs, ... }:
  {
    apps = with pkgs; [
      # nav
      ranger

      # search
      fzf
      zoxide
      fd
      ripgrep

      # util 
      choose
      exa

      # file
      bat

      # versions
      git
      gitui
      gh
      delta
    ];
  };
}