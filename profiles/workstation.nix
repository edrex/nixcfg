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
    gscan2pdf
    skanlite
    ];



}