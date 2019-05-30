
(menu-bar-mode (if on-mac 1 0))
(setq-default
 bell-volume 0
 fill-column 79
 inhibit-startup-echo-area-message t
 inhibit-startup-message t
 scroll-step 1
 show-paren-delay 0
 visible-bell t
 sentence-end-double-space t
 require-final-newline t
 )

(blink-cursor-mode -1)
(tool-bar-mode -1)
(line-number-mode t)
(column-number-mode t)
(show-paren-mode t)
(delete-selection-mode t)
(transient-mark-mode t)
(global-hl-line-mode t)
;; (iswitchb-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(which-func-mode t)
(set-default 'indicate-empty-lines t)
(auto-fill-mode t)
;; (set-default 'imenu-auto-rescan t)
(recentf-mode t)
(setq vc-follow-symlinks t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spell Checking
(setq flyspell-issue-message-flag nil)
(when (executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-really-hunspell t)
  (eval-after-load "ispell"
    '(progn (defun ispell-get-coding-system () 'utf-8))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; text-mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-flyspell)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; frames
;; (setq frame-title-format "%f")
;; (setq icon-title-format "%f")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mouse
(unless window-system
  (xterm-mouse-mode t)
  (mouse-wheel-mode t))

(setq my-num-lines 3)

(defun sd-mousewheel-scroll-up (event)
  "Scroll window under mouse up by five lines."

  (interactive "e")
  (let ((current-window (selected-window)))
    (unwind-protect
        (progn
          (select-window (posn-window (event-start event)))
          (scroll-up my-num-lines))
      (select-window current-window))))
(defun sd-mousewheel-scroll-down (event)
  "Scroll window under mouse down by five lines."
  (interactive "e")
  (let ((current-window (selected-window)))
    (unwind-protect
        (progn
          (select-window (posn-window (event-start event)))
          (scroll-down my-num-lines))
      (select-window current-window))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; clipboard/x-select
;;;; with this, doing an M-y will also affect the X11 clipboard, making
;;;; emacs act as a sort of clipboard history, at least of text you've
;;;; pasted into it in the first place.
;;;; makes rotating the kill ring change the X11 clipboard.
;;; (setq yank-pop-change-selection t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tabs
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; Tab stops (up to 160 columns)
(setq tab-stop-list ())
(let ((counter 0))
  (while (< counter 160)
    ;;(setq tab-stop-list (cons counter tab-stop-list))
    (add-to-list 'tab-stop-list (- (- 160 1) counter))
    (setq counter (+ counter tab-width))
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; backups and autosave
(defvar backup-dir (concat emacs-dir "backups"))
(setq backup-directory-alist (list (cons "." backup-dir)))
(setq backup-by-copying t)
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Disable auto-save
(setq auto-save-default nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; parantheses
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; line numbers
(add-hook 'find-file-hook (lambda () (nlinum-mode 1)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; extra keywords
;; From <http://www.emacswiki.org/cgi-bin/wiki/AddBufferKeywords>
(defun add-fixme-highlighting ()
  "Turn on extra highlighting for 'FIXME' and the like."
  (font-lock-add-keywords nil '(("\\<\\(BUG\\|FIXME\\|TODO\\|NOTE\\|XXX+\\):"
                                 1 font-lock-warning-face prepend)))
  )
(add-hook 'find-file-hook 'add-fixme-highlighting t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; compilation mode & mode-compile
;; The default length of the compilation window
(setq compilation-window-height 24)
;; On compilation, don't ask for command
(setq compilation-read-command t)

;; Helper for compilation. Close the compilation window if there was
;; no error at all.
;; from <http://emacswiki.org/emacs/ModeCompile>
(defun compilation-exit-autoclose (status code msg)
  ;; If M-x compile exists with a 0
  (when (and (eq status 'exit) (zerop code))
    ;; then bury the *compilation* buffer, so that C-x b doesn't go there
    (bury-buffer)
    ;; and delete the *compilation* window
    (delete-window (get-buffer-window (get-buffer "*compilation*"))))
  ;; Always return the anticipated result of compilation-exit-message-function
  (cons msg code))
;; Specify my function (maybe I should have done a lambda function)
(setq compilation-exit-message-function 'compilation-exit-autoclose)


;; automatically save the current buffer when starting compilation
(setq mode-compile-always-save-buffer-p t)

;; Prefer clang
(add-hook 'mode-compile-before-compile-hook
          '(lambda ()
             (add-to-list 'cc-compilers-list "clang")
             (add-to-list 'c++-compilers-list "clang++")
             ))
;; Use C++11
(setq c++-default-compiler-options "-std=c++11 -g -Wall -Werror")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet
(setq yas-snippet-dirs (concat el-get-dir "yasnippet/snippets"))
(yas-global-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; whitespace-mode
;; From emacs-starter-kit
(autoload 'whitespace-mode "whitespace"
  "Toggle whitespace mode." t)
(autoload 'whitespace-toggle-options "whitespace"
  "Toggle local whitespace options." t)
(defun my-whitespace-style ()
  (setq whitespace-style '(face
                           trailing
                           lines-tail
                           tabs))
  (whitespace-mode 0)
  (whitespace-mode 1)
  )
;; setting whitespace-line-column to nil should do the trick, but
;; it doesn't seem to work, hence this:
(add-hook 'whitespace-mode-hook
          (lambda () (set (make-local-variable 'whitespace-line-column)
                          fill-column)))

(add-hook 'find-file-hook 'my-whitespace-style)

;; (add-hook 'write-file-functions
;;        'delete-trailing-whitespace)      ;; Trailing whitespace

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ido-mode
(ido-mode t)
(setq
 ido-enable-prefix nil
 ido-enable-flex-matching t
 ido-use-filename-at-point 'guess
 ido-use-virtual-buffers t
 )
(ido-everywhere t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-pair
(autopair-global-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; imenu
;; From <http://emacs.wordpress.com/2007/01/24/imenu-with-a-workaround/>
;; (add-hook 'c-mode-common-hook 'imenu-add-menubar-index)
(add-hook 'javascript-mode-hook 'imenu-add-menubar-index)
(add-hook 'javascript-load-hook 'imenu-add-menubar-index)
(add-hook 'html-mode-hook 'imenu-add-menubar-index)
(add-hook 'html-load-hook 'imenu-add-menubar-index)
(add-hook 'emacs-lisp-load-hook 'imenu-add-menubar-index)
(add-hook 'emacs-lisp-mode-hook 'imenu-add-menubar-index)
(add-hook 'latex-load-hook 'imenu-add-menubar-index)
(add-hook 'css-mode-hook 'imenu-add-menubar-index)
(add-hook 'sh-mode-hook 'imenu-add-menubar-index)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo-tree
(global-undo-tree-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; xml
;; nxml-mode is the default xml editing mode now
;; See https://curiousprogrammer.wordpress.com/2009/02/27/pretty-printing-xml/
(defun xml-pretty-print-region (start end)
  (interactive "r")
  (let ;;((b (get-buffer-create "*xml*")))
      ;; (switch-to-buffer-other-window b)
      ;; (xml-mode)
      ;; (erase-buffer)
      ;; (other-window -1)
      (goto-char end)
    (let ((e (point-marker)))
      (join-broken-lines start end)
      (call-process-region start e "xml-pretty-print.pl" nil t))))

(defconst cr (string ?\n))
(defconst *broken-line-regex* cr)

(defun join-broken-lines (start end)
  (interactive "r")
  (goto-char start)
  (while (re-search-forward *broken-line-regex* end t)
    (replace-match "" nil nil)))

(defun xml-pretty-print-current ()
  (interactive)
  (save-excursion
    (end-of-line nil)
    (re-search-backward ">" 1)
    (let ((e (+ 1 (point))))
      (beginning-of-line nil)
      (re-search-forward "<?xml[^>]*>" e)
      (xml-pretty-print-region (point) e))))

;; NOTE: C-M-i completes in nxml mode

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; any-ini-mode
(add-to-list 'auto-mode-alist '(".*\\.ini$" . any-ini-mode))
(add-to-list 'auto-mode-alist '(".*\\.conf$" . any-ini-mode))
(add-to-list 'auto-mode-alist '(".*\\.inf$" . any-ini-mode))
(add-to-list 'auto-mode-alist '(".*\\.desktop$" . any-ini-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; perl
(setq cperl-hairy t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; doc-mode & asciidoc
;; (add-to-list 'auto-mode-alist '("\\.adoc$" . doc-mode))
;; (add-to-list 'auto-mode-alist '("\\.asciidoc$" . doc-mode))
;; (add-hook 'doc-mode-hook
;;           '(lambda ()
;;              (turn-on-auto-fill)
;;              (require 'asciidoc)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hippie Expansion
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dirvars
(setq enable-local-variables :all)
;; (put 'eval 'safe-local-variable nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AUCTeX

(add-hook 'LaTeX-mode-hook
 (lambda ()
   (setq TeX-parse-self t)           ; Enable parse on load.
   (setq TeX-auto-save t)            ; Enable parse on save.
   (setq TeX-global-PDF-mode t)      ; PDF by default
   (turn-on-reftex)
   (turn-on-flyspell)
   (setq fill-column 80)
   ;; whitespace doesn't refresh automatically
   (whitespace-mode -1)
   (setq whitespace-style '(face
                            trailing
                            ;; lines-tail
                            tabs))
   (whitespace-mode t)
   ;; Use the open command on OS X
   (when on-mac
     (setq TeX-output-view-style
           '("^pdf$" "." open %o)))
   )
 )
(add-hook 'TeX-mode-hook (lambda()
                           (TeX-PDF-mode t)
                           ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mac OS X
(when on-mac
  ;; Let Cocoa handle alt/option (international input)
  (setq mac-option-modifier nil)
  ;; Command is command, alt/option is meta
  ;; (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'meta)
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bs (buffer switching)
(setq bs-default-sort-name "by name")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GDB
(setq gdb-many-windows t)
(setq gdb-use-separate-io-buffer nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; session
;;(add-hook 'after-init-hook 'session-initialize)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; qmake-mode
;; remove the Qmake menu item
(global-unset-key [menu-bar qmake-menu])


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; nxhtml-mode
;; (nxhtml-global-minor-mode -1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; web-mode

;; (require 'web-mode)
;; (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Groovy
;; (autoload 'groovy-mode "groovy-mode" "Groovy editing mode." t)

;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
;; (add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
;; (add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))

;; Gradle is Groovy
;; (add-to-list 'auto-mode-alist '("\.gradle$" . groovy-mode))

;;; make Groovy mode electric by default.
;; (add-hook 'groovy-mode-hook
;;           '(lambda ()
;;              (require 'groovy-electric)
;;              (groovy-electric-mode)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-complete
;;(require 'auto-complete-config)
;;(ac-config-default)
;;(global-auto-complete-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sourcepair
(load-file (concat el-get-dir "sourcepair/sourcepair.el"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GLSL (from https://github.com/jimhourihan/glsl-mode)
(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.geom\\'" . glsl-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Scala (scala-mode2) <https://github.com/hvesalai/scala-mode2>
(add-to-list 'auto-mode-alist '("\\.sbt$" . scala-mode))
(add-hook 'scala-mode-hook
          (lambda ()
            (setq scala-indent:align-forms t)
            (setq scala-indent:align-parameters t)
            (setq scala-indent:indent-value-expression t)
            ))



(server-start)
