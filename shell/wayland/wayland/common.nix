
{ self, ... }: {
  perSystem = { config, self', inputs', pkgs, ... }: {
    apps = with pkgs; [
      # wayland
      waybar
      zelbar
      way-displays
      mako
      # https://github.com/zim0369/pretty-kitty
      # https://github.com/dexpota/kitty-themes
    ];
  };
}