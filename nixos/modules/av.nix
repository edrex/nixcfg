{ config, pkgs, lib, ... }:

with lib; {
  # options.edrex.sound = {
  #   enable = mkEnableOption "Enable sound";
  # };
  # lib.mkIf (config.hardware.bluetooth.enable) {
  #   services.blueman.enable = true; 
  # } //
  config = lib.mkMerge [
    {
      security.rtkit.enable = true; # ?
      hardware.pulseaudio.enable = mkForce false;
      
      environment.systemPackages = with pkgs; [
        # TODO: why do I need all three?
        pamixer
        pulsemixer
        pavucontrol
      ];

      # why do I need this?
      # programs.dconf.enable = true;
      # https://nixos.wiki/wiki/PipeWire
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true; # for old games, wine etc?
        pulse.enable = true;
      };
    } 
    (lib.mkIf (config.hardware.bluetooth.enable) {
      # TODO: put this in a bluetooth module?
      # https://nixos.wiki/wiki/Bluetooth
      services.blueman.enable = true;
      environment.etc = {
      	"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      		bluez_monitor.properties = {
      			["bluez5.enable-sbc-xq"] = true,
      			["bluez5.enable-msbc"] = true,
      			["bluez5.enable-hw-volume"] = true,
      			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      		}
      	'';
      };
      # services.pipewire.media-session.config.bluez-monitor.rules = [{
      #     # Matches all cards
      #     matches = [ { "device.name" = "~bluez_card.*"; } ];
      #     actions = {
      #       "update-props" = {
      #         "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
      #         # mSBC is not expected to work on all headset + adapter combinations.
      #         "bluez5.msbc-support" = true;
      #         # SBC-XQ is not expected to work on all headset + adapter combinations.
      #         "bluez5.sbc-xq-support" = true;
      #       };
      #     };
      #   }
      #   {
      #     matches = [
      #       # Matches all sources
      #       { "node.name" = "~bluez_input.*"; }
      #       # Matches all outputs
      #       { "node.name" = "~bluez_output.*"; }
      #     ];
      #     actions = {
      #       "node.pause-on-idle" = false;
      #     };
      #   }
      # ];
    })
  ];
}