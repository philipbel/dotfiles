;;; bzr-gnus.el --- bzr dvc integration to gnus

;; Copyright (C) 2008 by all contributors

;; Author: Stefan Reichoer <stefan@xsteve.at>

;; DVC is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; DVC is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; gnus is optional. Load it at compile-time to avoid warnings.
(eval-when-compile
  (condition-case nil
      (progn
        (require 'gnus)
        (require 'gnus-art)
        (require 'gnus-sum))
    (error nil)))

;;;###autoload
(defun bzr-insinuate-gnus ()
  "Integrate bzr into Gnus."
  (interactive)
  ;; there is nothing special to do yet...
  )

(defun bzr-gnus-article-view-patch (n)
  "View MIME part N in a gnus article, as a bzr changeset.
The patch can be embedded or external.  If external, the
parameter N is ignored."
  (interactive)
  (let ((num-of-mime-parts
         (save-window-excursion
           (gnus-summary-select-article-buffer)
           (gnus-article-mime-total-parts))))
    (if (> num-of-mime-parts 1)
        (bzr-gnus-article-view-attached-patch 2)
      (bzr-gnus-article-view-external-patch))))

(defun bzr-gnus-article-view-attached-patch (n)
  "View MIME part N, as bzr patchset."
  (interactive "p")
  (error "bzr-gnus-article-view-attached-patch not yet implemented"))

(defun bzr-gnus-article-view-external-patch ()
  "View an external patch that is referenced in this mail.

The mail must contain a line starting with 'Committed revision ' and ending
with the branch location."
  (interactive)
  (let ((revnr)
        (archive-location)
        (diff-buffer)
        (window-conf (current-window-configuration)))
    (gnus-summary-select-article-buffer)
    (split-window-vertically)
    (goto-char (point-min))
    ;; Committed revision 129 to http://my-arch.org/branch1
    (when (re-search-forward "Committed revision \\([0-9]+\\) to \\(.+\\)$" nil t)
      (setq revnr (match-string-no-properties 1))
      (setq archive-location (match-string-no-properties 2)))
    (gnus-article-show-summary)
    (if (and revnr archive-location)
        (progn
          (message "Viewing bzr revison: %s, location: %s" revnr archive-location)
          ;; bzr diff -r128..129 http://my-arch.org/branch1
          ;; Note: this command needs at least bzr v1.1
          (setq diff-buffer
                (bzr-delta `(bzr (revision (local "" ,(- (string-to-number revnr) 1))))
                           `(bzr (revision (local "" ,(string-to-number revnr))))
                           nil
                           archive-location))
          (save-excursion
            (set-buffer diff-buffer)
            (dvc-buffer-push-previous-window-config window-conf)))
      (message "No external bzr patch found in this article.")
      (set-window-configuration window-conf))))

(provide 'bzr-gnus)
;;; bzr-gnus.el ends here


