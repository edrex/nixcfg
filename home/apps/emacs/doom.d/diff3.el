;;; diff3.el -*- lexical-binding: t; -*-


(defun doom/ediff3-config (basename rev)
  "ediff3 private config with current and ancestor rev example config"
  (let* ((example-relpath (concat "templates/" basename ".example.el"))
         (example-buf (find-file (concat doom-emacs-dir example-relpath)))
         (local-path (concat doom-user-dir basename ".el")))
    (ediff-buffers3 (find-file local-path)
     example-buf
     (with-current-buffer example-buf
       (magit-find-file-noselect rev example-relpath)))))

(defun doom/ediff3-init ()
  (interactive)
  (doom/ediff3-config "init" "cd9bc5a1f"))

(define-key! help-map
  "di" #'doom/ediff3-init
  )
