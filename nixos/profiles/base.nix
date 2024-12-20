{ config, pkgs, lib, nix, inputs, ... }:
{
  # trying out xanmod kernel
  # TODO: make this this the default. ARM support?
  # via https://github.com/NixOS/nixpkgs/issues/63708
  boot.kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_xanmod_latest;

  networking = {
    #useNetworkd = true;
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
  };

  # systemd-networkd-wait-online.service fails after a timeout if enabled, similar to
  # https://github.com/NixOS/nixpkgs/issues/30904
  # systemd.network = {
  #   enable = true;
  # };

  # TODO: put this in a sysprefs module
  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape,altwin:swap_alt_win";
  };
  
  # Use same config for linux console
  console.useXkbConfig = true;
  # enabling kmscon prevented starting of:
  # - gdm
  # - sway
  # - also doesn't work with useXkbConfig
  # services.kmscon.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = lib.mkDefault false;
    };
  };

  users.users.root.openssh.authorizedKeys.keys = lib.mkDefault [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCnE3wt2x/iY57AqQWmMThUhsLq2KuYdQHsv/Twh7fadlGXGA49K9Ksu6PLJ7B8e10g4izjFIk4j9tMMZxxeOjBYcqRPLPdQLjZrxWePQ0ZYcMThaNE78YygbOJcRsSomOtu2+9XV4nkatBoFZ+YINH8L9lpOFT/8N0NSq4whdant+gr/Dd8nOpKd3ceRGwOx7FEwKeZjIM5+nrOxjZnwGTAExrYuZIsBdysc7xoCa83tRw1BO6zJLMNKugr5RR5f76fec3p7BdMgB7D3tnOp2jFBOcEG2Tw7GNO+D/2rglKDkDmTCQN9lJys8lfP4G+cGoM+uIP+OypQkuZ4xqJ7dKdSCOQ1UCuOubXd2uwqJsTrwo01lNJKkQWR66tfBqzVLxyNWUkgdGAxl0s4QSJQj8fwv7754WWf5NYKSp4TO4ZOnUtkchjwxG1jMWndMiiPxOfOrP1J1YQ4Rw1sB1/TKsMbteyUk9N/xOp2WazQW7uARpDJbbsLjhH0IA3UCSmZWnXSjSDPAqk49XsQZ52K1Po6xOhvLA7SCDWaSrx7hNUbrEPkyfi4dIMF+G3j42+wjHE7PxN7yYIlJW1TTWxc2mVvPOT6emFRCrEFgOgwXVwMqH3rt1tKwf6z5Psy0hoZmK0Rt7TtdLkDzPrSCris1wOlzCR0Bm5mQ01DDVkrq7ow== edrex@chip" ];


  fonts.packages = with pkgs.nerd-fonts; [
    fira-code
    iosevka
    hack
    sauce-code-pro
  ];
  fonts.fontconfig.defaultFonts.monospace =  [ "Iosevka" ];

  # Set your time zone.
  time.timeZone = lib.mkDefault "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # install basic packages
  environment.systemPackages = with pkgs; [
    helix
    htop
    iotop
    iftop
    git
    neovim
    wget
    curl
    httpie
    tcpdump
    dig
    parted
    # whois
    # mtr
    # siege
    file
    lsof
    inotify-tools
  # TODO: debugging module
    psmisc
    usbutils
    strace
    gdb
    # dev:c
    cmake
    ## Infosec
      nmap
    # nix x dev
    nixpkgs-review
    nix-tree
    # xz
    # lz4
    # zip
    # unzip
    rsync
    # restic
    # xclip
    tealdeer
    tmux
    # screen
    # tree
    # dfc
    # pwgen
    jq
    # yq
    # gitAndTools.gitFull
    # nix dev
    cachix
    home-manager
    # diffoscope
  ];
}
