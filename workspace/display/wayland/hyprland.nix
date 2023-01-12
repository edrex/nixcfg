{ self, ... }: {
  perSystem = { config, self', inputs', pkgs, ... }: {
    devShells.hyprland = pkgs.mkShell {
      nativeBuildInputs = [
        pkgs.bashInteractive
        inputs'.hyprland.packages.default
        inputs'.hyprpaper.packages.default
      ];
    };
    packages =  {
      hyprland = inputs'.hyprland.packages.default;
      hyprpaper = inputs'.hyprpaper.packages.default;
    };
  };  
}