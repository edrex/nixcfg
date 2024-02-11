{ config, pkgs, lib, ... }:

{
  hardware.rtl-sdr.enable = true;
  users.users.edrex.extraGroups = [ "plugdev" ];
}
