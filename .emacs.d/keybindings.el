;; this loads the defaults (M-y)
(browse-kill-ring-default-keybindings)

(global-set-key (kbd "C-w") 'clipboard-kill-region)
(global-set-key (kbd "M-w") 'clipboard-kill-ring-save)
(global-set-key (kbd "C-y") 'clipboard-yank)

(global-set-key (kbd "C-x C-c") 'quit-emacs-prompt)
(global-set-key (kbd "C-x C-b") 'bs-show) ;; Buffer switching
(global-set-key (kbd "M-/") 'hippie-expand) ;; Expansion
(global-set-key (kbd "C-,") 'completion-at-point)

;; Scrolling (Mouse Wheel)
(global-set-key (kbd "<mouse-5>") 'sd-mousewheel-scroll-up)
(global-set-key (kbd "<mouse-4>") 'sd-mousewheel-scroll-down)

;; Disable any additional mouse keys/wheels/etc.
(defun nop()
  (message "nop"))
(global-set-key (kbd "<mouse-6>") (lambda() (nop)))
(global-set-key (kbd "<mouse-7>") (lambda() (nop)))

(when on-mac
  (global-set-key (kbd "<wheel-down>") 'sd-mousewheel-scroll-up)
  (global-set-key (kbd "<wheel-up>") 'sd-mousewheel-scroll-down))

(global-set-key (kbd "<f1>") 'compile)
(global-set-key (kbd "C-c c") 'mode-compile)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "<M-return>") 'complete-tag)

(global-set-key (kbd "C-x C-/") 'goto-last-change)


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


;; Spelling
(global-set-key [f2] 'flyspell-mode)


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

(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
     (define-key flyspell-mouse-map [mouse-3] #'undefined)))


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
