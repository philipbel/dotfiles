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
;; reload-file (http://www.hakank.org/emacs/index.html)
(defun reload-file ()
  (interactive)
  (find-file (buffer-name))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; recent
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
;; exit
(defun quit-emacs-prompt ()
  (interactive)
  (if (yes-or-no-p "Quit Emacs?")
      (save-buffers-kill-terminal)
    )
  )
