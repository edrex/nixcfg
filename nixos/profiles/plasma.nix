{ config, pkgs, lib, ... }:
let
  dervsFrom = s: builtins.filter (x: (builtins.tryEval x).success && (lib.isDerivation x)) (builtins.attrValues s);
in {
  environment.systemPackages = with pkgs; [
    kgpg
  ]
    # ++ dervsFrom plasma5Packages.kdeGear
    ++ dervsFrom plasma5Packages.kdeFrameworks
    ++ dervsFrom plasma5Packages.plasma5;
    
  # Wish for wayland only login manager, alas (GDM tho)
  # services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # Enable the Plasma 5 Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;
  # IMO mkForce is actually not OK here, since it can override host-specific tlp settings
  # needed for safe functioning (eg, disable s2idle on Dell XPS 13 9360 to prevent rapid
  # battery degradation)
  # conflicts with services.power-profiles-daemon.enable = true
  # services.tlp.enable = lib.mkForce false;
   
}
