;; Run like this:

;;    $ emacs --script file-to-render type

;; where type is one of pdf, ascii or html

;; On a new system, this needs to be changed to the location of
;; org-mode
(push "c:/Users/evansw/.emacs.d/elpa/org-20130919" load-path)

(if (not (= (length argv) 2))
    (error "Wrong number of arguments"))

(setq file (expand-file-name (car argv)))
(unless (file-exists-p file)
  (error "File does not exist"))

(setq format (cadr argv))

(unless (member format '("latex" "ascii" "html" "odt"))
  (error "Target format not recognized"))

(require 'ox-publish)
(require 'ox-odt)
(setq org-odt-data-dir "c:/Users/evansw/.emacs.d/elpa/org-20130919/etc/")


(defun render-to-latex ()
  (switch-to-buffer (find-file file))
  (org-latex-export-to-latex))

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
      ((string-equal format "ascii")
       (render-to-ascii))
      ((string-equal format "html")
       (render-to-html))
      ((string-equal format "odt")
       (render-to-odt)))
