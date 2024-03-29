{ pkgs, lib, ... }: {
  imports =
    [
      ./graphical-shell
      ./devtools
      ./lang/python.nix
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

  # default because hm state somehow sets this
  home.stateVersion = lib.mkDefault "21.11";

  home.sessionVariables = {
    PATH = "$HOME/cmd:$PATH";
  };

  home.packages = with pkgs; [
    # TODO: sort these into other modules 
    bottom
    gh
    pass
    fishPlugins.foreign-env # fenv command
    gnupg
    fzf
  ];

  services = {
    gnome-keyring.enable = true;
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryFlavor = "gnome3";
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

