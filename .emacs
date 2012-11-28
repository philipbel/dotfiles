;; -*- emacs-lisp -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customizations
(setq custom-file "~/.emacs.d/custom.el")
;; The file's loaded at the end!


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq inhibit-startup-message t)                ;; No startup message...
(setq inhibit-startup-echo-area-message t)      ;; ...at all
(setq make-backup-files nil)                    ;; No backup files
;; (when (listp symbol-list)
;;   (dolist (symbol symbol-list)))


;; (setq frame-title-format "%b [%f] - Emacs")  ;; Frame customization
;; (setq frame-title-format "%f [%m] - Emacs")  ;; Frame title
(setq frame-title-format "%f")                  ;; Frame title
(setq icon-title-format "%f")                   ;; Iconified frame title
;;(add-to-list 'default-frame-alist
;;                       '(
;;                         frame-title-format . "%f [%m] - Emacs")
;;                       )


(tool-bar-mode -1)                              ;; No toolbar
;;(menu-bar-mode -1)                            ;; No menu-bar
(setq visible-bell t)                           ;; Bell
(column-number-mode t)                          ;; Columns
(show-paren-mode t)                             ;; Paren match highlighting
(transient-mark-mode t)                         ;; Make selections visible
(delete-selection-mode t)                       ;; Delete selections
(scroll-bar-mode (quote right))                 ; Scrollbars on the right
(set-scroll-bar-mode 'right)                    ;;
(setq tab-width 4)                              ;; \t = 4
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)
(setq fill-column 79)
(setq-default indent-tabs-mode nil)             ;; Don't use tabs
(blink-cursor-mode -1)                          ;; Don't blink
(global-font-lock-mode t)
;; (add-hook 'write-file-functions
;;        'delete-trailing-whitespace)      ;; Trailing whitespace
(fset 'yes-or-no-p 'y-or-n-p)
(iswitchb-mode t)                           ;; Really nice C-x b switching
(setq require-final-newline t)              ;; Require final newline
;; (server-start)
(set-default 'indicate-empty-lines t)       ;; Indicaate empty lines
(global-linum-mode 1)                           ;; always show line numbers
(global-hl-line-mode 1)                         ;; highlight current line
(auto-fill-mode t)



;; For mouse handling in an xterm
(unless window-system
  (xterm-mouse-mode t)
  (mouse-wheel-mode t))


;; Tab stops
(setq tab-stop-list ())
(let ((counter 0))
  (while (< counter 160)
    ;;(setq tab-stop-list (cons counter tab-stop-list))
    (add-to-list 'tab-stop-list (- (- 160 1) counter))
    (setq counter (+ counter tab-width))
    )
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load path
(add-to-list 'load-path "~/.emacs.d/modules")
;; (add-to-list 'load-path "~/.emacs.d/packages/cc-mode")
(add-to-list 'load-path "~/.emacs.d/packages/python-mode")
(add-to-list 'load-path "~/.emacs.d/packages/actionscript-mode")
(add-to-list 'load-path "~/.emacs.d/packages/any-ini-mode")
(add-to-list 'load-path "~/.emacs.d/packages/cg-mode")
(add-to-list 'load-path "~/.emacs.d/packages/gnuplot-mode")
;; (add-to-list 'load-path "~/.emacs.d/packages/color-theme")
;; (add-to-list 'load-path "~/.emacs.d/packages/color-theme/themes")
(add-to-list 'load-path "~/.emacs.d/packages/template/lisp")
(add-to-list 'load-path "~/.emacs.d/packages/ruby-mode")
(add-to-list 'load-path "~/.emacs.d/packages/yasnippet")
(add-to-list 'load-path "~/.emacs.d/packages/mmm-mode")
(add-to-list 'load-path "~/.emacs.d/packages/nxhtml")
(add-to-list 'load-path "~/.emacs.d/packages/icicles")
;;(add-to-list 'load-path "~/.emacs.d/packages/dvc")

(add-to-list 'load-path "/usr/share/emacs/site-lisp")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/global")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/autoconf")
(add-to-list 'load-path "/usr/share/emacs/site-lisp/dictionaries-common")


;; (when (file-exists-p "/usr/share/emacs/site-lisp/site-gentoo.el")
;;   (load "/usr/share/emacs/site-lisp/site-gentoo"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load site-start files
(setq global-site-file-list
      '("/usr/share/emacs/site-lisp/site-start.el"
       "/usr/local/share/emacs/site-lisp/site-start.el"
       ))

(mapc '(lambda (x)
         (when (file-exists-p x)
           (load x))
         )
       global-site-file-list
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet <http://code.google.com/p/yasnippet/>
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/packages/yasnippet/snippets")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; unbound <http://www.emacswiki.org/emacs/unbound.el>
(require 'unbound)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Clean up
;; From emacs-starter-kit
(defun tabify-buffer ()
  (interactive)
  (tabify (point-min) (point-max)))

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (untabify-buffer)
  (indent-buffer)
  (delete-trailing-whitespace))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
  (whitespace-mode t)
)

(setq whitespace-line-column nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; grep+
(require 'grep+)

;;(grep-compute-defaults)
(if (eq window-system 'mac)
    (setq grep-find-command "find . -path '*/.svn/*' -prune -o -path '*/docs/*' -prune -o -path '*/build/*' -prune -o -path '*/obj/*' -prune -o -name TAGS -prune -o -path '*/external/*' -prune -o -name Doxyfile -prune -o -name CMakeLists.txt -prune -o -name 'cscope.*' -prune -o -type f -print | xargs grep -Ine ")
  (setq grep-find-command "find . -path '*/.svn/*' -prune -o -path '*/docs/*' -prune -o -path '*/build/*' -prune -o -path '*/obj/*' -prune -o -name TAGS -prune -o -path '*/external/*' -prune -o -name Doxyfile -prune -o -name CMakeLists.txt -prune -o -name 'cscope.*' -prune -o -type f -print | xargs -e grep -Ine "))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mode-compile
;; (autoload 'mode-compile "mode-compile"
;;   "Command to compile current buffer file based on the major mode" t)
;; (autoload 'mode-compile-kill "mode-compile"
;;   "Command to kill a compilation launched by `mode-compile'" t)
;; (global-set-key "\C-cc" 'mode-compile)
;; (global-set-key "\C-ck" 'mode-compile-kill)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Matlab
(autoload 'matlab-mode "matlab" "Enter MATLAB mode." t)
(setq auto-mode-alist (cons '("\\.mat\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ESS
;; (load "~/.emacs.d/packages/ess/lisp/ess-site")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; compilation mode
;; The default length of the compilation window
(setq compilation-window-height 24)
;; On compilation, don't ask for command
(setq compilation-read-command t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; skeleton pair
;; Note: These are remapped in cc-mode, because cc-mode rebinds the keys
;; to its own commands
(setq skeleton-pair t)
(setq skeleton-pair-on-word t)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; imenu
;; From <http://emacs.wordpress.com/2007/01/24/imenu-with-a-workaround/>
(add-hook 'c-mode-common-hook 'imenu-add-menubar-index)
(add-hook 'javascript-mode-hook 'imenu-add-menubar-index)
(add-hook 'javascript-load-hook 'imenu-add-menubar-index)
(add-hook 'html-mode-hook 'imenu-add-menubar-index)
(add-hook 'html-load-hook 'imenu-add-menubar-index)
(add-hook 'emacs-lisp-load-hook 'imenu-add-menubar-index)
(add-hook 'emacs-lisp-mode-hook 'imenu-add-menubar-index)
(add-hook 'latex-load-hook 'imenu-add-menubar-index)
(add-hook 'css-mode-hook 'imenu-add-menubar-index)
(add-hook 'sh-mode-hook 'imenu-add-menubar-index)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CC-mode
;; (setq c-auto-newline t)

;; Do not check for old-style (K&R) function declarations, makes
;; indenting faster
(setq c-recognize-knr-p nil)


(defun my-c-mode-common-hook ()
  (subword-mode 1)
  (abbrev-mode -1)
  ;; skeleton pair
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  ;; (local-set-key (kbd "{") 'my-c-mode-brace-func)
  (local-set-key (kbd "RET") 'c-context-line-break)
  (my-whitespace-style)
  ;; (semantic-mode)
  ;;(setq completion-at-point-functions
  ;;      '(semantic-completion-at-point-function 
  ;;        tags-completion-at-point-function))
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun setup-c-comments-hook ()
  (message "Setting up C-style comments")
  (setq comment-start "/*")
  (setq comment-end "*/")
  (setq comment-padding "")
  )
(add-hook 'c-mode-hook 'setup-c-comments-hook)
(add-hook 'c++-mode-hook 'setup-c-comments-hook)
(add-hook 'java-mode-hook 'setup-c-comments-hook)
(add-hook 'objc-mode-hook 'setup-c-comments-hook)


;; (defun my-c++-mode-hook ()
;;   (setq comment-start "//")
;;   (setq comment-end "")
;;   )
;; (add-hook 'c++-mode-hook 'my-c++-mode-hook)

;; Phible's C/C++ style
(defconst phible-c-style
  '("stroustrup"
    (c-basic-offset . 4)
    (tab-width . 4)
    (indent-tabs-mode . nil)
    (c-offsets-alist . ((innamespace . 0)
                        (inline-open . 0)
                        (inextern-lang . 0)
                        ;; (statement-cont . c-lineup-math)
                        ))
    (c-hanging-braces-alist . ((defun-open after)
                               (defun-close before after)
                               (class-open after)
                               (class-close before after)
                               (namespace-open after)
                               (inline-open after)
                               (inline-close before after)
                               (block-open before)
                               (block-close . c-snug-do-while)
                               (extern-lang-open after)
                               (extern-lang-close after)
                               (substatement-open before)
                               ))
    (c-hanging-colons-alist . ((case-label)
                               (label after)
                               (access-label after)
                               (member-init-intro before)
                               (inher-intro)
                               ))
    )
  "Phible'c c-style"
  )
(c-add-style "phible" phible-c-style)


;; From <http://www.emacswiki.org/CcMode>
(setq artm-c-styles-alist
      '((nil . "phible")))
; Boost's .ipp files
(add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))
(defun artm-guess-c-style ()
  (let ((style
         (assoc-default buffer-file-name artm-c-styles-alist
                        (lambda (pattern path)
                          (or (not pattern)
                              (and (stringp path)
                                   (string-match pattern path)))
                          )
                        ;; factory default (in case you forget
                        ;; to add (nil . "some style") to
                        ;; artm-c-styles-alist
                        '(nil . "phible"))))
    (cond
     ((stringp style) (c-set-style style))
     ((functionp style) (style))
     )
    )
  )
(add-hook 'c-mode-common-hook 'artm-guess-c-style)

;; Default style
(defun apply-default-c-style ()
  (c-set-style "phible"))
(add-hook 'c-mode-common-hook 'apply-default-c-style)


;; Do not expand TABS when deleting them
;; (setq backward-delete-function nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Doxymacs (Doxygen comments in Emacs)
(if (require 'doxymacs nil t)
    (progn
      (defun apply-doxymacs-font-lock ()
        (if (or (eq major-mode 'c-mode)
                (eq major-mode 'c++-mode)
                (eq major-mode 'objc-mode)
                )
            (doxymacs-font-lock)))
      (add-hook 'font-lock-mode-hook 'apply-doxymacs-font-lock)
      (add-hook 'c-mode-common-hook 'doxymacs-mode))
  (message "%s" "Doxymacs not found")
  )

(setq doxymacs-function-comment-template 
      '((let ((next-func (doxymacs-find-next-func)))
            (if next-func
                (list
                 'l
                 'n
                 'n
                 "/**" '> 'n
                 " * @" 'p '> 'n
                 " *" '> 'n
                 (doxymacs-parm-tempo-element (cdr (assoc 'args next-func)))
                 (unless (string-match
                          (regexp-quote (cdr (assoc 'return next-func)))
                          doxymacs-void-types)
                   '(l " *" > n " * " (doxymacs-doxygen-command-char)
                       "return " (p "Returns: ") > n))
                 " */" '>
                 'n)
              (progn
                (error "Can't find next function declaration.")
                nil)
              )
            ))
      )
      


;; (defun phible-cc ()
;;   (interactive)
;;   (setq c-basic-offset 4)
;;   (setq tab-width 4)
;;   (setq indent-tabs-mode t)
;;   )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Qt stuff
;; <http://www.emacswiki.org/cgi-bin/wiki?QtMode>
(setq c-C++-access-key
      "\\<\\(slots\\|signals\\|private\\|protected\\|public\\)\\>[ \t]*[(slots\\|signals)]*[ \t]*:")
(font-lock-add-keywords 'c++-mode '(("\\<\\(Q_OBJECT\\|Q_PROPERTY\\|READ\\|WRITE\\|public slots\\|public signals\\|private slots\\|private signals\\|protected slots\\|protected signals\\|foreach\\|forever\\|SIGNAL\\|SLOT\\)\\>" . font-lock-constant-face)))






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Objective-C
(add-to-list 'auto-mode-alist '("\\.m\\'" . objc-mode))
(add-to-list 'auto-mode-alist '("\\.mm\\'" . objc-mode))
;; Workaround for imenu and Objective-C (imenu-progress-message not defined)
;; <http://emacs.wordpress.com/2007/01/24/imenu-with-a-workaround>



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Kernel Hacking Style
(defun linux-c-mode ()
  "Applies Linus' coding conventions for using when hacking on the Kernel."
  (interactive)
  (c-mode)
  (c-set-style "k&r")
  (setq tab-width 8)
  (setq require-final-newline t)
  ;;(speedbar)
  )
;;(setq auto-mode-alist (cons '("/usr/src/linux.*/.*\\.[ch]$" .
(setq auto-mode-alist (cons '(".*/linux.*/.*\\.[ch]$" .
                              linux-c-mode)
                            auto-mode-alist))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Java Style
(defun my-java-mode-hook ()
  (c-set-offset 'inline-open 0))
(add-hook 'java-mode-hook 'my-java-mode-hook)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ebuild/Eclass
;; (defun ebuild-mode ()
;;   (shell-script-mode)
;;   (sh-set-shell "bash")
;;   (make-local-variable 'tab-width)
;;   (setq tab-width 4)
;;   )

;; (setq auto-mode-alist (cons '("\\.ebuild\\'" . ebuild-mode) auto-mode-alist))
;; (setq auto-mode-alist (cons '("\\.eclass\\'" . ebuild-mode) auto-mode-alist))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GLSL
(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; nxml-mode
(add-to-list 'auto-mode-alist
             (cons (concat "\\." (regexp-opt '("xml" "xsd" "sch"
                                               "rng" "xslt" "svg" "rss") t) "\\'")
                   'nxml-mode))
;; Use nxml-mode instead of sgml, xml or html mode.
(mapc
 (lambda (pair)
   (if (or (eq (cdr pair) 'xml-mode)
           (eq (cdr pair) 'sgml-mode)
	   ;; (eq (cdr pair) 'html-mode)
           )
       (setcdr pair 'nxml-mode)))
 magic-mode-alist)

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




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; nXhtml
;; (load "nxhtml-autostart.el")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CSS
(autoload 'css-mode "css-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
(setq css-indent-level tab-width)       ; default is 3


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; javascript-mode (Karl Landström’s version)
;; <http://www.brgeight.se/downloads/emacs/javascript.el>
(autoload 'javascript-mode "javascript" "JavaScript editing mode" t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Python
(autoload 'python-mode "python-mode" "Python editing mode." t)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))

;; Scons files are python
(add-to-list 'auto-mode-alist '("\\Sconstruct$" . python-mode))
(add-to-list 'auto-mode-alist '("\\Sconscript$" . python-mode))
(add-to-list 'auto-mode-alist '("\\.sc$" . python-mode))

(add-to-list 'interpreter-mode-alist '(cons '("python" . python-mode)))
(add-hook 'python-mode-hook
          (lambda ()
            (set (make-variable-buffer-local 'beginning-of-defun-function)
                 'py-beginning-of-def-or-class)
            (setq outline-regexp "def\\|class ")))
(add-hook 'python-mode-hook 'my-whitespace-style)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ido-mode
(when (> emacs-major-version 21)
  (ido-mode t)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point nil
        ido-max-prospects 10))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ruby
(autoload 'ruby-mode "ruby-mode" "Ruby editing mode." t)
(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("ruby" . ruby-mode)
                                   interpreter-mode-alist))
;; (require 'ruby-block)
;; do overlay
;;(setq ruby-block-highlight-toggle 'overlay)
;; display to minibuffer
;; (setq ruby-block-highlight-toggle 'minibuffer)
;; display to minibuffer and do overlay
;;(setq ruby-block-highlight-toggle t)
;; (require 'ruby-electric)

(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")

;; NOTE: The following is an alternative to the progn below
;; (require 'flymake-ruby)
;; (add-hook 'ruby-mode-hook 'flymake-ruby-load)

;; This comes from <git://github.com/technomancy/emacs-starter-kit.git>
;;  emacs-starter-kit/starter-kit-ruby.el
(eval-after-load 'ruby-mode
  '(progn
     ;; work around possible elpa bug
     (ignore-errors (require 'ruby-compilation))
     (setq ruby-use-encoding-map nil)
     (add-hook 'ruby-mode-hook 'inf-ruby-keys)
     (define-key ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
     (define-key ruby-mode-map (kbd "C-c l") "lambda")
     ;; Override C-M-h, because ruby-mode overwrites the global one
     (define-key ruby-mode-map (kbd "C-M-h") 'backward-kill-word)
     (require 'ruby-electric)
     (ruby-electric-mode)
     ;; (ruby-block-mode t)
     (setq ruby-indent-tabs-mode nil)
     (setq ruby-indent-level 4)
     ;; ri requires ri_repl from <http://p.hagelb.org/ri_repl>
     (require 'ri)
     ))
(global-set-key (kbd "C-h r") 'ri)

;; Rake files are ruby, too, as are gemspecs.
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))

;; We never want to edit Rubinius bytecode
(add-to-list 'completion-ignored-extensions ".rbc")

(eval-after-load 'ruby-mode
  '(progn
     (require 'flymake)

     ;; Invoke ruby with '-c' to get syntax checking
     (defun flymake-ruby-init ()
       (let* ((temp-file (flymake-init-create-temp-buffer-copy
                          'flymake-create-temp-inplace))
              (local-file (file-relative-name
                           temp-file
                           (file-name-directory buffer-file-name))))
         (list "ruby" (list "-c" local-file))))

     (push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
     (push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

     (push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3)
           flymake-err-line-patterns)

     (add-hook 'ruby-mode-hook
               (lambda ()
                 (when (and buffer-file-name
                            (file-writable-p
                             (file-name-directory buffer-file-name))
                            (file-writable-p buffer-file-name))
                   (local-set-key (kbd "C-c d")
                                  'flymake-display-err-menu-for-current-line)
                   (flymake-mode t)
                   ;;(imenu-add-menubar-index)
                   )))))
(add-hook 'ruby-mode-hook 'my-whitespace-style)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ActionScript (by PET TOMATO, http://blog.pettomato.com/?p=12)
(add-to-list 'auto-mode-alist '("\\.as$" . actionscript-mode))
(autoload 'actionscript-mode "actionscript-mode"
  "ActionScript editing mode." t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; any-ini-mode (http://www.emacswiki.org/cgi-bin/wiki/any-ini-mode.el)
(add-to-list 'auto-mode-alist '(".*\\.ini$" . any-ini-mode))
(add-to-list 'auto-mode-alist '(".*\\.conf$" . any-ini-mode))
(add-to-list 'auto-mode-alist '(".*\\.inf$" . any-ini-mode))
(add-to-list 'auto-mode-alist '(".*\\.desktop$" . any-ini-mode))
(autoload 'any-ini-mode "any-ini-mode"
  "Mode for editing configuration files." t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Cg (http://www.emacswiki.org/cgi-bin/wiki/cg-mode.el)
(add-to-list 'auto-mode-alist '("\\.cg\\'" . cg-mode))
(add-to-list 'auto-mode-alist '("\\.fx\\'" . cg-mode))
(add-to-list 'auto-mode-alist '("\\.cgfx\\'" . cg-mode))
(autoload 'cg-mode "cg-mode" "Mode for editing Cg files." t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CPerl (included with Emacs)
(defalias 'perl-mode 'cperl-mode)
(require 'cperl-mode)
;; (setq cperl-style-alist
;;    (cons '("phible"
;;            (cperl-indent-level . 4)
;;            (cperl-brace-offset . 0)
;;            (cperl-continued-brace-offset . -4)
;;            (cperl-label-offset . -4)
;;            (cperl-continued-statement-offset . 4)
;;            (cperl-merge-trailing-else . t))
;;          cperl-style-alist))
;; (cperl-set-style "phible")
(setq cperl-hairy t) ;; Turns on most of the CPerlMode options



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CMake mode
(require 'cmake-mode)
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cmake" . cmake-mode))

(defun my-cmake-mode-hook ()
  (local-set-key (kbd "C-c C-c") 'comment-region))
(add-hook 'cmake-mode-hook 'my-cmake-mode-hook)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; doc-mode & asciidoc
(autoload 'doc-mode "doc-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.adoc$" . doc-mode))
(add-to-list 'auto-mode-alist '("\\.asciidoc$" . doc-mode))
(add-hook 'doc-mode-hook
          '(lambda ()
             (turn-on-auto-fill)
             (require 'asciidoc)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lua-mode
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AWK mode (in cc-mode)
(autoload 'awk-mode "cc-mode" nil t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bison (Yacc)
;;(setq load-path (cons "~/.emacs.d/packages/bison-mode" load-path))
;;(add-to-list 'auto-mode-alist '("\\.y\\'" . bison-mode))
;;(autoload 'bison-mode "bison-mode" "Mode for editing bison/yacc files." t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SVN (Subversion)
;; (require 'psvn)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DVC (Distributed version control for bzr, et al.)
;; (add-to-list 'load-path "~/.emacs.d/packages/dvc/lisp/")
;; (add-to-list 'Info-default-directory-list "~/.emacs.d/packages/texinfo")
;; (if (featurep 'dvc-core)
;;  (dvc-reload)
;;   (require 'dvc-autoloads))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; p4el <http://p4el.sourceforge.net/>
;;(load-library "p4")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gnuplot-mode
(autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
(autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)
(add-to-list 'auto-mode-alist '("\\.gnuplot$" . gnuplot-mode))
(add-to-list 'auto-mode-alist '("\\.gplot$" . gnuplot-mode))
(add-to-list 'auto-mode-alist '("\\.gp$" . gnuplot-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mmm-mode
;; (require 'mmm-auto)
;; (setq mmm-global-mode 'maybe)
;; (mmm-add-mode-ext-class 'html-mode "\\.php\\'" 'html-php)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; qt-pro
(require 'qt-pro)
(add-to-list 'auto-mode-alist '("\\.pr[io]$" . qt-pro-mode))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mousewheel
(setq my-num-lines 5)
;; On Mac use a smaller value
(cond ((eq window-system 'mac)
       (setq my-num-lines 1)))

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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto Complete Mode
;; <http://cx4a.org/software/auto-complete>
;;(add-to-list 'load-path "~/.emacs.d/packages/auto-complete")
;;(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;;(ac-config-default)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Switching between header and source
(load "sourcepair.el")
;; (setq sourcepair-header-path '("." ".." "~/projects/fx/*"))
;; (setq sourcepair-source-path '("." ".." "~/projects/fx/*"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Color theme
;; http://www.emacswiki.org/cgi-bin/wiki?ColorTheme#ColorTheme1
;; (require 'color-theme)
;; (color-theme-initialize)
;; Nice themes are
;; Bharadwaj
;; Blipp Blopp
;; Cooper Light
;; Cooper Light 2
;; Feng Shui
;; High Contrast *
;; JB Simple *
;; Katester **
;; Misty Day *
;; billw **
;;(color-theme-billw)
;;(color-theme-katester)
;;(color-theme-high-contrast)
;;(color-theme-feng-shui)
;;(color-theme-marquardt)
;;(color-theme-sitaramv-nt)
;;(color-theme-emacs-21)
;; (color-theme-xemacs)
;;(color-theme-vim-colors)
;; zenburn is in a separate file, so require is required :)
;; (require 'zenburn)
;; (color-theme-zenburn)
;; (setq color-theme-is-global t)

;; (defadvice make-frame (around frob-frame-parameters activate)
;;   ;; (setq default-frame-alist (add-to-list 'default-frame-alist parameters-alist))
;;   (setq default-frame-alist
;;  (list (car default-frame-alist)
;;        (cdr default-frame-alist)
;;        (car (frame-parameters))
;;        (cdr (frame-parameters))))
;;   ad-do-it
;;   )

;; (defadvice make-frame (around frob-frame-parameters activate)
;;  (let (
;;      (default-frame-alist (frame-parameters))
;;      )
;;  ad-do-it))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; template
;; <http://emacs-template.sourceforge.net/>
;; (require 'template)
;; (template-initialize)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; browse-kill-ring
(require 'browse-kill-ring)
;; this loads the defaults (M-y)
(browse-kill-ring-default-keybindings)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; highlight-current-line
;; (require 'highlight-current-line)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cscope (xcscope comes with cscope and is installed in
;; /usr/share/emacs by default
;; (require 'xcscope)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dirvars
(require 'dirvars)
(setq enable-local-eval t)
(put 'eval 'safe-local-variable nil)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AUCTeX

(if (load "auctex.el" t nil)
    (progn
      (load "preview-latex.el" t nil)

      (setq TeX-parse-self t)           ; Enable parse on load.
      (setq TeX-auto-save t)            ; Enable parse on save.
      (setq TeX-global-PDF-mode t)      ; PDF by default
      (add-hook 'TeX-mode-hook
                (lambda()
                  (TeX-PDF-mode t)
                  )
                )
      (add-hook 'latex-mode-hook 'turn-on-reftex)
      (add-hook 'LaTeX-mode-hook 'turn-on-reftex))
  (message "%s" "AuCTeX not found")
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Global's gtags
;; (autoload 'gtags-mode "gtags" "" t)
;; (require 'xgtags)
;; (add-hook 'c-mode-common-hook
;;        (lambda () (xgtags-mode 1)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tags
;; (setq tags-table-list '("~/src/tags/usr/include"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; etags-select
;; <http://www.emacswiki.org/emacs/EtagsSelect>
(require 'etags-select)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Icicles
;; http://www.emacswiki.org/cgi-bin/wiki/Icicles
(require 'icicles)
;;(icicle-mode t)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Indent & Unindent

;; Shift the selected region right if distance is postive, left if
;; negative
(defun shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      ;; Tell the command loop not to deactivate the mark
      ;; for transient mark mode
      (setq deactivate-mark nil))))

(defun shift-right ()
  "Indent a region"
  (interactive)
  (shift-region 1))

(defun shift-left ()
  "Unindent a region"
  (interactive)
  (shift-region -1))

;; http://www.emacswiki.org/cgi-bin/wiki/IndentingC
;; Setting TAB to indent region if anything is selected,
;; otherwise c-indent-command
;; (defun fledermaus-maybe-tab ()
;;   (interactive)
;;   (if (and transient-mark-mode mark-active)
;;    (indent-region (region-beginning) (region-end) nil)
;;  (c-indent-command)))
;; (defun tab-indents-region () (local-set-key [(tab)] 'my-maybe-tab))
;; (add-hook 'c-mode-common-hook 'tab-indents-region)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Spelling
(setq ispell-program-name "aspell")
(setq ispell-process-directory (expand-file-name "~/")) ; Add personal dictionaries


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Speedbar
;; (when window-system
;;  (speedbar t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Buffer Switching
(require 'bs)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Which-Function
(which-func-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; reload-file (http://www.hakank.org/emacs/index.html)
(defun reload-file ()
  (interactive)
  (find-file (buffer-name))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; imenu/ido
(set-default 'imenu-auto-rescan t)

;; <emacs-starter-kit>
(defun ido-imenu ()
  "Update the imenu index and then use ido to select a symbol to navigate to.
Symbols matching the text at point are put first in the completion list."
  (interactive)
  (imenu--make-index-alist)
  (let ((name-and-pos '())
        (symbol-names '()))
    (flet ((addsymbols (symbol-list)
                       (when (listp symbol-list)
                         (dolist (symbol symbol-list)
                           (let ((name nil) (position nil))
                             (cond
                              ((and (listp symbol) (imenu--subalist-p symbol))
                               (addsymbols symbol))

                              ((listp symbol)
                               (setq name (car symbol))
                               (setq position (cdr symbol)))

                              ((stringp symbol)
                               (setq name symbol)
                               (setq position (get-text-property 1 'org-imenu-marker symbol))))

                             (unless (or (null position) (null name))
                               (add-to-list 'symbol-names name)
                               (add-to-list 'name-and-pos (cons name position))))))))
      (addsymbols imenu--index-alist))
    ;; If there are matching symbols at point, put them at the beginning of `symbol-names'.
    (let ((symbol-at-point (thing-at-point 'symbol)))
      (when symbol-at-point
        (let* ((regexp (concat (regexp-quote symbol-at-point) "$"))
               (matching-symbols (delq nil (mapcar (lambda (symbol)
                                                     (if (string-match regexp symbol) symbol))
                                                   symbol-names))))
          (when matching-symbols
            (sort matching-symbols (lambda (a b) (> (length a) (length b))))
            (mapc (lambda (symbol) (setq symbol-names (cons symbol (delete symbol symbol-names))))
                  matching-symbols)))))
    (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
           (position (cdr (assoc selected-symbol name-and-pos))))
      (goto-char position))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; recent
;; Save a list of recent files visited.
(recentf-mode 1)

(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))

;; From <http://www.emacswiki.org/emacs/download/lazycat-toolkit.el>
(defun clean-recentf-history ()
  "Clean recentf history of file assoc."
  (interactive)
  (setq recentf-list '())
  (message "Have clean recentf history."))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GDB
(setq gdb-many-windows t)
(setq gdb-use-separate-io-buffer nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; session <http://emacs-session.sourceforge.net/>
(require 'session)
(add-hook 'after-init-hook 'session-initialize)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tabbar-mode <http://emhacks.sourceforge.net/>
;; (require 'tabbar)
;; (tabbar-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Copy Without Selection
;; <http://www.emacswiki.org/emacs/CopyWithoutSelection>
(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (let ((beg (progn (if (looking-back "[a-zA-Z0-9]" 1) (backward-word 1)) (point)))
        (end (progn (forward-word arg) (point))))
    (copy-region-as-kill beg end))
  )

(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line "
  (interactive "P")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (copy-region-as-kill beg end))
  )

(defun copy-paragraph (&optional arg)
  "Copy paragraphes at point"
  (interactive "P")
  (let ((beg (progn (backward-paragraph 1) (point)))
        (end (progn (forward-paragraph arg) (point))))
    (copy-region-as-kill beg end))
  )

(defun copy-string (&optional arg)
  "Copy a sequence of string into kill-ring"
  (interactive)
  (setq onPoint (point))
  (let (
        ( beg   (progn (re-search-backward "[\t ]" (line-beginning-position) 3 1)
                       (if (looking-at "[\t ]") (+ (point) 1) (point) ) )
                )
        ( end  (progn  (goto-char onPoint) (re-search-forward "[\t ]" (line-end-position) 3 1)
                       (if (looking-back "[\t ]") (- (point) 1) (point) ) )
               ))
    (copy-region-as-kill beg end)
    )
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; duplicate-line
;; <http://stackoverflow.com/questions/88399/how-do-i-duplicate-a-whole-line-in-emacs>
(defun duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")
  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))
  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion
      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))

      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count)))
        )
      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let
  ;; put the point in the lowest line and return
  (next-line arg))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; exit
(defun quit-emacs-prompt ()
  (interactive)
  (if (yes-or-no-p "Quit Emacs?")
      (save-buffers-kill-terminal)
    )
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Clibpard
;;;; <http://emacswiki.org/emacs/CopyAndPaste#toc5>
;;;; (transient-mark-mode 1)  ; Now on by default: makes the region act quite like the text "highlight" in many apps.
;;;; (setq shift-select-mode t) ; Now on by default: allows shifted cursor-keys to control the region.

;;;; stops selection with a mouse being immediately injected to the kill ring
;;(setq mouse-drag-copy-region nil)
;;;; stops killing/yanking interacting with primary X11 selection
;;(setq x-select-enable-primary nil)
;;;; makes killing/yanking interact with clipboard X11 selection
;;(setq x-select-enable-clipboard t)
;;;; these will probably be already set to these values, leave them that way if so!
;;(setf interprogram-cut-function 'x-select-text)
;;(setf interprogram-paste-function 'x-cut-buffer-or-selection-value)
;;;; You need an emacs with bug #902 fixed for this to work properly. It
;;;; has now been fixed in CVS HEAD.  it makes "highlight/middlebutton"
;;;; style (X11 primary selection based) copy-paste work as expected if
;;;; you're used to other modern apps (that is to say, the mere act of
;;;; highlighting doesn't overwrite the clipboard or alter the kill
;;;; ring, but you can paste in merely highlighted text with the mouse
;;;; if you want to)

;;;;  active region sets primary X11 selection
;;(setq select-active-regions t)

;;;; make mouse middle-click only paste from primary X11 selection, not clipboard and kill ring.
;;(global-set-key [mouse-2] 'mouse-yank-primary)

;;;; with this, doing an M-y will also affect the X11 clipboard, making
;;;; emacs act as a sort of clipboard history, at least of text you've
;;;; pasted into it in the first place.
;;;; makes rotating the kill ring change the X11 clipboard.
;;; (setq yank-pop-change-selection t)

(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; KEY BINDINGS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Quit
(global-set-key (kbd "C-x C-c") 'quit-emacs-prompt)

;; Buffer switching
(global-set-key (kbd "C-x C-b") 'bs-show)

;; Expansion
(global-set-key (kbd "M-/") 'hippie-expand)

;; Scrolling (Mouse Wheel)
(global-set-key (kbd "<mouse-5>") 'sd-mousewheel-scroll-up)
(global-set-key (kbd "<mouse-4>") 'sd-mousewheel-scroll-down)

(defun nop()
  (message "nop"))
(global-set-key (kbd "<mouse-6>") (lambda() (nop)))
(global-set-key (kbd "<mouse-7>") (lambda() (nop)))

(cond ((eq window-system 'mac)
       (global-set-key (kbd "<wheel-down>") 'sd-mousewheel-scroll-up)
       (global-set-key (kbd "<wheel-up>") 'sd-mousewheel-scroll-down)))

;; Compilation
(global-set-key (kbd "<f1>") 'compile)

;; Goto line
(global-set-key (kbd "M-g") 'goto-line)

;; Complete tag
(global-set-key (kbd "<M-return>") 'complete-tag)

;; New Line and Indent
(defun my-new-line-and-indent()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-new-line-and-indent)

;; Switch between header and source (C/C++)
(global-set-key (kbd "<C-return>") 'sourcepair-load)
(global-set-key [(C kp-enter)] 'sourcepair-load)

;; Speedbar
;; (global-set-key (kbd "<f1>") 'speedbar)
(global-set-key (kbd "<f12>") (lambda()
                                (interactive)
                                (speedbar t)))

;; Server
;; (global-set-key (kbd "<f2>") 'server-start)


;; Indent & Unindent
(global-set-key (kbd "C-M->") 'shift-right)
(global-set-key (kbd "C-M-<") 'shift-left)

;; Uncomment <M-;>
;; (global-set-key (kbd "C-c C-M-c") 'uncomment-region)

;; Global (gtags) & xgtags
;; (global-set-key (kbd "<f2>") 'xgtags-find-tag-from-here)
;; (global-set-key (kbd "<S-mouse-2>") 'xgtags-find-tag-by-event)
;; (global-set-key (kbd "<S-mouse-3>") 'xgtags-pop-stack)
;; (global-set-key (kbd "M-*") 'xgtags-pop-stack)
;; (global-set-key (kbd "M-,") 'xgtags-select-next-tag)
;; (global-set-key (kbd "C-M-.") 'xgtags-switch-to-buffer-other-window)

;; Tags
(global-set-key (kbd "C-.") 'tags-search)

;; SVN
;; (global-set-key [f11] 'svn-status)

;; grep-find
(global-set-key (kbd "<f3>") 'grep-find)

;; reload-file
(global-set-key (kbd "<f5>") 'reload-file)

;; Don't bind C-z to (iconify-or-deiconify-frame)
(global-unset-key (kbd "C-z"))
;; Don't bind C-x C-z to (suspend-frame)
(global-unset-key (kbd "C-x C-z"))

;; spell check (normally bound to M-TAB, but this interferes with WMs)
(global-set-key (kbd "C-?") 'ispell-complete-word)
(global-set-key (kbd "C-M-?") 'ispell-comments-and-strings)

;; man page (C-x m is initially mapped to `compose-mail', but I don't care)
(global-set-key (kbd "C-x m") 'man)

;; what it says
(global-set-key (kbd "C-M-h") 'backward-kill-word)

;; Jump to a definition in the current file. (This is awesome.)
(global-set-key (kbd "C-x C-i") 'ido-imenu)

;; File finding
;; (global-set-key (kbd "C-x C-f") 'ido-find-file)
;; (global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
;; ;;(global-set-key (kbd "C-x C-M-f") 'find-file-in-project)
;; (global-set-key (kbd "C-x f") 'recentf-ido-find-file)
;; (global-set-key (kbd "C-x C-p") 'find-file-at-point)
;; (global-set-key (kbd "C-c y") 'bury-buffer) ; send buffer to the end of the ring
;; ;; (global-set-key (kbd "C-c r") 'revert-buffer)
;; ;; (global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)
;; (global-set-key (kbd "C-x C-M-b") 'ibuffer)

;; Perform general cleanup.
(global-set-key (kbd "C-c n") 'cleanup-buffer)

(global-set-key [f6] 'split-window-horizontally)
(global-set-key [f8] 'delete-window)

;; Copy Without Selection
(global-set-key (kbd "C-c w") 'copy-word)
(global-set-key (kbd "C-c l") 'copy-line)
(global-set-key (kbd "C-c p") 'copy-paragraph)
(global-set-key (kbd "C-c s") 'copy-string)

;; duplicate-line
(global-set-key (kbd "C-c v") 'duplicate-line)

;; etags-select
(global-set-key "\M-?" 'etags-select-find-tag-at-point)
(global-set-key "\M-." 'etags-select-find-tag)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Geometry (X)
;; Keep that the last thing here
;; See C-h v initial-frame-alist
;; Emacs-22 (no Anti-aliasing)
;; (setq initial-frame-alist '((top . 1) (left . 350) (width . 100) (height . 65)))
;; (setq default-frame-alist '((width . 100) (height . 65)))
;; Emacs-23, Monaco-9, Dejavu Sans Mono-9

;; (if (eq window-system 'mac)
;;     (progn
;;       (setq default-frame-alist
;;             '(
;;               (height . 50)
;;               (minibuffer . t)
;;               (right-fringe)
;;               (left-fringe)
;;               ))
;;       )
;;   (progn
(setq initial-frame-alist '((top . 1)
			    (left . 750)
			    (width . 120)
			    (height . 75)
			    (minibuffer . t)
			    (right-fringe)
			    (left-fringe)
			    (tool-bar-mode . nil)
			    (scroll-bar-mode . right)
			    ))
(setq default-frame-alist '((width . 120)
			    (height . 75)
			    (minibuffer . t)
			    (right-fringe)
			    (left-fringe)
			    (tool-bar-mode . nil)
			    (scroll-bar-mode . right)
			    ))
;;    )
;;  )

(put 'downcase-region 'disabled nil)


(load custom-file)




;;;;; INTERESTING THINGS ;;;;;
;; * org mode / org table mode
;; * textile ?
;; * markdown
;; * ELPA - package manager
;; * oddmuse - wiki editing
;; * hexcolor - http://mewde.blogspot.com/2007/05/what-comes-with-mewde.html

;; Places:
;; * <emacswiki.org>
;; * <planet.emacsen.org>


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Local file
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "~/.emacs.local" t)

