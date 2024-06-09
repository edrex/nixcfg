{ config, pkgs, lib, ... }:

with lib; {
  config = lib.mkMerge [
    {
      security.rtkit.enable = true; # ?
      hardware.pulseaudio.enable = mkForce false;
      
      environment.systemPackages = with pkgs; [
        pavucontrol
      ];

      # https://nixos.wiki/wiki/PipeWire
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true; # for old games, wine etc?
        pulse.enable = true;
      };
    } 
    (lib.mkIf (config.hardware.bluetooth.enable) {
      # https://nixos.wiki/wiki/Bluetooth
      services.blueman.enable = true;
      # magic copypasta from https://nixos.wiki/wiki/PipeWire#Bluetooth_Configuration
      services.pipewire.wireplumber.configPackages = [
      	(pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
      		bluez_monitor.properties = {
      			["bluez5.enable-sbc-xq"] = true,
      			["bluez5.enable-msbc"] = true,
      			["bluez5.enable-hw-volume"] = true,
      			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      		}
      	'')
      ];
    })
  ];
}
