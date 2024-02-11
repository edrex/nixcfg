{pkgs, ...}:
{
  # https://devenv.sh/reference/options/
  packages = with pkgs; [
  ];

  enterShell = ''
    hello
  '';

  difftastic.enable = true;

  languages = {
    # bash.enable = true;
    c.enable = true;
    # clojure.enable = true;
    cplusplus.enable = true;
    go.enable = true;
    # haskell.enable = true;
    # javascript.enable = true;
    nix.enable = true;
    python.enable = true;
    python.poetry.enable = true;
    # rust.enable = true;
    zig.enable = true;    
  };
}
