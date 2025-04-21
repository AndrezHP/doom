;;; init.el -*- lexical-binding: t; -*-

;; This file controls what Doom modules are enabled and what order they load
;; in. Remember to run 'doom sync' after modifying it!

;; NOTE Press 'SPC h d h' (or 'C-h d h' for non-vim users) to access Doom's
;;      documentation. There you'll find a link to Doom's Module Index where all
;;      of our modules are listed, including what flags they support.

;; NOTE Move your cursor over a module's name (or its flags) and press 'K' (or
;;      'C-c c k' for non-vim users) to view its documentation. This works on
;;      flags as well (those symbols that start with a plus).
;;
;;      Alternatively, press 'gd' (or 'C-c c d') on a module to browse its
;;      directory (for easy access to its source code).

(doom! :completion
       (corfu +orderless +icons +dabbrev)  ; complete with cap(f), cape and a flying feather!
       ;; (ivy +fuzzy)               ; a search engine for love and life
       (vertico +icons +childframe)           ; the search engine of the future

       :ui
       deft              ; notational velocity for Emacs
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       ligatures         ; ligatures and symbols to make your code pretty again
       modeline          ; snazzy, Atom-inspired modeline, plus API
       ophints           ; highlight the region an operation acts on
       (popup +all +defaults)   ; tame sudden yet inevitable temporary windows
       (treemacs +lsp)          ; a project drawer, like neotree but cooler
       (vc-gutter +pretty) ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       workspaces        ; tab emulation, persistence & separate workspaces
       zen               ; distraction-free coding or writing

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       (format +onsave)  ; automated prettiness
       multiple-cursors  ; editing in many places at once
       rotate-text       ; cycle region at point between text candidates
       snippets          ; my elves. They type so I don't have to
       word-wrap         ; soft wrapping with language-aware indent

       :emacs
       (dired +dirvish +icons)             ; making dired pretty [functional]
       electric          ; smarter, keyword-based electric-indent
       eww               ; the internet is gross
       (ibuffer +icons)           ; interactive buffer management
       undo              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       eshell            ; the elisp shell that works everywhere
       vterm             ; the best terminal emulation in Emacs

       :checkers
       (syntax +childframe)              ; tasing you for every semicolon you forget
       ;; spell               ; tasing you for misspelling mispelling
       ;;grammar           ; tasing grammar mistake every you make

       :tools
       biblio            ; Writes a PhD for you (citation needed)
       (debugger +lsp)          ; FIXME stepping through code, to help you add bugs
       direnv
       docker              ; manipulate docker images, containers, etc. from emacs
       ;;editorconfig      ; let someone else argue about tabs vs spaces
       ;;ein               ; tame Jupyter notebooks with emacs
       (eval +overlay)     ; run code, run (also, repls)
       (lookup +docsets +dictionary)              ; navigate your code and its documentation
       lsp               ; M-x vscode
       (magit +childframe +forge)             ; a git porcelain for Emacs
       make              ; run make tasks from Emacs
       ;;pass              ; password manager for nerds
       pdf               ; pdf enhancements
       ;;terraform         ; infrastructure as code
       tree-sitter       ; syntax and parsing, sitting in a tree...
       ;;upload            ; map local to remote projects via ssh/ftp

       :os
       (:if (featurep :system 'macos) macos)  ; improve compatibility with macOS
       tty               ; improve the terminal Emacs experience

       :lang
       beancount         ; mind the GAAP
       (cc +lsp +tree-sitter)         ; C > C++ == 1
       (clojure +lsp +tree-sitter)           ; java with a lisp
       emacs-lisp        ; drown in parentheses
       ;; common-lisp       ; if you've seen one lisp, you've seen them all
       ;; janet ; some lispy scripting language
       ;; (scheme +guile +racket)   ; a fully conniving family of lisps
       data              ; config/data formats (csv, xml)
       json              ; At least it ain't XML
       (go +lsp +tree-sitter)         ; the hipster dialect
       (haskell +lsp +tree-sitter)    ; a language that's lazier than I am
       (java +lsp +tree-sitter)       ; the poster child for carpal tunnel syndrome
       (graphql +lsp)    ; Give queries a REST
       (javascript +lsp)        ; all(hope(abandon(ye(who(enter(here))))))
       ocaml             ; an objective camel
       latex             ; writing papers in Emacs has never been so fun
       (lua              ; one-based indices? one-based indices
        +lsp
        +tree-sitter
        +fennel)         ; (lua but lispy)
       markdown          ; writing docs for people to ignore
       (nix +lsp +tree-sitter)               ; I hereby declare "nix geht mehr!"
       (org              ; organize your plain life in plain text
        +pretty
        +journal
        +dragndrop         ; Exporting org to whatever you want
        +roam2
        +pomodoro
        +publish           ; Emacs+orgh as a static site generator
        +hugo
        +present)
       (python
        +conda
        +lsp
        +tree-sitter
        +pyright)            ; beautiful is better than ugly
       (rust +lsp +tree-sitter)       ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       (rest +jq)              ; Emacs as a REST client (Great for api testing)
       (sh +powershell)                ; she sells {ba,z,fi}sh shells on the C xor
       (web +tree-sitter)               ; the tubes (web stuff: html, css/scss, react...)
       yaml              ; JSON, but readable
       ;; (zig +lsp +tree-sitter)               ; C, but simpler
       ;;csharp            ; unity, .NET, and mono shenanigans
       ;;fsharp            ; ML stands for Microsoft's Language
       ;;elixir            ; erlang done right
       ;;(gdscript +lsp)          ; the language you waited for (for Godot)
       ;;php               ; perl's insecure younger brother
       ;;raku              ; the artist formerly known as perl6
       ;; (ruby +rails)     ; 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       ;; scala             ; java, but good
       ;; plantuml

       :email
       (mu4e +org +gmail +mbsync +icons)
       ;; notmuch

       :app
       calendar
       emms
       irc               ; how neckbeards socialize
       (rss +youtube)
       ;;everywhere        ; *leave* Emacs!? You must be joking NOTE This requires xorg

       :config
       ;;literate
       (default +bindings +smartparens))
