{ config, pkgs, lib, ... }: {
  # TODO: rename to network-client.nix
  # systemd.services.NetworkManager-wait-online.enable = false;
  networking = {
    # wireless = {
    #   # Enables wireless support via wpa_supplicant.
    #   enable = true;  
    #   # userControlled.enable = true;
    # };
    networkmanager = {
      enable = true;
      # iwd gives up too easily when signal is weak :|
      # wifi.backend = "iwd";
    };
  };

  # iwd is faster right?
   environment.systemPackages = with pkgs; [
     iw
   ];
  # networking.wireless.iwd.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable CUPS to print documents.
  # TODO: printing mixin
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    hplip
  ]; 
  services.fwupd.enable = true;
  services.avahi.enable = true;
  # Important to resolve .local domains of printers, otherwise you get an error
  # like  "Impossible to connect to XXX.local: Name or service not known"
  services.avahi.nssmdns4 = true;  # gate settings
  
}
