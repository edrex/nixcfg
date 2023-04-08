{ self, ... }: {
  imports = [
    ./common.nix
  ];

  perSystem = { config, self', inputs', pkgs, ... }: {
    apps = with pkgs; [
      # river
      river
      stacktile
    ];
  };
}