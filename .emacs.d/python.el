(add-hook 'python-mode-hook (lambda () (subword-mode 1)))

;; Scons files are python
(add-to-list 'auto-mode-alist '("\\Sconstruct$" . python-mode))
(add-to-list 'auto-mode-alist '("\\Sconscript$" . python-mode))
(add-to-list 'auto-mode-alist '("\\.sc$" . python-mode))

(add-to-list 'interpreter-mode-alist '(cons '("python" . python-mode)))

(setq-default python-guess-indent nil)
(setq-default python-indent tab-width)

(add-hook
 'python-mode-hook
 (lambda ()
   ;; Make RET add a newline and indent (in addittion to C-j)
   (define-key python-mode-map "\C-m" 'newline-and-indent)
   )
 )
