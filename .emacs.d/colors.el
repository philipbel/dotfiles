;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Color theme
;; http://www.emacswiki.org/cgi-bin/wiki?ColorTheme#ColorTheme1
;; see <http://code.google.com/p/gnuemacscolorthemetest/>
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

;; (load-theme 'zenburn t)
