;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/RCS/stardate.sld,v $
;; $Date: 2026/04/16 18:49:14 $
;; $Revision: 1.1 $

(define-library (stardate)
  (export stardate)
  (import (scheme base)
          (scheme process-context)
          (chibi process))

  (begin

    (define (stardate . args)
      (let* ((cmd (cons "stardate" args)))
             (process->string cmd)))

  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
