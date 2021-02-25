;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jason Huang"
      user-mail-address "huangmianrui0310@outlook.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq font-family (if (member system-type '(cygwin ms-dos windows-nt)) "SauceCodePro NF" "SauceCodePro Nerd Font"))
(setq doom-font (font-spec :family font-family :size 32)
      doom-variable-pitch-font (font-spec :family font-family :size 32)
      doom-big-font (font-spec :family font-family :size 64))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq kill-whole-line t)
(setq confirm-kill-emacs nil)
(setq writeroom-fullscreen-effect t)
;; Open Emacs maximized by default
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;;(setq initial-frame-alist '((top . 0) (left . 0) (width . 1024) (height . 720)))
;;Allow mixed fonts in a buffer
(add-hook! 'org-mode-hook #'mixed-pitch-mode)
(setq mixed-pitch-variable-pitch-cursor nil)
;; Truncate lines in `ivy' childframes
(setq posframe-arghandler
      (lambda (buffer-or-name key value)
        (or (and (eq key :lines-truncate)
                 (equal ivy-posframe-buffer
                        (if (stringp buffer-or-name)
                            buffer-or-name
                          (buffer-name buffer-of-name)))
                 t)
            value)))

;; Neotree configurations
(after! neotree
  (setq neo-smart-open t
        neo-window-fixed-size nil))
(after! doom-themes
  (setq doom-themes-neotree-enable-variable-pitch t))
(map! :leader
      :desc "Toggle neotree file viewer"
      "t n" #'neotree-toggle)

;; Open specific files
(map! :leader
      :desc "Edit agenda file"
      "k a" #'(lambda () (interactive) (find-file "~/org/agenda.org"))
      :leader
      :desc "Edit doom config.el"
      "k c" #'(lambda () (interactive) (find-file "~/.doom.d/config.el"))
      :leader
      :desc "Edit eshell aliases"
      "k e" #'(lambda () (interactive) (find-file "~/.doom.d/aliases"))
      :leader
      :desc "Edit doom init.el"
      "k i" #'(lambda () (interactive) (find-file "~/.doom.d/init.el"))
      :leader
      :desc "Edit doom packages.el"
      "k p" #'(lambda () (interactive) (find-file "~/.doom.d/packages.el")))

;; Setting Chinese font
(defun +my/better-font()
  (interactive)
  ;; English font
  (if (display-graphic-p)
      (progn
        (set-face-attribute 'default nil :font (format "%s:pixelsize=%d" font-family 32))
        ;; Chinese font
        (dolist (charset '(kana han symbol cjk-misc bopomofo))
          (set-fontset-font (frame-parameter nil 'font)
                            charset
                            (font-spec :family "Sarasa Mono SC"))))
    ))

(defun +my|init-font(frame)
  (with-selected-frame frame
    (if (display-graphic-p)
        (+my/better-font))))

(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions #'+my|init-font)
  (+my/better-font))

;; Change the path to elfeed.org file
(after! elfeed
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/.doom.d/elfeed.org")))

;; Evaluate Elisp expressions, from Derek Taylor
(map! :leader
      :desc "Evaluate elisp in buffer"
      "e b" #'eval-buffer
      :leader
      :desc "Evaluate the defun containing or after point"
      "e d" #'eval-defun
      :leader
      :desc "Evaluate an elisp expression"
      "e e" #'eval-expression
      :leader
      :desc "Evaluate elisp expression before point"
      "e l" #'eval-last-sexp
      :leader
      :desc "Evaluate elisp in region"
      "e r" #'eval-region)

(use-package! wakatime-mode
  :init
  (setq wakatime-cli-path (executable-find "wakatime"))
  :config
  (global-wakatime-mode))

;; LSP-mode with clangd
(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

(after! geiser
  :config
  (setq geiser-default-implementation 'racket)
  (setq geiser-guile-binary (executable-find "racket")))

;; Use minted to highlight code in latex
(after! ox-latex
  :config
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-listings 'minted)
  (setq org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")))
