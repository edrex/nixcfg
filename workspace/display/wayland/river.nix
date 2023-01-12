{ self, ... }: {

  perSystem = { config, self', inputs', pkgs, ... }: {
    apps = with pkgs; [
      river
      waybar
      zelbar
      way-displays
      stacktile
    ];
  };
}