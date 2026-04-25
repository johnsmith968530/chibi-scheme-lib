;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/com/m0x13/RCS/dropbox.sld,v $
;; $Date: 2026/04/25 06:54:17 $
;; $Revision: 1.1 $

(define-library (com m0x13 dropbox)
  (export dropbox-dir)
  (import (scheme base)
          (scheme process-context)
          (srfi 166))

  (begin

    (define dropbox-dir
      (show #f (get-environment-variable "HOME")
                 "/Dropbox/"))

  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
