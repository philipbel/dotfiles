;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Platforms
(setq on-mac (eq 'darwin system-type))
(setq on-linux (eq 'gnu/linux system-type))
(setq on-windows (eq 'windows-nt system-type))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PATH
(let ((path-from-shell
       (replace-regexp-in-string
        "[ \t\n]*$" ""
        (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
  (setenv "PATH" path-from-shell)
  (setq exec-path (split-string path-from-shell path-separator)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; site-start file
(setq global-site-file-list
      '("/usr/share/emacs/site-lisp/site-start.el"
        "/usr/local/share/emacs/site-lisp/site-start.el"
        ))

(mapc '(lambda (x)
         (when (file-exists-p x)
           (load x))
         )
      global-site-file-list)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; local file
(setq local-file "~/.emacs.local.el")
(load local-file t nil t t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Settings
(defvar emacs-dir (file-name-as-directory "~/.emacs.d"))
(defvar el-get-dir (file-name-as-directory (concat emacs-dir "el-get")))
(defvar el-get-src-dir (file-name-as-directory
                        (concat el-get-dir "el-get")))
(add-to-list 'load-path el-get-src-dir)


(load-file (concat emacs-dir "packages.el"))
(load-file (concat emacs-dir "settings.el"))
(load-file (concat emacs-dir "functions.el"))
(load-file (concat emacs-dir "c.el"))
(load-file (concat emacs-dir "python.el"))
(load-file (concat emacs-dir "keybindings.el"))
(load-file (concat emacs-dir "colors.el"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file t)


;; Things to explore/consider
;; * org-mode
;; * textile
;; * markdown
;; * oddmuse - wiki editing
;; * hexcolor - http://mewde.blogspot.com/2007/05/what-comes-with-mewde.html
