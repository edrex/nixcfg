{ config, pkgs, lib, ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager
  ];

  # TODO: extract to mod
  # trying out https://nixos.wiki/wiki/WayDroid
  # virtualisation = {
  #   waydroid.enable = true;
  #   lxd.enable = true;
  # };

}
