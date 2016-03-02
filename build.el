;; Run like this:

;;    $ emacs --script file-to-render type

;; where type is one of ascii, latex, md, odt or html

;; TODO: Get this information automatically.  On a new system, this
;; needs to be changed to the location of org-mode
(push "c:/Users/evansw/.emacs.d/elpa/org-20130919" load-path)
(push "c:/Users/evansw/bin/emacs/lisp/org" load-path)
;(setq org-odt-data-dir "c:/Users/evansw/.emacs.d/elpa/org-20130919/etc/")
(require 'org)
(setq make-backup-files nil) 

(if (not (= (length argv) 2))
    (error "Wrong number of arguments"))

(setq file (expand-file-name (car argv)))
(unless (file-exists-p file)
  (error "File does not exist"))

(setq format (cadr argv))

(unless (member format '("latex" "ascii" "html" "odt" "md"))
  (error "Target format not recognized"))

(require 'ox-publish)
(require 'ox-odt)

(defun render-to-latex ()
  (switch-to-buffer (find-file file))
  (org-latex-export-to-latex))

(defun render-to-markdown ()
  (switch-to-buffer (find-file file))
  (org-md-export-to-markdown))

(defun render-to-ascii ()
  (switch-to-buffer (find-file file))
  (org-ascii-export-to-ascii))

(defun render-to-html ()
  (switch-to-buffer (find-file file))
  (org-html-export-to-html))

(defun render-to-odt ()
  (switch-to-buffer (find-file file))
  (org-odt-export-to-odt))

(cond ((string-equal format "latex") 
       (render-to-latex))
      ((string-equal format "md")
       (render-to-markdown))
      ((string-equal format "ascii")
       (render-to-ascii))
      ((string-equal format "html")
       (render-to-html))
      ((string-equal format "odt")
       (render-to-odt)))
