;; latex2png.el - emacs-wiki addon for generating png images from
;; inline LaTex code.

;; $Id: latex2png.el 41 2005-03-25 22:06:46Z ganesh $

;; Copyright (C) 2004, 2005 Ganesh Swami

;; Author: Ganesh Swami <ganesh AT iamganesh DOT com>
;; Created: May 01 2004
;; 

;; This is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; this software is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.


;;; Commentary:

;; Read The Fine Documentation at
;; http://www.sfu.ca/~gswamina/EmacsWikiBlog.html

;;; Code


(defvar gs-latex2png-scale-factor 2.5
  "The scale factor to be used for sizing the resulting latex.")
(defvar gs-latex2png-fg "Black"
  "The foreground color.")
(defvar gs-latex2png-bg "Transparent"
  "The background color.")


(defun gs-latex2png-move2pubdir (x)
  "Move the file 'x' to the ${emacs-wiki-publishing-directory}/latex
folder.  This is done so that the resultant images do not clutter your
main publishing directory. Old files with the prefix are also deleted."
  (if (and (file-exists-p x)
	   (file-directory-p (concat emacs-wiki-publishing-directory "/latex")))
      (progn
	(let* ((pubdir (concat emacs-wiki-publishing-directory "/latex/"))
	       (files (file-expand-wildcards (concat pubdir prefix "_*") t)))
	  (copy-file x (concat pubdir (file-name-nondirectory x)) t)
	  (delete-file x)
	  (concat "./latex/" (file-name-nondirectory x)))
	)
    (message "The latex folder does not exist!")
    ))



(defun gs-latex-tag (beg end attrs highlight-p)
 (if highlight-p
      ;; how the hell do I highlight TeX ??
      (goto-char end)
    (let ((end-marker (set-marker (make-marker) (1+ end))))
      (save-restriction
	(narrow-to-region beg end)
	
	(let* ((text (buffer-substring-no-properties beg end))
               ;; the prefix given to the image file.
	       (prefix (cdr (assoc "prefix" attrs))) 
	       ;; preamble (for extra options)
	       (preamble (cdr (assoc "preamble" attrs))) 
	       ;; display inline or as a block
	       (display (car (assoc "inline" attrs))) 
	       )
	  (delete-region beg end)
	  (goto-char (point-min))
	  (if (not (file-directory-p (concat emacs-wiki-publishing-directory "/latex")))
	      (make-directory (concat emacs-wiki-publishing-directory "/latex")))
	  (insert "<img src=\"" 
		  (gs-latex2png-move2pubdir (latex2png text prefix preamble))
		  "\" alt=\"latex2png equation\" " 
		  (if display (concat "class=\"latex-inline\"")
		      (concat "class=\"latex-display\"")
		      )
		  " />")
	  (insert "<!-- " text "-->")
	  (goto-char (point-max))
	  )))))

(defun latex2png (math prefix preamble)
  "Convert the $math into a png with a $prefix"
  (if (null preamble)
      (setq preamble " "))

  (let ((texfile (concat temporary-file-directory prefix "_"  (format "%d" (abs (sxhash math)))))
	(oldcddir default-directory))
    (with-temp-file (concat texfile ".tex")
      (insert (concat "\\documentclass{article}
\\usepackage{fullpage}
\\usepackage{amssymb}
\\usepackage[usenames]{color}
\\usepackage{amsmath}
\\usepackage{latexsym}
\\usepackage[mathscr]{eucal}\n" preamble 
"\n\\pagestyle{empty}
\\begin{document}" 
"{"
 math
"}\n"
"\n\\end{document}\n\n")))
      
    (cd "/tmp")
    (call-process "latex" nil nil nil texfile)

    (if (file-exists-p (concat texfile ".dvi"))
	(progn
	  (shell-command-to-string (concat "dvipng " texfile ".dvi -E "
					   " -fg " gs-latex2png-fg 
					   " -bg " gs-latex2png-bg " -T tight" 
					   " -x " (format  "%s" (* gs-latex2png-scale-factor 1000))
					   " -y " (format  "%s" (* gs-latex2png-scale-factor 1000))
					   " -o " texfile ".png"))
	  (if (file-exists-p (concat texfile ".png"))
	      (progn
		(delete-file (concat texfile ".dvi"))
		(delete-file (concat texfile ".tex"))
		(delete-file (concat texfile ".aux"))
		(delete-file (concat texfile ".log"))
		(cd oldcddir)
		(concat texfile ".png")
		)
	    (message "Failed to create png file")
	    ))
      (message (concat "Failed to create dvi file " texfile))
      )))
