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
  ];
  
  home.packages = with pkgs; [
    # https://jvns.ca/blog/2022/04/12/a-list-of-new-ish--command-line-tools/
    # TODO: sort these into other modules 
    bottom
    gh
    pass
    fishPlugins.foreign-env # fenv command
    gnupg
    fzf
    yadm
    
    gron
    # unrar #unfree
    unzip
    ani-cli
    transmission_4-gtk
    mpv
    termtosvg
    sshx
    ruby
    ripgrep
    qdirstat
    pwgen
    # obsidian
    nushell
    nodejs
    
    # essential dev tools
    # zellij
    helix 

    # git 
    # gitFull # incl git gui, gitk
    gitu # magit for term!
    gitty # interact with forges
    git-filter-repo
    gh delta
    
    fd fzf zoxide
    sd # sed alt https://github.com/chmln/sd
    choose # cut alt https://github.com/theryangeary/choose
    
    eza # better ls https://github.com/eza-community/eza
    
    # workflow creation
    just gum tydra

    # direnv
    direnv nix-direnv
    devenv
    
    # ops
    htop btop glances

    # file managers
    ranger nnn lf 
    
    highlight # needed for ranger highlighting
    # TODO set HIGHLIGHT_STYLE=andes
    # TODO evaluate tmsu, ansi tool
    
    # nix
    nixd # LSP server with comprehensive goto definition etc
    nh # QoL wrapper for nix build, nixos-rebuild, home-manager, etc. See Justfile for usage example
    # nix-du #broken atm
    

    # TODO: how to "activate" XDG dirs into main home session?
    wezterm
    # qutebrowser # for dir-scoped browser session prototype

    # docs - maybe obsidian should be in wiki tho
    obsidian 
    markdown-oxide
    pandoc

    # wayland stuff
    wlrctl # interact with wayland toplevels etc via script
    pinentry-gtk2
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

