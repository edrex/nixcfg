{config, pkgs, ...}: {
  ## print/scan
  hardware.sane.enable = true;
  users.users.edrex.extraGroups = [ "scanner" "lp" ];
  hardware.sane.extraBackends = [
    pkgs.sane-airscan
    pkgs.hplip
  ];

  environment.systemPackages = with pkgs; [
    gimp
    simple-scan
    # build broken 220328
    # gscan2pdf
    mpv
    ];



}
