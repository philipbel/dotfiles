(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

;; Remove the old values
;; (delete 'el-get-recipe-path-emacswiki el-get-recipe-path)
;; (delete 'el-get-recipe-path-elpa el-get-recipe-path)

;; The defaults are emacs-dir/el-get/el-get/recipes/{emacswiki,elpa}
;; (setq el-get-recipe-path-emacswiki (concat el-get-src-dir "recipes/emacswiki"))
;; (setq el-get-recipe-path-elpa (concat el-get-src-dir "recipes/elpa"))

;; Re-add them to the list
;; (add-to-list 'el-get-recipe-path el-get-recipe-path-emacswiki)
;; (add-to-list 'el-get-recipe-path el-get-recipe-path-elpa)


(setq el-get-sources
      '(
        ;; (:name exec-path-from-shell :type elpa)
        ;; (:name icicles-mac :type emacswiki)
        (:name nlinum :type elpa)
        ;; (:name pyflakes :type elpa)
        ;; (:name pylint :type elpa)
        ;; (:name python-pylint :type elpa)
        ;;; (:name shell-there :type elpa)
        ;; (:name wgrep-ack :type elpa)
        (:name glsl-mode
               :website https://github.com/jimhourihan/glsl-mode
               :description "GLSL major mode"
               :type github
               :pkgname "jimhourihan/glsl-mode")
        ))

(setq packages
      '(
        ;; ack
        ;; auto-complete
        any-ini-mode
        asciidoc
        auctex
        autopair
        ;; bookmark+
        browse-kill-ring
        ;; cg-mode
        cmake-mode
        ;; color-theme
        csv-mode
        ;; dirvars
        doc-mode
        ;; Emacs-Groovy-Mode
        ;; ess
        etags-select
        ;; flymake
        ;; gnuplot-mode
        ;; google-c-style
        goto-last-change
        highlight-parentheses
        htmlize
        ;; icicles
        ;; icicles-cmd1
        ;; icicles-cmd2
        ;; icicles-face
        ;; icicles-fn
        ;; icicles-iswitchb
        ;; icicles-mcmd
        ;; icicles-mode
        ;; icicles-opt
        ;; icicles-var
        json
        lua-mode
        ;;; mmm-mode
        ;; mode-compile
        ;; move-text
        ;; nxhtml
        ;; protobuf-mode
        pycomplete+
        pymacs
        ;; python-mode
        python-pep8
        ;; python-pylint
        qmake-mode
        ;; redo+
        ropemacs
        rust-mode
        ;; session
        scala-mode2
        slime
        sourcepair
        switch-window
        ;; tabbar
        unbound
        undo-tree
        vline
        ;; web-mode
        wgrep
        wrap-region
        xgtags
        ;; xscope+
        yasnippet
        ))

;; (when on-mac
;;  (add-to-list 'packages 'icicles-mac))


(setq packages
      (append
       packages
       (loop for src in el-get-sources collect (el-get-source-name src))))


(when (not (file-readable-p el-get-recipe-path-emacswiki))
  (message "Emacswiki directory %s doesn't exist, refreshing..."
           el-get-recipe-path-emacswiki)
  (el-get-emacswiki-refresh el-get-recipe-path-emacswiki t)
  )

(el-get 'sync packages)
