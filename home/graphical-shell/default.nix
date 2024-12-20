{ pkgs, ... }: {
# really close match to my config needs: https://codeberg.org/imMaturana/nixos-config
# todo: rename to "shell" (and module system)
  imports = [ 
    ./sway.nix
    ./displays.nix
    ./notify.nix
    ./screenshots.nix
  ];

  # wayland.windowManager.hyprland.enable = true;

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };

  programs.rofi = {
    enable = true; 
    package = pkgs.rofi-wayland.override {
      plugins = [ pkgs.rofi-emoji ];
    };
  };

  home.packages = with pkgs; [
    slurp
    xdg-utils # todo: xdg compat basics import
    swaylock
    swayidle
    swaybg
    wl-clipboard
    brightnessctl
    wlsunset
    poweralertd
    foot
    wofi
    rofimoji
    wtype #TODO: eval for removal
    # themes
    gtk-engine-murrine
    gtk_engines
    gsettings-desktop-schemas
    # lxappearance
    libsForQt5.qt5ct # set qt themes without kde
    xdg-utils
    imv # i guess this should be in a module with basic userspace stuff
    cosmic-files
    # gnome.gnome-software
    # gnome.nautilus
    # TODO: move unused elsewhere
    # window managers
    # niri
    # fuzzel
  ];

  services.wlsunset = {
    enable = true;
    # TODO: wire up a location service. Goes along with light/dark UI changes too IMO
    latitude = "45.5";
    longitude = "-122.6";
  }; 


  # TODO: put this in a toolkits include
  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };


}
