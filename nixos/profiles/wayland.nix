{ pkgs, lib, ... }: {
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${lib.makeBinPath [pkgs.greetd.tuigreet] }/tuigreet --time --cmd sway";
  #       user = "greeter";
  #     };
  #   };
  # };

  # TODO: eval if HM sway module needs any tweaks from here
  # TODO: move this to a module, maybe flake-module with HM config (so they are enabled together)
  # home-manager takes care of sway
  programs.hyprland.enable = true;
  programs.sway = {
    enable = true;
    package = null; # just create the session file etc, and use sway from path (provided by HM)_
  #  wrapperFeatures.gtk = true;
  # https://man.sr.ht/~kennylevinsen/greetd/#how-to-set-xdg_session_typewayland
  #   #TODO: put this in a reusable script
  #   extraSessionCommands = ''
  #     #!/bin/sh

  #     # Session
  #     export XDG_SESSION_TYPE=wayland
  #     export XDG_SESSION_DESKTOP=sway
  #     export XDG_CURRENT_DESKTOP=sway

  #     export MOZ_ENABLE_WAYLAND=1
  #     export QT_QPA_PLATFORM=wayland-egl
  #     export SDL_VIDEODRIVER=wayland
  #     export _JAVA_AWT_WM_NONREPARENTING=1
  #     export NIXOS_OZONE_WL=1

  #     #systemd-cat --identifier=sway sway $@
  #   '';
  };


  # flatpak support
  # services.flatpak.enable = true;
  xdg.portal = {
    # enable = true;
    wlr.enable = lib.mkForce true; # hyprland wants it disabled, sway wants it on
    # gtk portal needed to make gtk apps happy
    # 2024-02-13: commented bc of a weird conflict
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # experimental. do i need any/all of these for automount?
  
  services.gvfs.enable = true;
  services.udisks2.enable = true;

}
