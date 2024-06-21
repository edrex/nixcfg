{ pkgs, lib, ... }: {
  imports =
    [
      ./graphical-shell
      ./devtools
      ./lang/python.nix
       # ./term
      # ./apps/vscode
      # ./apps/neovim.nix
      ./apps/emacs
      # ./apps/helix.nix
      ./apps/browser.nix
      ./apps/term.nix
      ./apps/comms.nix
    ];

  home.homeDirectory = "/home/edrex";
  home.username = "edrex";

  # default because hm state somehow sets this
  home.stateVersion = lib.mkDefault "21.11";

  # home.sessionVariables = {
    # PATH = "$HOME/cmd:$PATH";
  # };

  home.sessionPath = [
    "$HOME/cmd"
    "$HOME/.config/emacs/bin" # doom emacs scripts
  ];
  
  home.packages = with pkgs; [
    # TODO: sort these into other modules 
    bottom
    gh
    pass
    fishPlugins.foreign-env # fenv command
    gnupg
    fzf
    yadm
    # dumped from user profile, need to sort
    git-filter-repo
    home-manager
    
    gron
    # unrar #unfree
    unzip
    tydra
    just
    gum
    ani-cli
    transmission-gtk
    mpv
    termtosvg
    sshx
    ruby
    ripgrep
    ranger
    qutebrowser
    qdirstat
    pwgen
    obsidian
    nushell
    nodejs
    nix-du
    nh # https://github.com/viperML/nh
  ];

  services = {
    gnome-keyring.enable = true;
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      # pinentryFlavor = "gnome3";
      pinentryPackage = pkgs.pinentry-bemenu;
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

