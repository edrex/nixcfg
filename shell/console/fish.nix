{self, ...}: {
  perSystem = { config, self', pkgs, ... }: {
    # https://ryantm.github.io/nixpkgs/builders/trivial-builders/#trivial-builder-writeShellApplication
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/shells/fish/wrapper.nix
    packages.fish = pkgs.wrapFish {
      # runtimeInputs = apps;
      pluginPkgs = with pkgs.fishPlugins; [ pure foreign-env ];
      completionDirs = [];
      functionDirs = [];
      # confDirs = [ "/path/to/some/fish/init/dir/" ];
    };
  };
}
