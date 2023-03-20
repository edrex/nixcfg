{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    steam-run # fhs environment for general purpose
    # steam-tui
  ];
  
  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}
