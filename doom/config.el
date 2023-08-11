;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Felipe Sasdelli"
      user-mail-address "sasdelli.pi@gmail.com")

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
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 22))
     ; doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

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

;; Starts emacs in fullscreen
(add-hook 'window-setup-hook #'toggle-frame-fullscreen)


;; Keybinds
(map!
 :n "C-x 3" nil
 :n ""
 )

(map! :leader
      (:prefix ("f" . "file")
       :desc "Find file" "f" nil))

(map!
 :n "C-S-n" #'split-window-right
 :n "C-S-h" #'windmove-left
 :n "C-S-l" #'windmove-right
 :n "C-S-<right>"  #'shrink-window-horizontally
 :n "C-S-<left>" #'enlarge-window-horizontally
 )

(map!
 :leader
 (:prefix-map ("s" . "search")
   :desc "Find file" "f" #'find-file)
 )

;; Add the following lines to your ~/.doom.d/config.el file

;; Set margins for Org mode
(use-package visual-fill-column
  :hook (org-mode . visual-fill-column-mode)
  :config
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t))

;; Set fonts for Org mode
(add-hook 'org-mode-hook #'(lambda ()
                             (setq org-fontify-quote-and-verse-blocks t)
                             (setq org-fontify-whole-heading-line t)
                             (set-face-attribute 'org-document-title nil :height 1.3 :weight 'bold)
                             (set-face-attribute 'org-level-1 nil :height 1.2 :weight 'bold)
                             (set-face-attribute 'org-level-2 nil :height 1.1 :weight 'bold)
                             (set-face-attribute 'org-level-3 nil :height 1.1)
                             (set-face-attribute 'org-level-4 nil :height 1.05)
                             (set-face-attribute 'org-level-5 nil :height 1.05)
                             (set-face-attribute 'org-level-6 nil :height 1.05)
                             (set-face-attribute 'org-level-7 nil :height 1.05)
                             (set-face-attribute 'org-level-8 nil :height 1.05)))

;; Remove line numbers in Org mode
(add-hook 'org-mode-hook #'doom-disable-line-numbers-h)

;; Enable word wrap in Org mode
(add-hook 'org-mode-hook #'visual-line-mode)

;; Hide the asterisks (*) in Org mode
(setq org-hide-emphasis-markers t)

;; Export code snippets with syntax highlighting in org-latex
(setq org-latex-src-block-backend 'engraved)

;; After the org-mode package is loaded...
(after! org
  ;; ...configure Babel languages to support Python.
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)))

  ;; Set various org-mode configurations:
  ;; - Don't ask for confirmation when evaluating Babel blocks.
  ;; - Fontify the source code natively.
  ;; - Display inline images and redisplay them as needed.
  ;; - Start org files with inline images displayed.
  (setq org-confirm-babel-evaluate nil
        org-src-fontify-natively t
        org-display-inline-images t
        org-redisplay-inline-images t
        org-startup-with-inline-images "inlineimages"))

;; After the visual-fill-column package is loaded...
(after! visual-fill-column
  ;; ...set the column width to 100 characters.
  ;; Center text in the window for a better visual appearance.
  (setq visual-fill-column-width 100
                visual-fill-column-center-text t))

;; Enabling ox-reveal for Org-Mode Slideshows.
(require 'ox-reveal)
(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js@4/")
