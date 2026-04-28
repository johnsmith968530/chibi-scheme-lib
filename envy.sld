;; $Source: /home/x/Dropbox/2/src/chibi-scheme/lib/RCS/envy.sld,v $
;; $Date: 2026/04/28 00:40:51 $
;; $Revision: 1.2 $

(define-library (envy)
  (export envy)
  (import (scheme base)
          (scheme process-context)
          (chibi process)
          ; https://srfi.schemers.org/srfi-130/srfi-130.html
          (srfi 130) ; provides string-trim-right
          (chibi json))

  (begin

    (define (envy . args)
      (let* ((cmd (cons "envy" args))
             (output (process->string cmd)))
        ; (string->json output)))
        (string-trim-right output)))

  ))

;; vim: set et ff=unix ft=scheme lisp nocp sts=2 sw=2 ts=2:
