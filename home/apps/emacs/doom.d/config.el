;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
(setq display-line-numbers-type nil)
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Eric Drechsel"
      user-mail-address "eric@pdxhub.org")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq
 doom-theme 'doom-one
 ;; doom-leader-key "SPC"
 doom-localleader-key ","
 warning-minimum-level :error
 native-comp-async-report-warnings-errors nil
 )

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/wiki/Org/")

;; prefix with a dot so org-agenda-file-regexp skips it
(setq org-archive-location ".Archive.org::* From %s")
(setq org-capture-templates (nconc 'org-capture-templates `(
	                                                    ("p" "Protocol" entry (file+headline ,(concat org-directory "notes.org") "Inbox")
                                                             "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
	                                                    ("L" "Protocol Link" entry (file+headline ,(concat org-directory "notes.org") "Inbox")
                                                             "* %? [[%:link][%:description]] \nCaptured On: %U")
                                                            )))

(defun window-split-toggle ()
  "Toggle between horizontal and vertical split with two windows."
  (interactive)
  (if (> (length (window-list)) 2)
      (error "Can't toggle with more than 2 windows!")
    (let ((func (if (window-full-height-p)
                    #'split-window-vertically
                  #'split-window-horizontally)))
      (delete-other-windows)
      (funcall func)
      (save-selected-window
        (other-window 1)
        (switch-to-buffer (other-buffer))))))

(map! :leader :desc "Transpose window splits" :n "w t" #'window-split-toggle)

;; WIP not working
;; https://github.com/tecosaur/emacs-everywhere/pull/85
;; https://github.com/tecosaur/emacs-everywhere/wiki/Custom-app-info-functions-for-less-common-compositors
;; (setq emacs-everywhere-window-focus-command (list "hyprctl" "dispatch" "focuswindow" "address:%w"))
;; (setq emacs-everywhere-app-info-function #'emacs-everywhere--app-info-linux-hyprland)

;; (require 'json)
;; (defun emacs-everywhere--app-info-linux-hyprland ()
;;   "Return information on the current active window, on a Linux Hyprland session."
;;   (let* ((json-string (emacs-everywhere--call "hyprctl" "-j" "activewindow"))
;;          (json-object (json-read-from-string json-string))
;;          (window-id (cdr (assoc 'address json-object)))
;;          (app-name (cdr (assoc 'class json-object)))
;;          (window-title (cdr (assoc 'title json-object)))
;;          (window-geometry (list (aref (cdr (assoc 'at json-object)) 0)
;;                                 (aref (cdr (assoc 'at json-object)) 1)
;;                                 (aref (cdr (assoc 'size json-object)) 0)
;;                                 (aref (cdr (assoc 'size json-object)) 1))))
;;     (make-emacs-everywhere-app
;;      :id window-id
;;      :class app-name
;;      :title window-title
;;      :geometry window-geometry)))

;; (add-hook 'deft-mode-hook #'evil-normalize-keymaps))
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(defun paste-through-shell(cmd)
  "yank top of kill buffer through shell cmd"
  (interactive)
  (insert (with-temp-buffer
            (insert (current-kill 0))
            (shell-command-on-region (point-min) (point-max) cmd nil 'replace)
            (buffer-string))))

(defun paste-markdown-to-org()
  (interactive)
  (paste-through-shell "pandoc -f markdown -t org"))

(map! :after org
      :localleader
      :map org-mode-map
      :desc "Paste markdown as an org region"
      :nv
      "p m" #'paste-markdown-to-org)

;; for wiki, from https://github.com/felko/neuron-mode/issues/77#issuecomment-941616269
(setq markdown-enable-wiki-links t)
(setq markdown-link-space-sub-char " ")
(setq markdown-wiki-link-search-type '(project))
(setq markdown-wiki-link-fontify-missing t)
(setq markdown-wiki-link-search-subdirectories nil)
(setq markdown-wiki-link-search-parent-directories t)
(setq markdown-wiki-link-alias-first nil)
;; HACK markdown links not setting jump buffer
(advice-add #'markdown-follow-wiki-link :around #'doom-set-jump-a)
;; TODO this makes sense for wiki, not sure for code. Make it context-sensitive?
(setq better-jumper-add-jump-behavior 'replace)
;;(use-package! emacs-conflict)

;; copied from `man yadm'
;; usage: (magit-status "/yadm::")
;; (add-to-list 'tramp-methods
;;              '("yadm"
;;                (tramp-login-program "yadm")
;;                (tramp-login-args (("enter")))
;;                (tramp-login-env (("SHELL") ("/bin/sh")))
;;                (tramp-remote-shell "/bin/sh")
;;                (tramp-remote-shell-args ("-c"))))
