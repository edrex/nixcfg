{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; []
    # ++ builtins.filter lib.isDerivation (builtins.attrValues plasma5Packages.kdeGear)
    ++ builtins.filter lib.isDerivation (builtins.attrValues plasma5Packages.kdeFrameworks)
    ++ builtins.filter lib.isDerivation (builtins.attrValues plasma5Packages.plasma5);
  
  nixpkgs.config = {
    # workaround plasma apps install https://github.com/NixOS/nixpkgs/issues/148452
    # Maybe a way to patch just the one package tho?
    allowAliases = false;
  };

  # Wish for wayland only login manager, alas (GDM tho)
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  # Enable the Plasma 5 Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;
  # conflicts with services.power-profiles-daemon.enable = true
  services.tlp.enable = lib.mkForce false;
   
}
