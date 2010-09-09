(global-font-lock-mode t)
(setq inhibit-splash-screen t)
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(make-backup-files nil)
 '(scroll-bar-mode (quote right))
 '(tool-bar-mode nil nil (tool-bar)))
(line-number-mode t)
(column-number-mode t)
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(default ((t (:stipple unspecified :background "black" :foreground "grey" :inverse-video unspecified :box unspecified :strike-through unspecified :overline unspecified :underline unspecified :slant normal :weight normal :height 100 :width normal :family "misc-fixed")))))
 (setq default-input-method "ucs")
 (set-default-coding-systems 'utf-8)

 (unless (boundp 'user-emacs-directory)
   (defvar user-emacs-directory "~/.emacs.d/"
     "Directory beneath which additional per-user Emacs-specificfiles are placed. Various programs in Emacs store information in this directory. Note that this should end with a directory separator. See also ‘locate-user-emacs-file’."))

(add-to-list 'load-path "~/.emacs.d/common/")

(require 'php-mode)
(add-hook 'php-mode-user-hook 'turn-on-font-lock)