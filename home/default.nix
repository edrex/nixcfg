{ pkgs, lib, ... }: {
  imports =
    [
      ./graphical-shell
      ./devtools
       # ./term
      # ./apps/vscode
      # ./apps/neovim.nix
      # ./apps/emacs
      # ./apps/helix.nix
      ./apps/browser.nix
      ./apps/term.nix
      # ./apps/comms.nix
    ];

  home.homeDirectory = "/home/edrex";
  home.username = "edrex";

  home.stateVersion = lib.mkDefault "21.11";

  home.packages = with pkgs; [
    # TODO: sort these into other modules 
    bottom
    # hledger
    # hledger-web
    gh
    pass
    fishPlugins.foreign-env # fenv command
    gnupg
    fzf
  ];

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
    syncthing = {
      enable = true;
      tray.enable = true;
    };
  };

  programs = {
    fish = {
      enable = true;
    };
  };
}

