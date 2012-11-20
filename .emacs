;; If user-emacs-directory isn't defined because this is an old version,
;; define it now.
(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory "~/.emacs.d/"
	"Directory beneath which additional per-user Emacs-specificfiles are placed. Various programs in Emacs store information in this directory. Note that this should end with a directory separator. See also ‘locate-user-emacs-file’."))

;; Ensure the load-path contain the sensible things
(add-to-list 'load-path "~/.emacs.d/common/")
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

(require 'mouse)
(global-font-lock-mode t)
(setq inhibit-splash-screen t)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(c-basic-offset 4)
 '(c-default-style (quote ((c-mode . "linux") (c++-mode . "linux") (java-mode . "java") (awk-mode . "awk") (other . "linux"))))
 '(c-electric-pound-behavior (quote (alignleft)))
 '(c-max-one-liner-length 78)
 '(c-require-final-newline (quote ((c-mode . t) (c++-mode . t) (objc-mode . t) (java-mode) (idl-mode))))
 '(c-tab-always-indent t)
 '(global-hl-line-mode nil)
 '(gud-gdb-command-name "gdb --annotate=1")
 '(indent-tabs-mode t)
 '(keyboard-coding-system (quote utf-8))
 '(large-file-warning-threshold nil)
 '(make-backup-files nil)
 '(mouse-1-click-follows-link (quote double))
 '(mouse-highlight nil)
 '(ns-alternate-modifier (quote none))
 '(ns-pop-up-frames nil)
 '(scroll-bar-mode (quote right))
 '(sgml-basic-offset 4)
 '(sgml-xml-mode t)
 '(tab-always-indent t)
 '(tool-bar-mode nil)
 '(xterm-mouse-mode t))
(line-number-mode t)
(column-number-mode t)
(setq default-input-method "ucs")
(set-default-coding-systems 'utf-8)

(require 'color-theme)
(require 'color-theme-solarized)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
	 (color-theme-dark-laptop)
	 (if (eq window-system 'ns) (color-theme-solarized-dark))
	 (if (eq window-system 'w32) (color-theme-solarized-dark))
	 (if (eq window-system 'x) (color-theme-solarized-dark))
	 ))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :family "Menlo")))))

;;  '(font-lock-comment-delimiter-face ((default (:foreground "green")) (((class color) (min-colors 8) (background dark)) nil)))
;; '(font-lock-comment-face ((((class color) (min-colors 8) (background dark)) (:foreground "green"))))
;; '(font-lock-constant-face ((((class color) (min-colors 8)) (:foreground "blue" :weight bold))))
;; '(font-lock-function-name-face ((((class color) (min-colors 8)) (:foreground "cyan" :weight bold))))
;; '(font-lock-keyword-face ((((class color) (min-colors 8)) (:foreground "magenta" :weight bold))))
;; '(font-lock-preprocessor-face ((t (:background "cyan" :foreground "blue" :weight bold))))
;; '(font-lock-string-face ((((class color) (min-colors 8)) (:foreground "green" :weight bold))))
;; '(font-lock-type-face ((((class color) (min-colors 8)) (:foreground "red" :weight bold))))
;; '(hl-line ((t (:inherit highlight :background "#1a1a00"))))
;; '(minibuffer-prompt ((((background dark)) (:foreground "white" :weight bold))))
;; '(mode-line ((t (:background "blue" :foreground "yellow" :weight bold)))))

;; I write a lot of PHP. Sue me.
;; (require 'php-mode)
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

(require 'smarty-mode)
(add-hook 'php-mode-user-hook 'turn-on-font-lock)
(add-hook 'smarty-mode-user-hook 'turn-on-font-lock)

;; Use tabs for indentation, 4-spaces-per-tab when displayed
(setq-default tab-width 4)

;; Bind Esc-g and Cmd+L to 'goto line'
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "s-l") 'goto-line)
;; Bind <f12> (on some terminals the up-arrow key) to previous-line
(global-set-key (kbd "<f12>") 'previous-line)

(require 'server)

;; Only do these on Mac OS X
(if (eq window-system 'ns) (server-start))
;; (if (eq window-system 'ns) (custom-set-variables '(global-hl-line-mode t)))

;; Don't prompt for confirmation when closing a file launched by
;; emacsclient.
(remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)

