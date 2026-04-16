;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/RCS/envy.sld,v $
;; $Date: 2026/04/16 18:46:54 $
;; $Revision: 1.1 $

(define-library (envy)
  (export envy)
  (import (scheme base)
          (scheme process-context)
          (chibi process)
          (chibi json))

  (begin

    (define (envy . args)
      (let* ((cmd (cons "envy" args))
             (output (process->string cmd)))
        (string->json output)))

  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
