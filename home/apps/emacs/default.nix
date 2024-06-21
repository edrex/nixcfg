{config, pkgs, lib, ... }:
{
  # Crib:
  # https://github.com/hlissner/dotfiles/blob/master/modules/editors/emacs.nix
  # services.emacs.package = pkgs.emacsPgtkNativeComp;
  home.packages = with pkgs; [
    ## Emacs itself
    binutils       # native-comp needs 'as', provided by this
    ## Wayland enabled 29 + native-comp
    ((emacsPackagesFor emacs29-pgtk).emacsWithPackages
        (epkgs: [ epkgs.vterm ]))
    pandoc

    ## Doom dependencies
    git
    gnutls              # for TLS connectivity

    ## Optional dependencies
    fd                  # faster projectile indexing
    imagemagick         # for image-dired
    # FIXME: merge home stuff with main config
    # (lib.mkIf (config.programs.gnupg.agent.enable)
      pinentry-emacs   # in-emacs gnupg prompts
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

  home.sessionPath = [
    "$HOME/.config/emacs/bin" # doom emacs scripts
  ];

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

  # programs.doom-emacs = {
  #   enable = true;
  #   doomPrivateDir = ./doom.d;
  # };

}
