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
  #     export NIXOS_OZONE_WL=1
  #     export CLUTTER_BACKEND=wayland
  #     export QT_QPA_PLATFORM=wayland-egl
  #     export ECORE_EVAS_ENGINE=wayland-egl
  #     export ELM_ENGINE=wayland_egl
  #     export SDL_VIDEODRIVER=wayland
  #     export _JAVA_AWT_WM_NONREPARENTING=1
  #     export NO_AT_BRIDGE=1

  #     #systemd-cat --identifier=sway sway $@
  #   '';
  };


  # flatpak support
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # experimental. do i need any/all of these for automount?
  
  services.gvfs.enable = true;
  services.udisks2.enable = true;

}
