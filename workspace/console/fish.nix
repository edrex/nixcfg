{self, ...}: {
  perSystem = { config, self', pkgs, ... }: {
    # https://ryantm.github.io/nixpkgs/builders/trivial-builders/#trivial-builder-writeShellApplication
    packages.fish = pkgs.wrapFish {
      # runtimeInputs = apps;
      pluginPkgs = with pkgs.fishPlugins; [ pure foreign-env ];
      completionDirs = [];
      functionDirs = [];
      # confDirs = [ "/path/to/some/fish/init/dir/" ];
    };
  };
}
