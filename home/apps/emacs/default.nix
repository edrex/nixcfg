{config, pkgs, lib, ... }:
{
  # Crib:
  # https://github.com/hlissner/dotfiles/blob/master/modules/editors/emacs.nix

  # programs.doom-emacs = {
  #   enable = true;
  #   emacs = pkgs.emacs29-pgtk;
  #   # TODO: put things in the right place
  #   # eg ./doom.d for a local config
  #   doomDir = ./doom.d;
  #   # TODO: remove me when 
  #   experimentalFetchTree = true;
  # };

  home.packages = with pkgs; let 
    mypkgs.emacs = ((emacsPackagesFor emacs29-pgtk).emacsWithPackages
        (epkgs: [ epkgs.vterm ]));
  in [
    mypkgs.emacs
    ## Emacs itself
    (ripgrep.override {withPCRE2 = true;})
    
    binutils       # native-comp needs 'as', provided by this
    ## Wayland enabled 29 + native-comp
    # ((emacsPackagesFor emacs29-pgtk).emacsWithPackages
    #     (epkgs: [ epkgs.vterm ]))
    pandoc

    ## Doom dependencies
    git
    gnutls              # for TLS connectivity

    ## Optional dependencies
    fd                  # faster projectile indexing
    imagemagick         # for image-dired
    # FIXME: merge home stuff with main config
    zstd                # for undo-fu-session/undo-tree compression

    ## Module dependencies
    # :checkers spell
    (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
    # :tools editorconfig
    editorconfig-core-c # per-project style config
    # :tools lookup & :lang org +roam
    sqlite
  ];

# TODO: generate a config file that gets included by the one in git

  # home.sessionPath = let
  #   xdg.configHome =
  # [
  #   "${xdg.configHome}/emacs/bin"
  # ];

  xdg.desktopEntries.org-protocol = {
    name = "org-protocol";
    exec = "emacsclient -- %u";
    terminal = false;
    type = "Application";
    categories = ["System"];
    mimeType = ["x-scheme-handler/org-protocol"];
  };

# TODO: add org-capture chrome extension
# ...
}
