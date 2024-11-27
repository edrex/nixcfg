{self, ...}: {
  perSystem = { config, self', pkgs, ... }: {
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/shells/fish/wrapper.nix
    packages.fish = pkgs.wrapFish {
      # runtimeInputs = apps;
      pluginPkgs = with pkgs.fishPlugins; [ pure foreign-env forgit ];
      completionDirs = [];
      functionDirs = [];
      # confDirs = [ "/path/to/some/fish/init/dir/" ];
    };
  };
}
