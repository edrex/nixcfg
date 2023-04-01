{ pkgs, ... }: {
  home.packages = with pkgs;
  [
    # i use all 3
    # TODO: way-displays systemd user service, started via compositor target
    way-displays # a MUCH MUCH MUCH better display manager than kanshi, but not yet popular
    wdisplays
    wlr-randr
  ];
  # way-displays needs input group, added to ~/nix/nixos/users/edrex.nix
  # TODO: Flake module which exposes both nixos and hm modules
  # TODO: hm module for way-displays
}