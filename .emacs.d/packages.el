(add-to-list 'load-path (concat emacs-dir "el-get/el-get"))

(require 'el-get)
(setq el-get-sources
      '(
        (:name ascii :type elpa)
        (:name exec-path-from-shell :type elpa)
        (:name nlinum :type elpa)
        (:name pyflakes :type elpa)
        (:name pylint :type elpa)
        (:name python-pylint :type elpa)
        ;; (:name shell-there :type elpa)
        (:name wgrep-ack :type elpa)
        )
)

(defvar my-packages
  '(
    ack
    adoc-mode ; asciidoc mode
    any-ini-mode
    auctex
    autopair
    ;; bookmark+
    browse-kill-ring
    cg-mode
    cmake-mode
    color-theme
    csv-mode
    ;; dirvars
    doc-mode
    etags-select
    ;; exec-path-from-shell
    flymake
    ;; gnuplot-mode
    ;; google-c-style
    highlight-parentheses
    htmlize
    icicles
    icicles-cmd1
    icicles-cmd2
    icicles-face
    icicles-fn
    icicles-iswitchb
    icicles-mcmd
    icicles-mode
    icicles-opt
    icicles-var
    json
    lua-mode
    ;; mmm-mode
    mode-compile
    move-text
    nxhtml
    qmake-mode
    redo+
    session
    slime
    sourcepair
    switch-window
    ;; tabbar
    unbound
    undo-tree
    vline
    wgrep
    wrap-region
    xgtags
    ;; xscope+
    yasnippet
    zenburn-theme
    ))

(when on-mac
  (add-to-list 'my-packages 'icicles-mac))

;; append the packages from el-get-sources
(setq my-packages
      (append my-packages
              (mapcar 'el-get-source-name el-get-sources)))

;; (el-get-emacswiki-refresh)
(el-get 'sync my-packages)
