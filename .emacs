(global-font-lock-mode t)
(setq inhibit-splash-screen t)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c-default-style (quote ((c-mode . "linux") (c++-mode . "linux") (java-mode . "java") (awk-mode . "awk") (other . "linux"))))
 '(c-electric-pound-behavior (quote (alignleft)))
 '(gud-gdb-command-name "gdb --annotate=1")
 '(keyboard-coding-system (quote utf-8))
 '(large-file-warning-threshold nil)
 '(make-backup-files nil)
 '(ns-alternate-modifier (quote none))
 '(ns-pop-up-frames nil)
 '(scroll-bar-mode (quote right))
 '(tool-bar-mode nil))
(line-number-mode t)
(column-number-mode t)
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "black" :foreground "grey" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :family "Menlo"))))
 '(font-lock-comment-delimiter-face ((default (:foreground "green")) (((class color) (min-colors 8) (background dark)) nil)))
 '(font-lock-comment-face ((((class color) (min-colors 8) (background dark)) (:foreground "green"))))
 '(font-lock-constant-face ((((class color) (min-colors 8)) (:foreground "blue" :weight bold))))
 '(font-lock-function-name-face ((((class color) (min-colors 8)) (:foreground "cyan" :weight bold))))
 '(font-lock-keyword-face ((((class color) (min-colors 8)) (:foreground "magenta" :weight bold))))
 '(font-lock-preprocessor-face ((t (:background "cyan" :foreground "blue" :weight bold))))
 '(font-lock-string-face ((((class color) (min-colors 8)) (:foreground "green" :weight bold))))
 '(font-lock-type-face ((((class color) (min-colors 8)) (:foreground "red" :weight bold))))
 '(minibuffer-prompt ((((background dark)) (:foreground "white" :weight bold))))
 '(mode-line ((t (:background "blue" :foreground "yellow" :weight bold)))))
 (setq default-input-method "ucs")
 (set-default-coding-systems 'utf-8)

(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory "~/.emacs.d/"
	"Directory beneath which additional per-user Emacs-specificfiles are placed. Various programs in Emacs store information in this directory. Note that this should end with a directory separator. See also ‘locate-user-emacs-file’."))

(add-to-list 'load-path "~/.emacs.d/common/")

(require 'php-mode)
(add-hook 'php-mode-user-hook 'turn-on-font-lock)

(setq-default tab-width 4
			  c-basic-offset 4
			  indent-tabs-mode t)
(require 'server)
(if (eq window-system 'ns) (server-start))
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)
(if (eq window-system 'ns) (custom-set-faces
 '(hl-line ((t (:inherit highlight :background "#1a1a00"))))))
(if (eq window-system 'ns) (custom-set-variables
 '(global-hl-line-mode t)))

