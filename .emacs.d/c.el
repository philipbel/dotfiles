(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)


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
