{ config, pkgs, inputs, ... }:

{
  imports = [
    ./wayland.nix
  ];

  config = {
    services.displayManager.cosmic-greeter.enable = true;
    services.desktopManager.cosmic.enable = true;
  };
}
