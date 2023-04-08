{ self, ... }: {
  imports = [
    ./editor/helix.nix
    ./fish.nix
  ];
  perSystem = { config, self', inputs', pkgs, ... }:
  {
    packageSets.home = with pkgs; [
      # https://jvns.ca/blog/2022/04/12/a-list-of-new-ish--command-line-tools/
      # nav
      ranger
      highlight # needed for ranger highlighting
      # TODO set HIGHLIGHT_STYLE=andes
      # TODO evaluate tmsu, ansi tool

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

      #termcast
      termtosvg # https://github.com/nbedos/termtosvg
    ];
  };
}