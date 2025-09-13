;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
(setq doom-theme 'doom-tokyo-night)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15)) ;; Nerd Font preferred
(setq doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 15))
(setq nerd-icons-font-names '("NFM.ttf"))

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

(map! :desc "Toggle terminal" :ni "C-/" '+vterm/toggle) ;; Map terminal as in neovim

;; Evil window navigation with C-hjkl
(map! :desc "Evil window left" "C-h" 'evil-window-left) ;; Map terminal as in neovim
(map! :desc "Evil window down" "C-j" 'evil-window-down) ;; Map terminal as in neovim
(map! :desc "Evil window up" "C-k" 'evil-window-up) ;; Map terminal as in neovim
(map! :desc "Evil window right" "C-l" 'evil-window-right) ;; Map terminal as in neovim

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq deft-directory "~/org/"
      deft-extensions '("txt" "org" "md")
      deft-recursive t)
(setq org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %Y-%m-%d"
      org-journal-file-format "%Y-%m-%d.org")
(setq org-roam-directoiry "~/org/roam")

(after! org
  (use-package org-fancy-priorities
    :hook (org-mode . org-fancy-priorities-mode)
    :config (setq org-fancy-priorities-list
                  '((?A . "HIGH")
                    (?B . "MID")
                    (?C . "LOW")))))

(after! org (setq org-startup-folded 'show2levels))

(setq flyspell-mode -1) ;; Disable spell checking by default

;;; How to start a language server inside a nix shell when a flake is available:
;; (defun start-hls (_mode)
;;   "Start HLS by trying to wrap in nix develop."
;;   (if (file-exists-p "flake.nix")
;;     (progn
;;       (message "Running HLS with flake")
;;       (list "nix" "develop" "--command" "haskell-language-server-wrapper" "--lsp"))
;;     (progn
;;       (message "Running HLS from host")
;;       (list "haskell-language-server-wrapper" "--lsp"))))
;; (add-to-list 'eglot-server-programs '(haskell-mode . start-hls))
;; https://docs.doomemacs.org

;;;; Use this to add new capture templates
;; org-capture-templates
;;         '(("t" "todo" entry (file+headline "todo.org" "Inbox")
;;            "* [ ] %?\n%i\n%a"
;;            :prepend t)
;;           ("d" "deadline" entry (file+headline "todo.org" "Inbox")
;;            "* [ ] %?\nDEADLINE: <%(org-read-date)>\n\n%i\n%a"
;;            :prepend t)
;;           ("s" "schedule" entry (file+headline "todo.org" "Inbox")
;;            "* [ ] %?\nSCHEDULED: <%(org-read-date)>\n\n%i\n%a"
;;            :prepend t)
;;           ("c" "check out later" entry (file+headline "todo.org" "Check out later")
;;            "* [ ] %?\n%i\n%a"
;;            :prepend t)
;;           ("l" "ledger" plain (file "ledger/personal.gpg")
;;            "%(+beancount/clone-transaction)"))

;; Prevents some cases of Emacs flickering.
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;; Disable invasive lsp-mode features
(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil))
;; (after! lsp-ui (setq lsp-ui-doc-enable nil)) ; redundant with K

(add-hook 'dired-mode-hook #'dired-hide-details-mode) ;; Hide details by default in dired
(add-hook 'prog-mode-hook #'rainbow-mode) ;; Show colors inline in prog-mode
(setq org-hide-emphasis-markers t) ;; Hide emphasis markers in *sentence* and /sentence/ etc.

(defun ahp/run-command (cmd)
  (interactive)
  (+vterm/toggle nil)
  (vterm-send-string cmd)
  (vterm-send-return)
  (other-window 1))
(defun ahp/run-command-exit-on-success (command)
  (interactive)
  (+vterm/toggle nil)
  (vterm-send-string (format "%s; if [ $? -eq 0 ]; then exit; fi" command))
  (vterm-send-return))

(defun ahp/sync-mail ()
  (interactive)
  (ahp/run-command-exit-on-success "mbsync -c ~/.emacs.d/mu4e/.mbsyncrc -a")
  (other-window 1))
(map! :map mu4e-main-mode-map
      :localleader
      "s" #'ahp/sync-mail)

(defun ahp/build-home ()
  (interactive)
  (ahp/run-command "bh"))
(defun ahp/build-system ()
  (interactive)
  (ahp/run-command-exit-on-success "bs"))

(map! :leader :n
      :desc "Build nixos system from flake" "<f11>" #'ahp/build-system)
(map! :leader :n
      :desc "Build home with Nix Home-Manager" "<f12>" #'ahp/build-home)

;;;; Swap avy keybindings and override dirvish keybinding
(map! :after evil
      :map evil-normal-state-map
      :desc "avy-goto-char-2" "g s /" #'avy-goto-char-2
      :desc "avy-goto-char-timer" "g s s" #'avy-goto-char-timer
      :leader :n :desc "+treemacs/toggle" "o p" #'+treemacs/toggle)

;; devdocs keybindings
(map! :leader :n
      :desc "devdocs-lookup" "d l" #'devdocs-lookup
      :desc "devdocs-install" "d i" #'devdocs-install)

(map! :desc "other window" "M-o" #'other-window)

;;;; Custom popup rules
(set-popup-rules!
  '(("^\\*devdocs"
     :side right
     :size 0.5
     :quit t
     :select t)
    ("^\\*eww"
     :side right
     :size 0.5
     :quit t
     :select t)
    ("^\\*Google Translate.*\\*$"
     :side right
     :size 0.4
     :quit t
     :select t)
    ("^\\*helpful.*\\*$"
     :side right
     :size 0.4
     :quit t
     :select t)
    (".*gptel.*"
     :side right
     :size 0.4
     :quit t
     :select t)
    ("doc"
     :side right
     :size 0.4
     :quit t
     :select t)
    ("^\\*Ollama.*\\*$"
     :side right
     :size 0.4
     :quit t
     :select t)))

(setq load-path (append (list (expand-file-name "./lilypond")) load-path))
(condition-case nil
    (require 'lilypond-mode)
  (error (message "Optional: 'some-feature' not found, ignoring...")))

;; nov.el
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(add-hook 'nov-mode-hook #'olivetti-mode)

(gptel-make-ollama "Ollama-deepseek-r1:8b"
  :host "localhost:11434"
  :stream t
  :models '(deepseek-r1:8b))

(setq gptel-model 'gemma3:4b
      gptel-backend (gptel-make-ollama "Ollama-gemma3:4b"
                      :host "localhost:11434"
                      :stream t
                      :models '(gemma3:4b))
      gptel-use-tools -1)

(map! :leader :n :desc "abort gptel" "o q" #'gptel-abort)
(map! :leader :n :desc "open gptel LLMs" "o l" #'my/gptel)

(defun my/gptel ()
  (interactive)
  (with-current-buffer (get-buffer-create "gptel-default")
    (cond
     ((eq major-mode gptel-default-mode))
     ((eq gptel-default-mode 'text-mode)
      (text-mode)
      (visual-line-mode 1))
     (t (funcall gptel-default-mode)))
    (gptel--sanitize-model :backend (default-value 'gptel-backend)
                           :model (default-value 'gptel-model)
                           :shoosh nil)
    (unless gptel-mode (gptel-mode 1))
    (goto-char (point-max))
    (skip-chars-backward "\t\r\n")
    (if (bobp) (insert "### "))
    (display-buffer (current-buffer) gptel-display-buffer-action)
    (message "Send your query with %s!"
             (substitute-command-keys "\\[gptel-send]"))
    (current-buffer))
  )

(defun gptel-lookup (prompt)
  (interactive (list (read-string "Ask the LLM: " nil gptel-lookup--history)))
  (when (string= prompt "") (user-error "A prompt is required."))
  (gptel-request
      prompt
    :callback
    (lambda (response info)
      (if (not response)
          (message "gptel-lookup failed with message: %s" (plist-get info :status))
        (with-current-buffer (get-buffer-create "*gptel-lookup*")
          (let ((inhibit-read-only t))
            (erase-buffer)
            (insert response))
          (special-mode)
          (display-buffer (current-buffer)
                          `((display-buffer-in-side-window)
                            (side . bottom)
                            (window-height . ,#'fit-window-to-buffer))))))))


;; Easy google translate access
(setq google-translate-translation-directions-alist '(("en" . "da") ("da" . "en")))
(setq google-translate-default-source-language "en")
(setq google-translate-default-target-language "da")
(map! :leader :n :desc "language translate" "l t" #'google-translate-smooth-translate)
(map! :leader :n :desc "language translate at point" "l p" #'google-translate-at-point)

(defun speed-type-top-200 ()
  (interactive)
  (speed-type-top-x 200))
(add-hook 'speed-type-mode-hook #'olivetti-mode)
(map! :leader :n :desc "speed-type" "o s" #'speed-type-top-200)
(map! :map speed-type-mode-map :localleader "q" #'speed-type--quit)
(map! :map speed-type-mode-map :localleader "r" #'speed-type--play-next)
(setq speed-type-default-lang "English")

(setq which-key-idle-delay 0.2)

(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Intellj-like next/prev-function search
(map! :ni :desc "goto next method" "M-j" #'+evil/next-beginning-of-method
      :ni :desc "goto previous method" "M-k" #'+evil/previous-beginning-of-method)

(setq lsp-java-java-path "/home/andreas/.nix-profile/bin/java")

(defvar java-function-regexp
  (rx (or
       " class "
       (seq " enum " (+ alnum) " {")
       (seq "record " (+ alnum) "(")
       (seq " interface " (+ alnum) " {")
       (seq space
            (+ alnum)
            "("
            (* (or (seq (or "." "@") (+ alnum) "(") (not "(")))
            ") {")
       )))

(defun line-contains-string-p (str)
  "Return t if the current line contains STR."
  (save-excursion
    (let ((line-start (line-beginning-position)))
      (search-backward str line-start t))))

(defun my/next-java-method ()
  (interactive)
  (evil-set-jump)
  (if (line-contains-string-p "{") (search-forward "{") (forward-line))
  (search-forward-regexp java-function-regexp nil t)
  (evil-last-non-blank)
  (if (line-contains-string-p ")")
      (progn
        (evil-find-char-backward 1 ?\))
        (evil-jump-item)
        (evil-backward-word-begin))
    (evil-backward-word-begin)
    ))

(defun my/prev-java-method ()
  (interactive)
  (evil-set-jump)
  (search-backward-regexp java-function-regexp nil t)
  (evil-first-non-blank)
  (evil-find-char 1 ?\()
  (evil-backward-word-begin))

(map! :map java-mode-map
      :ni "M-k" #'my/prev-java-method
      :ni "M-j" #'my/next-java-method)

(defun my/project-todo-toggle ()
  (interactive)
  (let* ((file-name "project.org")
         (file-path (concat (projectile-project-root) file-name))
         confirm-kill-processes)
    (unless (file-exists-p file-path)
      (write-region "#+title: Project\n\n* TODO's\n- [ ] \n* Questions/Thoughts" nil file-path))
    (if-let* ((win (get-buffer-window file-name)))
        (delete-window win)
      (let ((buffer (or (get-file-buffer file-path) (find-file-noselect file-path))))
        (with-current-buffer buffer
          (unless (eq major-mode 'org-mode)
            (org-mode)))
        (pop-to-buffer (get-file-buffer file-path))))))
(map! :map projectile-mode-map
      :leader :n "p t" #'my/project-todo-toggle)
(set-popup-rules!
  '((
     "project.org"
     :side right
     :size 0.3
     :quit t
     :select t)))
