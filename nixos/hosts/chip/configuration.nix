# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, nixos-hardware, ... }:

{
  imports = [
      ./hardware-configuration.nix
      # ./keyboards.nix
      ../../profiles/base.nix
      ../../profiles/laptop.nix
      # ../../profiles/plasma.nix
      ../../profiles/gnome.nix
      ../../profiles/wayland.nix
      ../../profiles/wireless-client.nix
      ../../profiles/vmhost.nix
      ../../profiles/sdr.nix
      # ../../profiles/gaming.nix
    ];

  # trying out xanmod kernel
  # TODO: make this this the default. ARM support?
  # via https://github.com/NixOS/nixpkgs/issues/63708
  # boot.kernelPackages =  pkgs.linuxKernel.packages.linux_xanmod_latest;
  boot.kernelPackages = pkgs.pkgs.linuxPackages_6_5;

  # s2idle has high power drain on this model, at least under linux
  # https://superuser.com/questions/1792252/how-do-i-disable-suspend-to-ram-and-enable-suspend-to-idle#1792269
  # i would rather disable s2idle in the bios. this just changes to deep on boot
  # WARN: some other power mngr could change this value at runtime, which would be BAD
  systemd.tmpfiles.rules = [
    "w /sys/power/mem_sleep - - - - deep"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # experimental systemd as pid 1 in initrd
  boot.initrd.systemd.enable = true;

  networking.hostName = "chip"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # networking.interfaces.wlp58s0.useDHCP = true;

  sound.enable = true;
  hardware.bluetooth.enable = true;

  # TODO
  hardware.opengl.enable = true;
  # services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;


  # mount tmpfs on /tmp
  boot.tmp.useTmpfs = lib.mkDefault true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

